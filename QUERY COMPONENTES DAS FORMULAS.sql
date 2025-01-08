CREATE TABLE IF NOT EXISTS gold.componentesdasformulas
(
    "CDFIL" VARCHAR,
    "NRORC" VARCHAR,
    "SERIEO" VARCHAR,
    "ITEMID" VARCHAR,
    "CDPRO" VARCHAR,
    "DESCR" VARCHAR,
    "QUANT" NUMERIC(18, 2),
    "UNIDA" VARCHAR,
    "VRCMP" NUMERIC(18, 2),
    "QTREAL" NUMERIC(18, 2),
    "VOLAPA" NUMERIC(18, 2),
    "INDQS" BOOLEAN,
    "DTENTR" DATE,
    "CDPRIN" VARCHAR,
    "PRCUSTO" NUMERIC(18, 2),
    "VRCMPORI" NUMERIC(18, 2),
    "QTREALORI" NUMERIC(18, 2),
    "PRCOMPRA" NUMERIC(18, 2),
    "TPFORMAFARMA" VARCHAR
);


INSERT INTO gold.componentesdasformulas (
    "CDFIL", "NRORC", "SERIEO", "ITEMID", "CDPRO", "DESCR", "QUANT", "UNIDA", "VRCMP", "QTREAL", 
    "VOLAPA", "INDQS", "DTENTR", "CDPRIN", "PRCUSTO", "VRCMPORI", "QTREALORI", "PRCOMPRA", 
    "TPFORMAFARMA"
)
SELECT 
    temp."CDFIL", temp."NRORC", temp."SERIEO", temp."ITEMID", temp."CDPRO", temp."DESCR", 
    CAST(temp."QUANT" AS NUMERIC(18, 2)), temp."UNIDA", CAST(temp."VRCMP" AS NUMERIC(18, 2)), 
    CAST(temp."QTREAL" AS NUMERIC(18, 2)), CAST(temp."VOLAPA" AS NUMERIC(18, 2)), 
    CASE WHEN temp."INDQS" = 'S' THEN TRUE ELSE FALSE END, 
    CAST(temp."DTENTR" AS DATE), temp."CDPRIN", CAST(temp."PRCUSTO" AS NUMERIC(18, 2)), 
    CAST(temp."VRCMPORI" AS NUMERIC(18, 2)), CAST(temp."QTREALORI" AS NUMERIC(18, 2)), 
    CAST(temp."PRCOMPRA" AS NUMERIC(18, 2)), temp."TPFORMAFARMA"
FROM temporary."FC15110" temp
WHERE NOT EXISTS (
    SELECT 1 
    FROM gold.componentesdasformulas tgt 
    WHERE tgt."CDFIL" = temp."CDFIL"
      AND tgt."NRORC" = temp."NRORC"
      AND tgt."SERIEO" = temp."SERIEO"
      AND tgt."ITEMID" = temp."ITEMID"
      AND tgt."CDPRO" = temp."CDPRO"
);

