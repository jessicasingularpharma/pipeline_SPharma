CREATE TABLE IF NOT EXISTS silver.produtos
(
    "CDPRO" INTEGER PRIMARY KEY, -- Código do produto (Texto curto único)
    "DESCRPRD" TEXT,            -- Descrição do produto
    "DESCRDET" TEXT,            -- Descrição detalhada
    "DESCR" TEXT,               -- Outras descrições
    "SITUA" VARCHAR(20),        -- Situação do produto
    "GRUPO" VARCHAR(50),        -- Grupo ao qual o produto pertence
    "SETOR" VARCHAR(50),        -- Setor do produto
    "LINHA" VARCHAR(50),        -- Linha do produto
    "CURVA" CHAR(1),            -- Curva ABC (A, B ou C)
    "UNIDA" VARCHAR(10),        -- Unidade de medida
    "UNIRC" VARCHAR(10),        -- Unidade de comercialização
    "MOEDA" VARCHAR(3),         -- Código da moeda (Ex: BRL)
    "PRCOM" NUMERIC(18,2),      -- Preço de compra
    "PRCOMN" NUMERIC(18,2),     -- Preço de compra negociado
    "PRVEN" NUMERIC(18,2),      -- Preço de venda
    "DTREAJ" DATE,              -- Data de reajuste
    "DTCAD" DATE,               -- Data de cadastro
    "DTCOM" DATE,               -- Data da última compra
    "NRNOT" VARCHAR(20),        -- Número da nota fiscal
    "CDICM" NUMERIC(5,2),       -- Código do ICMS
    "CDIPI" NUMERIC(5,2),       -- Código do IPI
    "DOMAX" NUMERIC(18,4),      -- Domínio máximo
    "UNIDM" VARCHAR(10),        -- Unidade do domínio máximo
    "FLAGENV" BOOLEAN,          -- Flag de envio
    "DOMINE" NUMERIC(18,4),     -- Domínio mínimo
    "UNIDMINE" VARCHAR(10),     -- Unidade do domínio mínimo
    "DOMIND" NUMERIC(18,4),     -- Domínio padrão
    "UNIDMIND" VARCHAR(10),     -- Unidade do domínio padrão
    "DTALT" DATE,               -- Data da última alteração
    "PRVENMAX" NUMERIC(18,2),   -- Preço de venda máximo
    "CDSEMI" VARCHAR(20),       -- Código do semiacabado
    "HRALT" TIME,               -- Hora da última alteração
    "CDPROH" VARCHAR(20)        -- Código do histórico do produto
);


INSERT INTO silver.produtos (
    "CDPRO", 
    "DESCRPRD", 
    "DESCRDET", 
    "DESCR", 
    "SITUA", 
    "GRUPO", 
    "SETOR", 
    "LINHA", 
    "CURVA", 
    "UNIDA", 
    "UNIRC", 
    "MOEDA", 
    "PRCOM", 
    "PRCOMN", 
    "PRVEN", 
    "DTREAJ", 
    "DTCAD", 
    "DTCOM", 
    "NRNOT", 
    "CDICM", 
    "CDIPI", 
    "DOMAX", 
    "UNIDM", 
    "FLAGENV", 
    "DOMINE", 
    "UNIDMINE", 
    "DOMIND", 
    "UNIDMIND", 
    "DTALT", 
    "PRVENMAX", 
    "CDSEMI", 
    "HRALT", 
    "CDPROH"
)
SELECT 
    CAST("CDPRO" AS INTEGER), 
    CAST("DESCRPRD" AS TEXT), 
    CAST("DESCRDET" AS TEXT), 
    CAST("DESCR" AS TEXT), 
    CAST("SITUA" AS VARCHAR(20)), 
    CAST("GRUPO" AS VARCHAR(50)), 
    CAST("SETOR" AS VARCHAR(50)), 
    CAST("LINHA" AS VARCHAR(50)), 
    CAST("CURVA" AS CHAR(1)), 
    CAST("UNIDA" AS VARCHAR(10)), 
    CAST("UNIRC" AS VARCHAR(10)), 
    CAST("MOEDA" AS VARCHAR(3)), 
    CAST("PRCOM" AS NUMERIC(18, 2)), 
    CAST("PRCOMN" AS NUMERIC(18, 2)), 
    CAST("PRVEN" AS NUMERIC(18, 2)), 
    CAST("DTREAJ" AS DATE), 
    CAST("DTCAD" AS DATE), 
    CAST("DTCOM" AS DATE), 
    CAST("NRNOT" AS VARCHAR(20)), 
    CAST("CDICM" AS NUMERIC(5, 2)), 
    CAST("CDIPI" AS NUMERIC(5, 2)), 
    CAST("DOMAX" AS NUMERIC(18, 4)), 
    CAST("UNIDM" AS VARCHAR(10)), 
    CASE 
        WHEN "FLAGENV" = 'S' THEN TRUE 
        ELSE FALSE 
    END, 
    CAST("DOMINE" AS NUMERIC(18, 4)), 
    CAST("UNIDMINE" AS VARCHAR(10)), 
    CAST("DOMIND" AS NUMERIC(18, 4)), 
    CAST("UNIDMIND" AS VARCHAR(10)), 
    CAST("DTALT" AS DATE), 
    CAST("PRVENMAX" AS NUMERIC(18, 2)), 
    CAST("CDSEMI" AS VARCHAR(20)), 
    CAST("HRALT" AS TIME), 
    CAST("CDPROH" AS VARCHAR(20))
FROM 
    temporary."FC03000"
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM silver.produtos 
        WHERE silver.produtos."CDPRO" = CAST(temporary."FC03000"."CDPRO" AS INTEGER)
    );




