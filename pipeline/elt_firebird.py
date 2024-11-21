import firebirdsql
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor


load_dotenv()

# Configurações de conexão do Firebird
firebird_config = {
    'host': os.getenv("FIREBIRD_HOST"),
    'database': os.getenv("FIREBIRD_DATABASE"),
    'user': os.getenv("FIREBIRD_USER"),
    'password': os.getenv("FIREBIRD_PASSWORD"),
    'charset': 'WIN1252'
}

# Configurações de conexão do PostgreSQL com pool de conexões
engine = create_engine(
    f'postgresql+psycopg2://{os.getenv("POSTGRES_USER")}:{os.getenv("POSTGRES_PASSWORD")}@{os.getenv("POSTGRES_HOST")}:{os.getenv("POSTGRES_PORT")}/{os.getenv("POSTGRES_DB")}',
    pool_size=5, max_overflow=10
)

# Função para listar todas as tabelas do Firebird
def list_firebird_tables():
    conn = firebirdsql.connect(**firebird_config)
    cursor = conn.cursor()
    cursor.execute("SELECT RDB$RELATION_NAME FROM RDB$RELATIONS WHERE RDB$SYSTEM_FLAG = 0;")
    tables = [row[0].strip() for row in cursor.fetchall()]
    conn.close()
    return tables

# Função para contar registros da tabela
def count_records(table_name):
    conn = firebirdsql.connect(**firebird_config)
    cursor = conn.cursor()
    cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
    count = cursor.fetchone()[0]
    conn.close()
    return count

# Função para carregar dados em blocos usando COPY
def load_data_using_copy(df, table_name):
    csv_buffer = df.to_csv(index=False, header=False)
    conn = engine.raw_connection()
    cursor = conn.cursor()
    
    try:
        cursor.copy_expert(f"COPY {table_name} FROM STDIN WITH CSV", csv_buffer)
        conn.commit()
    except Exception as e:
        print(f"Erro ao carregar dados para {table_name}: {e}")
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

# Função para extrair e carregar dados do Firebird para o PostgreSQL
def extract_and_load_data_in_chunks(query, table_name, block_size=10000):
    total_records = count_records(table_name)
    conn = firebirdsql.connect(**firebird_config)
    cursor = conn.cursor()
    columns = None
    offset = 0

    with tqdm(total=total_records, desc=f"Carregando dados de {table_name}") as pbar:
        while offset < total_records:
            paginated_query = f"{query} ROWS {block_size} TO {offset + block_size}"
            cursor.execute(paginated_query)
            rows = cursor.fetchall()

            if columns is None:
                columns = [desc[0].strip() for desc in cursor.description]

            if not rows:
                break

            # Criar DataFrame para o bloco atual e carregá-lo usando COPY
            df = pd.DataFrame(rows, columns=columns)
            load_data_using_copy(df, table_name)
            
            offset += len(rows)
            pbar.update(len(rows))

    conn.close()

if __name__ == "__main__":
    # Listar todas as tabelas do Firebird
    tables = list_firebird_tables()
    print("Tabelas disponíveis no Firebird:", tables)
    
    # Exemplo de queries
    queries = {
        'FC15110': 'SELECT * FROM FC15110',
        
        
    }

    # Executar a carga de dados para cada tabela em paralelo
    with ThreadPoolExecutor(max_workers=3) as executor:
        futures = [
            executor.submit(extract_and_load_data_in_chunks, query, table_name)
            for table_name, query in queries.items() if table_name in tables
        ]
        
        for future in futures:
            future.result()  # Aguarda a conclusão de cada thread
