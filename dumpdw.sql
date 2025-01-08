-- Diagrama de Entidade-Relacionamento (DER)
-- Estrutura do esquema estrela com tabelas de fato e dimensões

-- Tabela de Fato: fato_transacoes
CREATE TABLE dw.fato_transacoes (
    operid VARCHAR(50) NOT NULL,
    cdfil VARCHAR(50) NOT NULL,
    cdcli VARCHAR(50),
    cdpro INTEGER,
    fornecid INTEGER,
    dtent DATE,
    dtemi DATE,
    dtsai DATE,
    nrnot VARCHAR(50),
    nrped VARCHAR(50),
    vrtot NUMERIC(10,2),
    vrfre NUMERIC(10,2),
    vrliquido NUMERIC(10,2),
    quantidade NUMERIC(10,2),
    pruni NUMERIC(10,2),
    pruniliq NUMERIC(10,2),
    prcusto NUMERIC(10,2),
    ptlucro NUMERIC(10,2),
    tppag VARCHAR(50),
    vrrec NUMERIC(10,2),
    vrred NUMERIC(10,2),
    vrcxa NUMERIC(10,2),
    vrtotipi NUMERIC(10,2),
    vrtotprod NUMERIC(10,2),
    vrtrc NUMERIC(10,2),
    vrcta NUMERIC(10,2),
    cdser VARCHAR(50),
    statusenotas VARCHAR(50),
    hrsaidas TIME,
    itemid VARCHAR(50),
    PRIMARY KEY (operid, itemid),
    FOREIGN KEY (cdfil) REFERENCES dw.dim_filiais (cdfil),
    FOREIGN KEY (cdcli) REFERENCES dw.dim_clientes (cdcli),
    FOREIGN KEY (cdpro) REFERENCES dw.dim_produtos (cdpro),
    FOREIGN KEY (fornecid) REFERENCES dw.dim_fornecedores (fornecid)
);

-- Dimensão: dim_clientes
CREATE TABLE dw.dim_clientes (
    cdcli VARCHAR(50) PRIMARY KEY,
    cdfil VARCHAR(50),
    tpcli VARCHAR(50),
    nrcnpj VARCHAR(20),
    nrinscr VARCHAR(20),
    nomecli VARCHAR(255),
    dtnas DATE,
    ecivil VARCHAR(20),
    profis VARCHAR(100),
    dtcad DATE
);

-- Dimensão: dim_produtos
CREATE TABLE dw.dim_produtos (
    cdpro INTEGER PRIMARY KEY,
    descrprd TEXT,
    descrdet TEXT,
    descr TEXT,
    situa VARCHAR(20),
    grupo VARCHAR(50),
    setor VARCHAR(50),
    linha VARCHAR(50),
    curva CHAR(1),
    unida VARCHAR(10),
    unirc VARCHAR(10),
    moeda VARCHAR(3),
    prcom NUMERIC(18,2),
    prven NUMERIC(18,2),
    dtcad DATE,
    nrnot VARCHAR(20),
    cdicm NUMERIC(5,2),
    cdipi NUMERIC(5,2),
    domax NUMERIC(18,4),
    unidm VARCHAR(10),
    unidmine VARCHAR(10),
    domind NUMERIC(18,4),
    unidminde VARCHAR(10),
    dtalt DATE,
    hralt TIME,
    cdproh VARCHAR(20)
);

-- Dimensão: dw.dim_fornecedores
CREATE TABLE dw.dim_fornecedores (
    fornecid INTEGER PRIMARY KEY,
    razao VARCHAR(255),
    nrcnpj VARCHAR(20),
    fanta VARCHAR(255),
    munic VARCHAR(255),
    unfed VARCHAR(2)
);


-- Dimensão: dw.dim_filiais
CREATE TABLE dw.dim_filiais (
    id_filial SERIAL PRIMARY KEY,
    cdfil VARCHAR(50) NOT NULL UNIQUE,
    descrfil TEXT
);


CREATE TABLE dw.dim_tempo (
    id_tempo SERIAL PRIMARY KEY,
    data DATE NOT NULL UNIQUE,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    dia INTEGER NOT NULL,
    trimestre INTEGER NOT NULL,
    semestre INTEGER NOT NULL,
    nome_mes VARCHAR(20),
    nome_dia_semana VARCHAR(20),
    dia_semana INTEGER, -- 0 (domingo) a 6 (sábado)
    eh_fim_de_semana BOOLEAN
);
ALTER TABLE dw.fato_transacoes ADD COLUMN id_tempo_dtent INTEGER;
ALTER TABLE dw.fato_transacoes ADD CONSTRAINT fk_tempo_dtent FOREIGN KEY (id_tempo_dtent) REFERENCES dw.dim_tempo (id_tempo);