CREATE TABLE IF NOT EXISTS gold.produtos
(
    "CDPRO" INTEGER PRIMARY KEY, -- Código do produto (Texto curto único)
    "DESCRPRD" TEXT,            -- Descrição do produto
    "DESCRDET" TEXT,            -- Descrição detalhada
    "DESCR" TEXT,               -- Outras descrições
    "SITUA" VARCHAR(20),        -- Situação do produto
    "GRUPO" VARCHAR(50),        -- Grupo ao qual o produto pertence
    "SETOR" VARCHAR(50),        -- Setor do produto
    "LINHA" VARCHAR(50),        -- Linha do produto
    "CURVA" CHAR(1),            -- Curva ABC (A, B ou C)
    "UNIDA" VARCHAR(10),        -- Unidade de medida
    "UNIRC" VARCHAR(10),        -- Unidade de comercialização
    "MOEDA" VARCHAR(3),         -- Código da moeda (Ex: BRL)
    "PRCOM" NUMERIC(18,2),      -- Preço de compra
    "PRCOMN" NUMERIC(18,2),     -- Preço de compra negociado
    "PRVEN" NUMERIC(18,2),      -- Preço de venda
    "DTREAJ" DATE,              -- Data de reajuste
    "DTCAD" DATE,               -- Data de cadastro
    "DTCOM" DATE,               -- Data da última compra
    "NRNOT" VARCHAR(20),        -- Número da nota fiscal
    "CDICM" NUMERIC(5,2),       -- Código do ICMS
    "CDIPI" NUMERIC(5,2),       -- Código do IPI
    "DOMAX" NUMERIC(18,4),      -- Domínio máximo
    "UNIDM" VARCHAR(10),        -- Unidade do domínio máximo
    "FLAGENV" BOOLEAN,          -- Flag de envio
    "DOMINE" NUMERIC(18,4),     -- Domínio mínimo
    "UNIDMINE" VARCHAR(10),     -- Unidade do domínio mínimo
    "DOMIND" NUMERIC(18,4),     -- Domínio padrão
    "UNIDMIND" VARCHAR(10),     -- Unidade do domínio padrão
    "DTALT" DATE,               -- Data da última alteração
    "PRVENMAX" NUMERIC(18,2),   -- Preço de venda máximo
    "CDSEMI" VARCHAR(20),       -- Código do semiacabado
    "HRALT" TIME,               -- Hora da última alteração
    "CDPROH" VARCHAR(20)        -- Código do histórico do produto
);


INSERT INTO gold.produtos (
    "CDPRO", 
    "DESCRPRD", 
    "DESCRDET", 
    "DESCR", 
    "SITUA", 
    "GRUPO", 
    "SETOR", 
    "LINHA", 
    "CURVA", 
    "UNIDA", 
    "UNIRC", 
    "MOEDA", 
    "PRCOM", 
    "PRCOMN", 
    "PRVEN", 
    "DTREAJ", 
    "DTCAD", 
    "DTCOM", 
    "NRNOT", 
    "CDICM", 
    "CDIPI", 
    "DOMAX", 
    "UNIDM", 
    "FLAGENV", 
    "DOMINE", 
    "UNIDMINE", 
    "DOMIND", 
    "UNIDMIND", 
    "DTALT", 
    "PRVENMAX", 
    "CDSEMI", 
    "HRALT", 
    "CDPROH"
)
SELECT 
    CAST("CDPRO" AS INTEGER), 
    CAST("DESCRPRD" AS TEXT), 
    CAST("DESCRDET" AS TEXT), 
    CAST("DESCR" AS TEXT), 
    CAST("SITUA" AS VARCHAR(20)), 
    CAST("GRUPO" AS VARCHAR(50)), 
    CAST("SETOR" AS VARCHAR(50)), 
    CAST("LINHA" AS VARCHAR(50)), 
    CAST("CURVA" AS CHAR(1)), 
    CAST("UNIDA" AS VARCHAR(10)), 
    CAST("UNIRC" AS VARCHAR(10)), 
    CAST("MOEDA" AS VARCHAR(3)), 
    CAST("PRCOM" AS NUMERIC(18, 2)), 
    CAST("PRCOMN" AS NUMERIC(18, 2)), 
    CAST("PRVEN" AS NUMERIC(18, 2)), 
    CAST("DTREAJ" AS DATE), 
    CAST("DTCAD" AS DATE), 
    CAST("DTCOM" AS DATE), 
    CAST("NRNOT" AS VARCHAR(20)), 
    CAST("CDICM" AS NUMERIC(5, 2)), 
    CAST("CDIPI" AS NUMERIC(5, 2)), 
    CAST("DOMAX" AS NUMERIC(18, 4)), 
    CAST("UNIDM" AS VARCHAR(10)), 
    "FLAGENV", 
    CAST("DOMINE" AS NUMERIC(18, 4)), 
    CAST("UNIDMINE" AS VARCHAR(10)), 
    CAST("DOMIND" AS NUMERIC(18, 4)), 
    CAST("UNIDMIND" AS VARCHAR(10)), 
    CAST("DTALT" AS DATE), 
    CAST("PRVENMAX" AS NUMERIC(18, 2)), 
    CAST("CDSEMI" AS VARCHAR(20)), 
    CAST("HRALT" AS TIME), 
    CAST("CDPROH" AS VARCHAR(20))
FROM 
    silver.produtos AS silver
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM gold.produtos AS gold
        WHERE gold."CDPRO" = CAST(silver."CDPRO" AS INTEGER)
    );




















