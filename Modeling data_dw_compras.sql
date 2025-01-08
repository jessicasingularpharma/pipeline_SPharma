CREATE TABLE dw_compras.dim_data (
    data_id SERIAL PRIMARY KEY,
    data DATE,
    ano INTEGER,
    mes INTEGER,
    dia INTEGER,
    semana INTEGER,
    trimestre INTEGER
);

-- Inserir dados na tabela dim_data
INSERT INTO dw_compras.dim_data (data, ano, mes, dia, semana, trimestre)
SELECT DISTINCT
    CAST("DTOPE" AS DATE),  -- Diretamente a coluna DTOPE, convertida para o tipo DATE
    EXTRACT(YEAR FROM CAST("DTOPE" AS DATE)) AS ano,
    EXTRACT(MONTH FROM CAST("DTOPE" AS DATE)) AS mes,
    EXTRACT(DAY FROM CAST("DTOPE" AS DATE)) AS dia,
    EXTRACT(WEEK FROM CAST("DTOPE" AS DATE)) AS semana,
    EXTRACT(QUARTER FROM CAST("DTOPE" AS DATE)) AS trimestre
FROM temporary."FC31100";



-------------tabela da FC31110------

CREATE TABLE dw_compras.dim_cliente (
    cliente_id SERIAL PRIMARY KEY, 
    cdcli INTEGER NOT NULL,
    cdfil INTEGER,
    tpcli CHAR(1),
    nrinscr VARCHAR(20),
    oerg VARCHAR(7),
    tpsex CHAR(1),
    nomecli VARCHAR(50),
    dtnas DATE,
    lcnas VARCHAR(20),
    ufnas CHAR(2),
    ecivil CHAR(1),
    profis VARCHAR(15),
    dtcad DATE,
    email VARCHAR(254),
    email2 VARCHAR(254),
    flagenv CHAR(1),
    ufrg CHAR(2),
    tpdoc CHAR(2),
    dtalt DATE
);

INSERT INTO dw_compras.dim_cliente (
    cdcli, cdfil, tpcli, nrinscr, oerg, tpsex, nomecli, dtnas, 
    lcnas, ufnas, ecivil, profis, dtcad, email, email2, 
    flagenv, ufrg, tpdoc, dtalt
)
SELECT DISTINCT
    CAST("CDCLI" AS INTEGER), 
    CAST("CDFIL" AS INTEGER),
    "TPCLI",
    "NRINSCR",
    "OERG",
    "TPSEX",
    "NOMECLI",
    CAST("DTNAS" AS DATE),
    "LCNAS",
    "UFNAS",
    "ECIVIL",
    "PROFIS",
    CAST("DTCAD" AS DATE),
    "EMAIL",
    "EMAIL2",
    "FLAGENV",
    "UFRG",
    "TPDOC",
    CAST("DTALT" AS DATE)
FROM temporary."FC07000"
WHERE "CDCLI" IS NOT NULL;


------------------------------------
-----------tabela-operacao------------
CREATE TABLE dw_compras.dim_operacao (
    operacao_id SERIAL PRIMARY KEY,
    operid INTEGER,
    tipo_pagamento CHAR(1),
    tipo_operacao CHAR(1)
);

-- Inserir dados na tabela dim_operacao
INSERT INTO dw_compras.dim_operacao (operid, tipo_pagamento, tipo_operacao)
SELECT DISTINCT 
    CAST("OPERID" AS INTEGER),  -- Convertendo "OPERID" para INTEGER
    "TPPAG",
    "TPOFV"
FROM temporary."FC31100"
WHERE "OPERID" IS NOT NULL;

-----tabelas filial---------
CREATE TABLE dw_compras.dim_filial (
    filial_id SERIAL PRIMARY KEY,
    cdfil INTEGER,
    nome_filial VARCHAR(255)
);

-- Inserir dados na tabela dim_filial
INSERT INTO dw_compras.dim_filial (cdfil, nome_filial)
SELECT DISTINCT 
    CAST("CDFIL" AS INTEGER),  -- Garantindo que "CDFIL" seja tratado como INTEGER
    'Filial ' || CAST("CDFIL" AS VARCHAR)  -- Convertendo "CDFIL" para VARCHAR para concatenar
FROM temporary."FC31100"
WHERE "CDFIL" IS NOT NULL;



