CREATE TABLE dw.dim_tempo (
    id_data SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    dia INTEGER NOT NULL,
    trimestre INTEGER NOT NULL,
    semana INTEGER NOT NULL,
    dia_da_semana VARCHAR(10) NOT NULL
);

CREATE TABLE dw.dim_clientes (
    id_cliente SERIAL PRIMARY KEY,
    cdcli VARCHAR(50) NOT NULL,
    nomecli VARCHAR(255),
    tpsex CHAR(1),
    dtnas DATE
);

CREATE TABLE dw.dim_produtos (
    id_produto SERIAL PRIMARY KEY,
    cdpro INTEGER NOT NULL,
    descrprd TEXT,
    grupo VARCHAR(50),
    setor VARCHAR(50),
    linha VARCHAR(50),
    curva CHAR(1),
    unida VARCHAR(10)
);

CREATE TABLE dw.dim_fornecedores (
    id_fornecedor SERIAL PRIMARY KEY,
    fornecid INTEGER NOT NULL,
    razao VARCHAR(255),
    nrcnpj VARCHAR(20),
    fanta VARCHAR(255),
    munic VARCHAR(255),
    unfed VARCHAR(2)
);

CREATE TABLE dw.dim_filiais (
    id_filial SERIAL PRIMARY KEY,
    cdfil VARCHAR(50) NOT NULL,
    descrfil TEXT
);




CREATE TABLE dw.fato_vendas (
    id_fato SERIAL PRIMARY KEY,
    id_filial INTEGER REFERENCES dw.dim_filiais(id_filial),
    id_cliente INTEGER REFERENCES dw.dim_clientes(id_cliente),
    id_produto INTEGER REFERENCES dw.dim_produtos(id_produto),
    id_tempo INTEGER REFERENCES dw.dim_tempo(id_data),
    vrtot NUMERIC(18,2),
    vrdsc NUMERIC(18,2),
    vrliq NUMERIC(18,2),
    quant NUMERIC(18,2),
    pruni NUMERIC(18,2)
);


CREATE TABLE dw.fato_compras (
    id_fato SERIAL PRIMARY KEY,
    id_filial INTEGER REFERENCES dw.dim_filiais(id_filial),
    id_fornecedor INTEGER REFERENCES dw.dim_fornecedores(id_fornecedor),
    id_produto INTEGER REFERENCES dw.dim_produtos(id_produto),
    id_tempo INTEGER REFERENCES dw.dim_tempo(id_data),
    vrtot NUMERIC(18,2),
    vrdsc NUMERIC(18,2),
    quant NUMERIC(18,2),
    pruni NUMERIC(18,2),
    vfrete NUMERIC(18,2)
);

----------------inserts-----------------------------------------------------
INSERT INTO dw.dim_filiais (cdfil, descrfil)
SELECT 
    f."CDFIL",
    f."DESCRFIL"
FROM temporary."FC01000" f
WHERE NOT EXISTS (
    SELECT 1
    FROM dw.dim_filiais df
    WHERE df.cdfil = f."CDFIL"
);



INSERT INTO dw.dim_clientes (cdcli, nomecli, tpsex, dtnas)
SELECT 
    c."CDCLI",
    c."NOMECLI",
    c."TPSEX",
    c."DTNAS"
FROM gold.clientes c
WHERE NOT EXISTS (
    SELECT 1
    FROM dw.dim_clientes dc
    WHERE dc.cdcli = c."CDCLI"
);


INSERT INTO dw.dim_produtos (cdpro, descrprd, grupo, setor, linha, curva, unida)
SELECT 
    p."CDPRO",
    p."DESCRPRD",
    p."GRUPO",
    p."SETOR",
    p."LINHA",
    p."CURVA",
    p."UNIDA"
FROM gold.produtos p
WHERE NOT EXISTS (
    SELECT 1
    FROM dw.dim_produtos dp
    WHERE dp.cdpro = p."CDPRO"
);


INSERT INTO dw.dim_fornecedores (fornecid, razao, nrcnpj, fanta, munic, unfed)
SELECT 
    f.fornecid,
    f.razao,
    f.nrcnpj,
    f.fanta,
    f.munic,
    f.unfed
