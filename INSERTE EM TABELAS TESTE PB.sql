CREATE TABLE IF NOT EXISTS pb.fato_NotaFiscal
(
    "CDFIL" VARCHAR(50),
    "FORNECID" INTEGER,
    "DTENT" DATE,
    "NRNOT" VARCHAR(50),
    "CDFNR" VARCHAR(50),
    "NRPED" VARCHAR(50),
    "VRTOT" NUMERIC(10,2),
    "VRDSC" NUMERIC(10,2),
    "ITEMID" VARCHAR(50),
    "CDPRO" INTEGER,
    "QUANT" NUMERIC(10,2),
    "PRUNI" NUMERIC(10,2),
    "PRUNIR" NUMERIC(10,2),
    "QTREAL" NUMERIC(10,2),
    "NRLOT" VARCHAR(50),
    "DTFAB" DATE,
    "DTVAL" DATE,
    "VFRETE" NUMERIC(10,2),
    CONSTRAINT fk_fornecedores FOREIGN KEY ("FORNECID")
        REFERENCES pb.dim_Fornecedor("fornecid") -- Verifique se a tabela e a coluna estão corretas
);

----------insert fato nota fiscal---------
BEGIN;

INSERT INTO pb.fato_NotaFiscal (
    "CDFIL", 
    "FORNECID", 
    "DTENT", 
    "NRNOT", 
    "CDFNR", 
    "NRPED", 
    "VRTOT", 
    "VRDSC", 
    "ITEMID", 
    "CDPRO", 
    "QUANT", 
    "PRUNI", 
    "PRUNIR", 
    "QTREAL", 
    "NRLOT", 
    "DTFAB", 
    "DTVAL", 
    "VFRETE"
)
SELECT 
    "CDFIL", 
    "FORNECID", 
    "DTENT", 
    "NRNOT", 
    "CDFNR", 
    "NRPED", 
    "VRTOT", 
    "VRDSC", 
    "ITEMID", 
    "CDPRO", 
    "QUANT", 
    "PRUNI", 
    "PRUNIR", 
    "QTREAL", 
    "NRLOT", 
    "DTFAB", 
    "DTVAL", 
    "VFRETE"
FROM 
    gold.combined_notasfiscais;

COMMIT;


---------------------------------------------------------------------
-- Criação da tabela de fato, se ainda não existir
CREATE TABLE IF NOT EXISTS pb.fato_Venda
(
    "CDFIL" VARCHAR(50),
    "DTOPE" DATE,
    "OPERID" VARCHAR(50) NOT NULL,
    "TPPAG" VARCHAR(50),
    "CDCON" VARCHAR(50),
    "CDFUN" VARCHAR(50),
    "CDCLI" VARCHAR(50),
    "CDCONRE" VARCHAR(50),
    "CDFUNRE" VARCHAR(50),
    "VRTOT" NUMERIC(10,2),
    "TPDSC" VARCHAR(50),
    "PTDSC" VARCHAR(50),
    "VRDSC" NUMERIC(10,2),
    "VRREC" NUMERIC(10,2),
    "VRRED" NUMERIC(10,2),
    "CDTXA" VARCHAR(50),
    "VRTXA" NUMERIC(10,2),
    "VRLIQ" NUMERIC(10,2),
    "VRTRC" NUMERIC(10,2),
    "QTTOT" NUMERIC(10,2),
    "VRCXA" NUMERIC(10,2),
    "VRRCB" NUMERIC(10,2),
    "CDSER" VARCHAR(50),
    "VRARC" NUMERIC(10,2),
    "NRPED" VARCHAR(50),
    "NRNF" VARCHAR(50),
    "NRPEDIDO" VARCHAR(50),
    "VTQUANT" NUMERIC(10,2),
    "VTESPECIE" VARCHAR(50),
    "VTMARCA" VARCHAR(50),
    "VTNUMERO" VARCHAR(50),
    "DTEMI" DATE,
    "DTSAI" DATE,
    "HRSAI" TIME WITHOUT TIME ZONE,
    "NRINSCRST" VARCHAR(50),
    "VRCTA" NUMERIC(10,2),
    "VRFRE" NUMERIC(10,2),
    "VRTOTIPI" NUMERIC(10,2),
    "VRTOTPROD" NUMERIC(10,2),
    "NRNFCE" VARCHAR(50),
    "STATUSENOTAS" VARCHAR(50),
    "CDTML" VARCHAR(50),
    "ITEMID" VARCHAR(50) NOT NULL,
    "CDFILR" VARCHAR(50),
    "CDPRO" INTEGER,
    "QUANT" NUMERIC(10,2),
    "PRUNI" NUMERIC(10,2),
    "VRDSCV" NUMERIC(10,2),
    "VRTXAV" NUMERIC(10,2),
    "CDIPI" VARCHAR(50),
    "PRCUSTO" NUMERIC(10,2),
    "PTLUCRO" NUMERIC(10,2),
    "DTPRESCR" DATE,
    "QTPRESCR" NUMERIC(10,2),
    "PRCOMPRA" NUMERIC(10,2),
    "PRUNILIQ" NUMERIC(10,2),
    CONSTRAINT pk_combined_vendas PRIMARY KEY ("OPERID", "ITEMID")
);