----------------criação de tabelas fato----------------------
CREATE TABLE dw_compras.fato_operacao (
    fato_id SERIAL PRIMARY KEY,
    data_id INTEGER,
    cliente_id INTEGER,
    filial_id INTEGER,
    operacao_id INTEGER,
    valor_total NUMERIC(15,2),
    valor_desconto NUMERIC(15,2),
    valor_liquido NUMERIC(15,2),
    quantidade_total NUMERIC(10,2),
    CONSTRAINT FK_fato_operacao_data FOREIGN KEY (data_id) REFERENCES dw_compras.dim_data (data_id),
    CONSTRAINT FK_fato_operacao_cliente FOREIGN KEY (cliente_id) REFERENCES dw_compras.dim_cliente (cliente_id),
    CONSTRAINT FK_fato_operacao_filial FOREIGN KEY (filial_id) REFERENCES dw_compras.dim_filial (filial_id),
    CONSTRAINT FK_fato_operacao_operacao FOREIGN KEY (operacao_id) REFERENCES dw_compras.dim_operacao (operacao_id)
);

-- Inserir dados na tabela fato_operacao
INSERT INTO dw_compras.fato_operacao (data_id, cliente_id, filial_id, operacao_id, valor_total, valor_desconto, valor_liquido, quantidade_total)
SELECT 
    d.data_id,
    c.cliente_id,
    f.filial_id,
    o.operacao_id,
    SUM(CAST(fc."VRTOT" AS NUMERIC(15,2))) AS valor_total,    -- Convertendo para NUMERIC
    SUM(CAST(fc."VRDSC" AS NUMERIC(15,2))) AS valor_desconto,  -- Convertendo para NUMERIC
    SUM(CAST(fc."VRLIQ" AS NUMERIC(15,2))) AS valor_liquido,   -- Convertendo para NUMERIC
    SUM(CAST(fc."QTTOT" AS NUMERIC(10,2))) AS quantidade_total -- Convertendo para NUMERIC
FROM temporary."FC31100" fc
JOIN dw_compras.dim_data d ON d.data = CAST(fc."DTOPE" AS DATE)
JOIN dw_compras.dim_cliente c ON c.cdcli = CAST(REGEXP_REPLACE(fc."CDCLI", '\..*$', '') AS INTEGER)  -- Removendo parte decimal e convertendo para INTEGER
JOIN dw_compras.dim_filial f ON f.cdfil = CAST(REGEXP_REPLACE(fc."CDFIL", '\..*$', '') AS INTEGER)  -- Removendo parte decimal e convertendo para INTEGER
JOIN dw_compras.dim_operacao o ON o.operid = CAST(REGEXP_REPLACE(fc."OPERID", '\..*$', '') AS INTEGER)  -- Removendo parte decimal e convertendo para INTEGER
GROUP BY d.data_id, c.cliente_id, f.filial_id, o.operacao_id;

----------------------------------
-- Excluir a chave estrangeira se ela existir
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'dim_produtos_por_fornecedor_cdpro_fkey') THEN
        ALTER TABLE dw_compras.dim_produtos_por_fornecedor
        DROP CONSTRAINT dim_produtos_por_fornecedor_cdpro_fkey;
    END IF;
END $$;

-- Excluir a tabela dim_produtos existente
DROP TABLE IF EXISTS dw_compras.dim_produtos CASCADE;

-- Criar a tabela dim_produtos com a chave primária e restrição de unicidade
CREATE TABLE dw_compras.dim_produtos (
    produto_id SERIAL PRIMARY KEY,
    CDPRO INTEGER NOT NULL UNIQUE,  -- Adicionando a restrição de unicidade
    DESCRPRD CHARACTER VARYING,
    DESCR CHARACTER VARYING,
    GRUPO CHARACTER VARYING,
    SETOR CHARACTER VARYING,
    UNIDA CHARACTER VARYING
);

-- Inserir dados na tabela dim_produtos
INSERT INTO dw_compras.dim_produtos (CDPRO, DESCRPRD, DESCR, GRUPO, SETOR, UNIDA)
SELECT 
    CAST(temporary."FC03000"."CDPRO" AS INTEGER),          
    temporary."FC03000"."DESCRPRD", 
    temporary."FC03000"."DESCR",
    temporary."FC03000"."GRUPO",
    temporary."FC03000"."SETOR",
    temporary."FC03000"."UNIDA"
FROM temporary."FC03000";

-- Adicionar a chave estrangeira na tabela dim_produtos_por_fornecedor
ALTER TABLE dw_compras.dim_produtos_por_fornecedor
ADD CONSTRAINT dim_produtos_por_fornecedor_cdpro_fkey
FOREIGN KEY (cdpro) REFERENCES dw_compras.dim_produtos (CDPRO);

-----------fato itens--------------------------------------