FROM gold.fornecedores f
WHERE NOT EXISTS (
    SELECT 1
    FROM dw.dim_fornecedores df
    WHERE df.fornecid = f.fornecid
);


INSERT INTO dw.dim_filiais (cdfil, descrfil)
SELECT DISTINCT 
    f.cdfil,
    f.descrfil
FROM temporary."FC01000" f
WHERE NOT EXISTS (
    SELECT 1 FROM dw.dim_filiais df WHERE df.cdfil = f.cdfil
);


INSERT INTO dw.fato_vendas (id_filial, id_cliente, id_produto, id_tempo, vrtot, vrdsc, vrliq, quant, pruni)
SELECT 
    (SELECT id_filial FROM dw.dim_filiais WHERE cdfil = v."CDFIL"),
    (SELECT id_cliente FROM dw.dim_clientes WHERE cdcli = v."CDCLI"),
    (SELECT id_produto FROM dw.dim_produtos WHERE cdpro = v."CDPRO"),
    (SELECT id_data FROM dw.dim_tempo WHERE data = v."DTOPE"),
    v."VRTOT",
    v."VRDSCV",
    v."VRLIQ",
    v."QUANT",
    v."PRUNI"
FROM gold.combined_vendas v
WHERE NOT EXISTS (
    SELECT 1
    FROM dw.fato_vendas fv
    WHERE fv.id_filial = (SELECT id_filial FROM dw.dim_filiais WHERE cdfil = v."CDFIL")
      AND fv.id_cliente = (SELECT id_cliente FROM dw.dim_clientes WHERE cdcli = v."CDCLI")
      AND fv.id_produto = (SELECT id_produto FROM dw.dim_produtos WHERE cdpro = v."CDPRO")
      AND fv.id_tempo = (SELECT id_data FROM dw.dim_tempo WHERE data = v."DTOPE")
);




INSERT INTO dw.fato_compras (id_filial, id_fornecedor, id_produto, id_tempo, vrtot, vrdsc, quant, pruni, vfrete)
SELECT 
    (SELECT id_filial FROM dw.dim_filiais WHERE cdfil = nf."CDFIL"),
    (SELECT id_fornecedor FROM dw.dim_fornecedores WHERE fornecid = nf."FORNECID"),
    (SELECT id_produto FROM dw.dim_produtos WHERE cdpro = nf."CDPRO"),
    (SELECT id_data FROM dw.dim_tempo WHERE data = nf."DTENT"),
    nf."VRTOT",
    nf."VRDSC",
    nf."QUANT",
    nf."PRUNI",
    nf."VFRETE"
FROM gold.combined_notasfiscais nf
WHERE NOT EXISTS (
    SELECT 1
    FROM dw.fato_compras fc
    WHERE fc.id_filial = (SELECT id_filial FROM dw.dim_filiais WHERE cdfil = nf."CDFIL")
      AND fc.id_fornecedor = (SELECT id_fornecedor FROM dw.dim_fornecedores WHERE fornecid = nf."FORNECID")
      AND fc.id_produto = (SELECT id_produto FROM dw.dim_produtos WHERE cdpro = nf."CDPRO")
      AND fc.id_tempo = (SELECT id_data FROM dw.dim_tempo WHERE data = nf."DTENT")
);



INSERT INTO dw.dim_tempo (data, ano, mes, dia, trimestre, semana, dia_da_semana)
SELECT DISTINCT 
    data,
    EXTRACT(YEAR FROM data) AS ano,
    EXTRACT(MONTH FROM data) AS mes,
    EXTRACT(DAY FROM data) AS dia,
    CEIL(EXTRACT(MONTH FROM data) / 3.0) AS trimestre,
    EXTRACT(WEEK FROM data) AS semana,
    TO_CHAR(data, 'Day') AS dia_da_semana
FROM (
    SELECT DISTINCT dtope AS data FROM gold.combined_vendas
    UNION
    SELECT DISTINCT dtent AS data FROM gold.combined_notasfiscais
) AS datas
WHERE NOT EXISTS (
    SELECT 1 FROM dw.dim_tempo WHERE dim_tempo.data = datas.data
);

