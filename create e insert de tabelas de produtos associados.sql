CREATE TABLE IF NOT EXISTS silver.produtosassociados
(
    "CDPRO" VARCHAR,
    "CDASSDO" VARCHAR,
    "ITEMID" VARCHAR,
    "TPASS" VARCHAR,
    "QTASSTEINI" NUMERIC,
    "QTASSTEFIM" NUMERIC,
    "UNIASSTE" VARCHAR,
    "QTASSDO" NUMERIC,
    "UNIDASSDO" VARCHAR,
    "TPFORMAFARMA" VARCHAR,
    "INDELICMP" BOOLEAN
);

INSERT INTO silver.produtosassociados (
    "CDPRO", "CDASSDO", "ITEMID", "TPASS", "QTASSTEINI", "QTASSTEFIM", "UNIASSTE", "QTASSDO", 
    "UNIDASSDO", "TPFORMAFARMA", "INDELICMP"
)
SELECT 
    "CDPRO", "CDASSDO", "ITEMID", "TPASS", 
    CAST("QTASSTEINI" AS NUMERIC), 
    CAST("QTASSTEFIM" AS NUMERIC), 
    "UNIASSTE", 
    CAST("QTASSDO" AS NUMERIC), 
    "UNIDASSDO", 
    "TPFORMAFARMA", 
    CASE WHEN "INDELICMP" = 'S' THEN TRUE ELSE FALSE END
FROM temporary."FC03600"
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.produtosassociados 
    WHERE silver.produtosassociados."CDPRO" = temporary."FC03600"."CDPRO"
    AND silver.produtosassociados."CDASSDO" = temporary."FC03600"."CDASSDO"
    AND silver.produtosassociados."ITEMID" = temporary."FC03600"."ITEMID"
);