CREATE TABLE dw_compras.fato_itens (
    fato_item_id SERIAL PRIMARY KEY,
    fato_id INTEGER,
    produto_id INTEGER,
    quantidade NUMERIC(15,4),
    preco_unitario NUMERIC(15,2),
    valor_desconto NUMERIC(15,2),
    valor_liquido NUMERIC(15,2),
    valor_total NUMERIC(15,2),
    CONSTRAINT FK_fato_itens_fato FOREIGN KEY (fato_id) REFERENCES dw_compras.fato_operacao (fato_id),
    CONSTRAINT FK_fato_itens_produto FOREIGN KEY (produto_id) REFERENCES dw_compras.dim_produtos (produto_id)
);

-- Inserir dados na tabela fato_itens
INSERT INTO dw_compras.fato_itens (fato_id, produto_id, quantidade, preco_unitario, valor_desconto, valor_liquido, valor_total)
SELECT 
    fo.fato_id,
    p.produto_id,
    CAST(fc."QUANT" AS NUMERIC(15,4)) AS quantidade,  -- Certifique-se de que está correto tipo numérico
    CAST(fc."PRUNI" AS NUMERIC(15,2)) AS preco_unitario,
    CAST(fc."VRDSC" AS NUMERIC(15,2)) AS valor_desconto,
    CAST(fc."VRLIQ" AS NUMERIC(15,2)) AS valor_liquido,
    CAST(fc."VRTOT" AS NUMERIC(15,2)) AS valor_total
FROM temporary."FC31110" fc
JOIN dw_compras.fato_operacao fo ON fo.data_id = (
    SELECT data_id 
    FROM dw_compras.dim_data 
    WHERE data = CAST(fc."DTOPE" AS DATE)  -- Convertendo fc."DTOPE" para DATE
)
JOIN dw_compras.dim_produtos p ON p.cdpro = CAST(fc."CDPRO" AS INTEGER)  -- Convertendo fc."CDPRO" para INTEGER
WHERE fc."CDPRO" IS NOT NULL;


-------requisicao das vendas da tabela FC31200------

CREATE TABLE dw_compras.dim_requisicao (
    requisicao_id SERIAL PRIMARY KEY,
    nrrqu INTEGER,
    nrcpmf INTEGER
);

-- Inserir dados na tabela dim_requisicao
INSERT INTO dw_compras.dim_requisicao (nrrqu, nrcpmf)
SELECT DISTINCT 
    CAST("NRRQU" AS INTEGER),  -- Converte "NRRQU" para INTEGER
    CAST("NRCPMF" AS INTEGER)  -- Converte "NRCPMF" para INTEGER
FROM temporary."FC31200"
WHERE "NRRQU" IS NOT NULL;
---------------------------------------------------------------

CREATE TABLE dw_compras.fato_venda_requisicao (
    fato_requisicao_id SERIAL PRIMARY KEY,
    data_id INTEGER,
    cliente_id INTEGER,
    filial_id INTEGER,
    operacao_id INTEGER,
    requisicao_id INTEGER,
    valor_total NUMERIC(15,2),
    valor_desconto NUMERIC(15,2),
    valor_liquido NUMERIC(15,2),
    quantidade_total NUMERIC(10,2),
    vr_rec NUMERIC(15,2),
    vr_dif_cx NUMERIC(15,2),
    CONSTRAINT FK_fato_venda_requisicao_data FOREIGN KEY (data_id) REFERENCES dw_compras.dim_data (data_id),
    CONSTRAINT FK_fato_venda_requisicao_cliente FOREIGN KEY (cliente_id) REFERENCES dw_compras.dim_cliente (cliente_id),
    CONSTRAINT FK_fato_venda_requisicao_filial FOREIGN KEY (filial_id) REFERENCES dw_compras.dim_filial (filial_id),
    CONSTRAINT FK_fato_venda_requisicao_operacao FOREIGN KEY (operacao_id) REFERENCES dw_compras.dim_operacao (operacao_id),
    CONSTRAINT FK_fato_venda_requisicao_requisicao FOREIGN KEY (requisicao_id) REFERENCES dw_compras.dim_requisicao (requisicao_id)
);

INSERT INTO dw_compras.fato_venda_requisicao (
    data_id, cliente_id, filial_id, operacao_id, requisicao_id, 
    valor_total, valor_desconto, valor_liquido, quantidade_total, 
    vr_rec, vr_dif_cx
)
SELECT 
    d.data_id,
    c.cliente_id,
    f.filial_id,
    o.operacao_id,
    r.requisicao_id,
    SUM(CAST(fc."VRTOT" AS NUMERIC(15,2))) AS valor_total,
    SUM(CAST(fc."VRDSC" AS NUMERIC(15,2))) AS valor_desconto,
    SUM(CAST(fc."VRLIQ" AS NUMERIC(15,2))) AS valor_liquido,
    COUNT(CAST(fc."ITEMID" AS INTEGER)) AS quantidade_total,
    SUM(CAST(fc."VRRCB" AS NUMERIC(15,2))) AS vr_rec,
    SUM(CAST(fc."VRDIFCX" AS NUMERIC(15,2))) AS vr_dif_cx