INSERT INTO pb.fato_Venda (
    "CDFIL", "DTOPE", "OPERID", "TPPAG", "CDCON", "CDFUN", "CDCLI", "CDCONRE", "CDFUNRE",
    "VRTOT", "TPDSC", "PTDSC", "VRDSC", "VRREC", "VRRED", "CDTXA", "VRTXA", "VRLIQ",
    "VRTRC", "QTTOT", "VRCXA", "VRRCB", "CDSER", "VRARC", "NRPED", "NRNF", "NRPEDIDO",
    "VTQUANT", "VTESPECIE", "VTMARCA", "VTNUMERO", "DTEMI", "DTSAI", "HRSAI", "NRINSCRST",
    "VRCTA", "VRFRE", "VRTOTIPI", "VRTOTPROD", "NRNFCE", "STATUSENOTAS", "CDTML", "ITEMID",
    "CDFILR", "CDPRO", "QUANT", "PRUNI", "VRDSCV", "VRTXAV", "CDIPI", "PRCUSTO", "PTLUCRO",
    "DTPRESCR", "QTPRESCR", "PRCOMPRA", "PRUNILIQ"
)
SELECT
    src."CDFIL",
    CAST(src."DTOPE" AS DATE),
    src."OPERID",
    src."TPPAG",
    src."CDCON",
    src."CDFUN",
    src."CDCLI",
    src."CDCONRE",
    src."CDFUNRE",
    CAST(src."VRTOT" AS NUMERIC(10, 2)),
    src."TPDSC",
    src."PTDSC",
    CAST(src."VRDSC" AS NUMERIC(10, 2)),
    CAST(src."VRREC" AS NUMERIC(10, 2)),
    CAST(src."VRRED" AS NUMERIC(10, 2)),
    src."CDTXA",
    CAST(src."VRTXA" AS NUMERIC(10, 2)),
    CAST(src."VRLIQ" AS NUMERIC(10, 2)),
    CAST(src."VRTRC" AS NUMERIC(10, 2)),
    CAST(src."QTTOT" AS NUMERIC(10, 2)),
    CAST(src."VRCXA" AS NUMERIC(10, 2)),
    CAST(src."VRRCB" AS NUMERIC(10, 2)),
    src."CDSER",
    CAST(src."VRARC" AS NUMERIC(10, 2)),
    src."NRPED",
    src."NRNF",
    src."NRPEDIDO",
    CAST(src."VTQUANT" AS NUMERIC(10, 2)),
    src."VTESPECIE",
    src."VTMARCA",
    src."VTNUMERO",
    CAST(src."DTEMI" AS DATE),
    CAST(src."DTSAI" AS DATE),
    CAST(src."HRSAI" AS TIME),
    src."NRINSCRST",
    CAST(src."VRCTA" AS NUMERIC(10, 2)),
    CAST(src."VRFRE" AS NUMERIC(10, 2)),
    CAST(src."VRTOTIPI" AS NUMERIC(10, 2)),
    CAST(src."VRTOTPROD" AS NUMERIC(10, 2)),
    src."NRNFCE",
    src."STATUSENOTAS",
    src."CDTML",  -- ADICIONE ESTA E OUTRAS QUE FALTAM
    src."ITEMID",
    src."CDFILR",
    src."CDPRO",
    CAST(src."QUANT" AS NUMERIC(10, 2)),
    CAST(src."PRUNI" AS NUMERIC(10, 2)),
    CAST(src."VRDSCV" AS NUMERIC(10, 2)),
    CAST(src."VRTXAV" AS NUMERIC(10, 2)),
    src."CDIPI",
    CAST(src."PRCUSTO" AS NUMERIC(10, 2)),
    CAST(src."PTLUCRO" AS NUMERIC(10, 2)),
    CAST(src."DTPRESCR" AS DATE),
    CAST(src."QTPRESCR" AS NUMERIC(10, 2)),
    CAST(src."PRCOMPRA" AS NUMERIC(10, 2)),
    CAST(src."PRUNILIQ" AS NUMERIC(10, 2))
