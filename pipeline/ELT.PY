import firebirdsql
import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os
import io
from tqdm import tqdm
import logging

class DatabaseMigration:
    def __init__(self):
        load_dotenv()

        # Configuração do Firebird
        self.firebird_config = {
            'host': os.getenv("FIREBIRD_HOST"),
            'database': os.getenv("FIREBIRD_DATABASE"),
            'user': os.getenv("FIREBIRD_USER"),
            'password': os.getenv("FIREBIRD_PASSWORD"),
            'charset': 'ISO8859_1'
        }

        # Configuração do PostgreSQL
        self.engine = create_engine(
            f'postgresql+psycopg2://{os.getenv("POSTGRES_USER")}:{os.getenv("POSTGRES_PASSWORD")}@{os.getenv("POSTGRES_HOST")}:{os.getenv("POSTGRES_PORT")}/{os.getenv("POSTGRES_DB")}',
            pool_size=5, max_overflow=10
        )

        # Certificar que o schema temporário existe no PostgreSQL
        self.ensure_temporary_schema()

        # Configuração de logging
        logging.basicConfig(filename='migration.log', level=logging.INFO,
                            format='%(asctime)s - %(levelname)s - %(message)s')

    def ensure_temporary_schema(self):
        with self.engine.connect() as connection:
            connection.execute(text("CREATE SCHEMA IF NOT EXISTS temporary;"))
            connection.commit()

    def create_table_in_postgres(self, table_name, columns):
        column_definitions = ", ".join([f'"{col}" TEXT' for col in columns])
        create_table_query = f'CREATE TABLE IF NOT EXISTS temporary."{table_name}" ({column_definitions});'
        
        with self.engine.connect() as connection:
            connection.execute(text(create_table_query))
            connection.commit()

    def list_firebird_tables(self):
        with firebirdsql.connect(**self.firebird_config) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT RDB$RELATION_NAME FROM RDB$RELATIONS WHERE RDB$SYSTEM_FLAG = 0;")
            tables = [row[0].strip() for row in cursor.fetchall()]
        return tables

    def sanitize_dataframe(self, df):
        # Remover caracteres nulos (0x00) em células de texto, mantendo valores NULL inalterados
        return df.apply(lambda col: col.map(lambda x: x.replace('\x00', '') if isinstance(x, str) else x))

    def load_data_using_copy(self, df, table_name):
        df = self.sanitize_dataframe(df)  # Remover caracteres nulos

        csv_buffer = io.StringIO()
        df.to_csv(csv_buffer, index=False, header=False)
        csv_buffer.seek(0)

        conn = self.engine.raw_connection()
        cursor = conn.cursor()

        try:
            cursor.copy_expert(f'COPY temporary."{table_name}" FROM STDIN WITH CSV', csv_buffer)
            conn.commit()
        except Exception as e:
            print(f"Erro ao carregar bloco para temporary.{table_name}: {e}")
            conn.rollback()
            self.load_rows_individually(df, table_name)  # Tenta carregar registro por registro
        finally:
            cursor.close()
            conn.close()

    def load_rows_individually(self, df, table_name):
        conn = self.engine.raw_connection()
        cursor = conn.cursor()

        for index, row in df.iterrows():
            try:
                csv_buffer = io.StringIO()
                row.to_frame().T.to_csv(csv_buffer, index=False, header=False)
                csv_buffer.seek(0)
                cursor.copy_expert(f'COPY temporary."{table_name}" FROM STDIN WITH CSV', csv_buffer)
                conn.commit()
            except Exception as e:
                print(f"Erro ao carregar linha {index + 1} da tabela {table_name}: {e}")
                conn.rollback()
        cursor.close()
        conn.close()

    def get_last_processed_row_count(self, table_name):
        try:
            with open(f'{table_name}_last_processed.txt', 'r') as file:
                last_processed = int(file.read().strip())
            return last_processed
        except FileNotFoundError:
            return 0

    def update_last_processed_row_count(self, table_name, last_row_count):
        with open(f'{table_name}_last_processed.txt', 'w') as file:
            file.write(str(last_row_count))

    def extract_and_load_data_in_chunks(self, table_name, block_size=10000):
        last_processed_row_count = self.get_last_processed_row_count(table_name)
        
        with firebirdsql.connect(**self.firebird_config) as conn:
            cursor = conn.cursor()
            cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
            total_records = cursor.fetchone()[0]

            cursor.execute(f"SELECT * FROM {table_name} ROWS 1 TO 1")  # pegar cabeçalhos
            columns = [desc[0].strip() for desc in cursor.description]

        self.create_table_in_postgres(table_name, columns)

        offset = last_processed_row_count
        with tqdm(total=total_records - last_processed_row_count, desc=f"Carregando dados de {table_name}") as pbar:
            while offset < total_records:
                with firebirdsql.connect(**self.firebird_config) as conn:
                    cursor = conn.cursor()
                    paginated_query = f"SELECT * FROM {table_name} ROWS {offset + 1} TO {offset + block_size}"
                    cursor.execute(paginated_query)
                    rows = cursor.fetchall()

                    if not rows:
                        break

                    df = pd.DataFrame(rows, columns=columns)
                    self.load_data_using_copy(df, table_name)

                    offset += len(rows)
                    pbar.update(len(rows))

        self.update_last_processed_row_count(table_name, offset)

    def run_migration(self, tables_to_load):
        available_tables = self.list_firebird_tables()
        tables_to_load = [table for table in tables_to_load if table in available_tables]

        print("Tabelas disponíveis no Firebird:", available_tables)
        print("Tabelas a serem carregadas:", tables_to_load)

        for table in tables_to_load:
            print(f"Carregando dados da tabela {table} para o PostgreSQL...")
            self.extract_and_load_data_in_chunks(table)
            print(f"Tabela {table} carregada com sucesso!")


if __name__ == "__main__":
    migration = DatabaseMigration()
    # Lista de todas as tabelas a serem carregadas diariamente
    tables_to_load = [
        "FC31100",
        "FC0H100",
        "FC0D100",
        "FC0D000",
        "FC01000",
        "FC02000",
        "FC02200",
        "FC02300",
        "FC03000",
        "FC03100",
        "FC03140",
        "FC03160",
        "FC03190",
        "FC04000",
        "FC04300",
        "FC05900",
        "FC05910",
        "FC07000",
        "FC07100",
        "FC1B100",
        "FC11000",
        "FC11100",
        "FC12100",
        "FC12110",
        "FC13000",
        "FC13100",
        "FC15000",
        "FC15100",
        "FC15110",
        "FC16000",
        "FC31110",
        "FC31111",
        "FC31200",
        "FC32110"
    ]
    migration.run_migration(tables_to_load)