FROM temporary."FC31200" fc
JOIN dw_compras.dim_data d ON d.data = CAST(fc."DTOPE" AS DATE)
JOIN dw_compras.dim_cliente c ON c.cdcli = CAST(ROUND(CAST(fc."CDCON" AS NUMERIC)) AS INTEGER)
JOIN dw_compras.dim_filial f ON f.cdfil = CAST(fc."CDFIL" AS INTEGER)
JOIN dw_compras.dim_operacao o ON o.operid = CAST(fc."OPERID" AS INTEGER)
JOIN dw_compras.dim_requisicao r ON r.nrrqu = CAST(fc."NRRQU" AS INTEGER)
WHERE fc."NRRQU" IS NOT NULL
GROUP BY d.data_id, c.cliente_id, f.filial_id, o.operacao_id, r.requisicao_id;


--------------tabela produtos- fc03000------------------------------

CREATE TABLE dw_compras.dim_produto (
    produto_id SERIAL PRIMARY KEY,       -- Chave primária incremental
    cdpro INTEGER NOT NULL,             -- Código do produto
    descrprd VARCHAR(50),               -- Descrição curta do produto
    descrdet VARCHAR(100),              -- Descrição detalhada
    descr VARCHAR(50),                  -- Nome do produto
    setor VARCHAR(3),                   -- Setor
    famil VARCHAR(2),                   -- Família
    divis VARCHAR(5),                   -- Divisão
    unida VARCHAR(10),                  -- Unidade principal
    unirc VARCHAR(10),                  -- Unidade secundária
    categoria VARCHAR(5),               -- Categoria
    principioativo VARCHAR(200),        -- Princípio ativo
    classeterap CHAR(10),               -- Classe terapêutica
    tpmedicamento CHAR(1),              -- Tipo de medicamento
    hash VARCHAR(100),                  -- Hash de segurança
    dtcad DATE,                         -- Data de cadastro
    dtalt DATE                          -- Data da última alteração
);

INSERT INTO dw_compras.dim_produto (
    cdpro, descrprd, descrdet, descr, setor, famil, divis, 
    unida, unirc, categoria, principioativo, classeterap, tpmedicamento, 
    hash, dtcad, dtalt
)
SELECT DISTINCT
    CAST("CDPRO" AS INTEGER), 
    "DESCRPRD", 
    "DESCRDET", 
    "DESCR", 
    "SETOR", 
    "FAMIL", 
    "DIVIS", 
    "UNIDA", 
    "UNIRC", 
    "CATEGORIA", 
    "PRINCIPIOATIVO", 
    "CLASSETERAP", 
    "TPMEDICAMENTO", 
    "HASH", 
    CAST("DTCAD" AS DATE), 
    CAST("DTALT" AS DATE)
FROM temporary."FC03000"
WHERE "CDPRO" IS NOT NULL;
-------------------------------------------

CREATE TABLE dw_compras.fato_produto_operacao (
    fato_id SERIAL PRIMARY KEY,          -- Chave primária incremental
    produto_id INTEGER NOT NULL,         -- Chave estrangeira para dim_produto
    prcom NUMERIC(15,6),                 -- Preço de compra
    prcomn NUMERIC(15,6),                -- Preço de compra (com desconto)
    prven NUMERIC(15,6),                 -- Preço de venda
    prcom_max NUMERIC(15,6),             -- Preço máximo de venda
    domax NUMERIC(15,6),                 -- Estoque máximo
    domine NUMERIC(15,6),                -- Estoque mínimo
    diluicao NUMERIC(15,6),              -- Fator de diluição
    teor NUMERIC(15,6),                  -- Teor do produto
    densidade NUMERIC(15,6),             -- Densidade
    fator NUMERIC(15,6),                 -- Fator de conversão
    qtconcentra NUMERIC(15,6),           -- Quantidade de concentração
    registroproduto VARCHAR(36),         -- Registro do produto
    data_operacao DATE NOT NULL,         -- Data da operação
    cdpro INTEGER NOT NULL,              -- Código do produto (redundante para integrações)
    FOREIGN KEY (produto_id) REFERENCES dw_compras.dim_produto (produto_id)
);