FROM gold.combined_vendas src
WHERE NOT EXISTS (
    SELECT 1
    FROM pb.fato_Venda tgt
    WHERE tgt."CDFIL" = src."CDFIL"
      AND tgt."DTOPE" = CAST(src."DTOPE" AS DATE)
      AND tgt."OPERID" = src."OPERID"
);

--------------------------------------------------------
CREATE TABLE IF NOT EXISTS pb.Dim_Fornecedor (
    "fornecid" INTEGER PRIMARY KEY,
    "razao" VARCHAR(255), 
    "nrcnpj" VARCHAR(20)  -- Especificando um tamanho adequado para o campo CNPJ
);

-- Inserção de dados na tabela de destino com verificação de duplicatas
INSERT INTO pb.Dim_Fornecedor (
    "fornecid", 
    "razao", 
    "nrcnpj"
)
SELECT DISTINCT 
    "fornecid", 
    "razao", 
    "nrcnpj"
FROM 
    silver.fornecedores
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM pb.Dim_Fornecedor AS df
        WHERE df."fornecid" = silver.fornecedores."fornecid"
    );

-----------TABELA DE DIMENSOES--------------------------------------------

CREATE TABLE IF NOT EXISTS pb.Dim_Produto_da_notafiscal
(
    "CDPRO" INTEGER,
    "UNIDA" VARCHAR(20),
    "CDPROUNITARIO" VARCHAR(50),
    "INDFRACI" BOOLEAN,
    "FRACI" NUMERIC(10,2),
    "CPROD" VARCHAR(50),
    "XPROD" VARCHAR(255),
    "CNPJFAB" VARCHAR(20)
);

INSERT INTO pb.Dim_Produto_da_notafiscal (
    "CDPRO", 
    "UNIDA", 
    "CDPROUNITARIO", 
    "INDFRACI", 
    "FRACI", 
    "CPROD", 
    "XPROD", 
    "CNPJFAB"
)
SELECT DISTINCT 
    "CDPRO", 
    "UNIDA", 
    "CDPROUNITARIO", 
    "INDFRACI", 
    "FRACI", 
    "CPROD", 
    "XPROD", 
    "CNPJFAB"
FROM 
    gold.combined_notasfiscais
WHERE NOT EXISTS (
    SELECT 1 
    FROM pb.Dim_Produto_da_notafiscal tgt 
    WHERE tgt."CDPRO" = gold.combined_notasfiscais."CDPRO"
);

