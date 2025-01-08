CREATE TABLE dw.dim_clientes (
    id_cliente SERIAL PRIMARY KEY,
    cdcli VARCHAR(50) NOT NULL,
    tpcli VARCHAR(50),
    nrcnpj VARCHAR(20),
    nrinscr VARCHAR(20),
    nomecli VARCHAR(255),
    dtnas DATE,
    ecivil VARCHAR(20),
    profis VARCHAR(100),
    dtcad DATE,
    CONSTRAINT unique_cdcli UNIQUE (cdcli)
);

CREATE TABLE dw.dim_filiais (
    id_filial SERIAL PRIMARY KEY,
    cdfil VARCHAR(50) NOT NULL,
    descrfil TEXT,
    CONSTRAINT unique_cdfil UNIQUE (cdfil)
);

CREATE TABLE dw.dim_produtos (
    id_produto SERIAL PRIMARY KEY,
    cdpro INTEGER NOT NULL,
    descrprd TEXT,
    grupo VARCHAR(50),
    setor VARCHAR(50),
    linha VARCHAR(50),
    curva CHAR(1),
    prcom NUMERIC(18,2),
    prven NUMERIC(18,2),
    dtcad DATE,
    CONSTRAINT unique_cdpro UNIQUE (cdpro)
);

CREATE TABLE dw.dim_fornecedores (
    id_fornecedor SERIAL PRIMARY KEY,
    fornecid INTEGER NOT NULL,
    razao VARCHAR(255),
    nrcnpj VARCHAR(20),
    fanta VARCHAR(255),
    munic VARCHAR(255),
    unfed VARCHAR(2),
    CONSTRAINT unique_fornecid UNIQUE (fornecid)
);

CREATE TABLE dw.dim_tempo (
    id_tempo SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    nome_mes VARCHAR(20),
    trimestre INTEGER,
    semestre INTEGER,
    dia INTEGER NOT NULL,
    nome_dia_semana VARCHAR(20),
    dia_semana INTEGER,
    semana_ano INTEGER,
    eh_fim_semana BOOLEAN,
    eh_feriado BOOLEAN
);


CREATE TABLE dw.fato_vendas (
    id_fato_venda SERIAL PRIMARY KEY,
    cdfil VARCHAR(50) NOT NULL,
    operid VARCHAR(50) NOT NULL,
    cdcli VARCHAR(50),
    itemid VARCHAR(50) NOT NULL,
    cdpro INTEGER NOT NULL,
    vr_tot NUMERIC(10,2),
    vr_dsc NUMERIC(10,2),
    quant NUMERIC(10,2),
    pr_uni NUMERIC(10,2),
    vr_liq NUMERIC(10,2),
    tppag VARCHAR(50),
    dt_ope DATE,
    FOREIGN KEY (cdfil) REFERENCES dw.dim_filiais(cdfil) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cdcli) REFERENCES dw.dim_clientes(cdcli) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (cdpro) REFERENCES dw.dim_produtos(cdpro) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE dw.fato_notas_fiscais (
    id_fato_nf SERIAL PRIMARY KEY,
    cdfil VARCHAR(50) NOT NULL,
    fornecid INTEGER NOT NULL,
    nrnot VARCHAR(50),
    cdpro INTEGER NOT NULL,
    itemid VARCHAR(50) NOT NULL,
    vr_tot NUMERIC(10,2),
    vr_frete NUMERIC(10,2),
    quant NUMERIC(10,2),
    pr_uni NUMERIC(10,2),
    dt_ent DATE,
    FOREIGN KEY (cdfil) REFERENCES dw.dim_filiais(cdfil) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (fornecid) REFERENCES dw.dim_fornecedores(fornecid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cdpro) REFERENCES dw.dim_produtos(cdpro) ON UPDATE CASCADE ON DELETE CASCADE
);




CREATE TABLE dw.dim_tempo (
    id_tempo SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    nome_mes VARCHAR(20),
    trimestre INTEGER,
    semestre INTEGER,
    dia INTEGER NOT NULL,
    nome_dia_semana VARCHAR(20),
    dia_semana INTEGER,
    semana_ano INTEGER,
    eh_fim_semana BOOLEAN,
    eh_feriado BOOLEAN
);

DO $$
DECLARE
    data_atual DATE := '2020-01-01'; -- Data inicial
    data_final DATE := '2030-12-31'; -- Data final
BEGIN
    WHILE data_atual <= data_final LOOP
        INSERT INTO dw.dim_tempo (
            data, ano, mes, nome_mes, trimestre, semestre, dia, nome_dia_semana, dia_semana, semana_ano, eh_fim_semana, eh_feriado
        ) VALUES (
            data_atual,
            EXTRACT(YEAR FROM data_atual),
            EXTRACT(MONTH FROM data_atual),
            TO_CHAR(data_atual, 'Month'),
            EXTRACT(QUARTER FROM data_atual),
            CASE WHEN EXTRACT(MONTH FROM data_atual) IN (1, 2, 3, 4, 5, 6) THEN 1 ELSE 2 END,
            EXTRACT(DAY FROM data_atual),
            TO_CHAR(data_atual, 'Day'),
            EXTRACT(DOW FROM data_atual),
            EXTRACT(WEEK FROM data_atual),
            CASE WHEN EXTRACT(DOW FROM data_atual) IN (0, 6) THEN TRUE ELSE FALSE END,
            FALSE -- Configure feriados manualmente se necessário
        );
        data_atual := data_atual + INTERVAL '1 day';
    END LOOP;
END $$;