-------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS pb.Dim_Calendar
(
    "DateID" DATE PRIMARY KEY,
    "Year" INTEGER,
    "Month" INTEGER,
    "Day" INTEGER,
    "WeekDay" VARCHAR(10)
);


INSERT INTO pb.Dim_Calendar (

    "DateID", 
    "Year", 
    "Month", 
    "Day", 
    "WeekDay"
)

SELECT DISTINCT 
    "DTENT" AS "DateID", 
    EXTRACT(YEAR FROM "DTENT") AS "Year",
    EXTRACT(MONTH FROM "DTENT") AS "Month",
    EXTRACT(DAY FROM "DTENT") AS "Day",
    TO_CHAR("DTENT", 'Day') AS "WeekDay"
FROM 
    gold.combined_notasfiscais
WHERE 
    "DTENT" IS NOT NULL;



-------------------------------------------------

CREATE TABLE IF NOT EXISTS pb.Dim_Filial (
    "CDFIL" VARCHAR(50) PRIMARY KEY
);

INSERT INTO pb.Dim_Filial ("CDFIL")
SELECT DISTINCT "CDFIL"
FROM gold.combined_vendas
WHERE NOT EXISTS (
    SELECT 1 FROM pb.Dim_Filial tgt WHERE tgt."CDFIL" = gold.combined_vendas."CDFIL"
);


CREATE TABLE IF NOT EXISTS pb.Dim_Cliente (
    "CDCLI" VARCHAR(50),
    "NOMEPA" VARCHAR(255)
);
INSERT INTO pb.Dim_Cliente ("CDCLI", "NOMEPA")
SELECT DISTINCT "CDCLI", "NOMEPA"
FROM gold.combined_vendas
WHERE NOT EXISTS (
    SELECT 1 FROM pb.Dim_Cliente tgt WHERE tgt."CDCLI" = gold.combined_vendas."CDCLI"
);


CREATE TABLE IF NOT EXISTS pb.Dim_Tempo (
    "DateID" DATE PRIMARY KEY,
    "Year" INTEGER,
    "Month" INTEGER,
    "Day" INTEGER,
    "WeekDay" VARCHAR(10)
);
INSERT INTO pb.Dim_Tempo ("DateID", "Year", "Month", "Day", "WeekDay")
SELECT DISTINCT "DTOPE" AS "DateID", 
    EXTRACT(YEAR FROM "DTOPE") AS "Year", 
    EXTRACT(MONTH FROM "DTOPE") AS "Month", 
    EXTRACT(DAY FROM "DTOPE") AS "Day", 
    TO_CHAR("DTOPE", 'Day') AS "WeekDay"
FROM gold.combined_vendas
WHERE NOT EXISTS (
    SELECT 1 FROM pb.Dim_Tempo tgt WHERE tgt."DateID" = gold.combined_vendas."DTOPE"
);

CREATE TABLE IF NOT EXISTS pb.Dim_Produto (
    "CDPRO" INTEGER PRIMARY KEY
);
INSERT INTO pb.Dim_Produto ("CDPRO")
SELECT DISTINCT "CDPRO"
FROM gold.combined_vendas
WHERE NOT EXISTS (
    SELECT 1 FROM pb.Dim_Produto tgt WHERE tgt."CDPRO" = gold.combined_vendas."CDPRO"
);



-- Relacionar Fato_NotaFiscal com Dim_Fornecedor
ALTER TABLE pb.fato_NotaFiscal
ADD CONSTRAINT fk_fornecedor
FOREIGN KEY ("FORNECID")
REFERENCES pb.Dim_Fornecedor("fornecid");

-- Relacionar Fato_NotaFiscal com Dim_Produto_da_notafiscal
ALTER TABLE pb.fato_NotaFiscal
ADD CONSTRAINT fk_produto_notafiscal
FOREIGN KEY ("CDPRO")
REFERENCES pb.Dim_Produto_da_notafiscal("CDPRO");



\d+ dim_produto_da_notafiscal


