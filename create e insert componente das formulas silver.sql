CREATE TABLE IF NOT EXISTS silver.componentedasformulas
(
    "CDFIL" VARCHAR,
    "NRORC" VARCHAR,
    "SERIEO" VARCHAR,
    "ITEMID" VARCHAR,
    "TPCMP" VARCHAR,
    "CDPRO" VARCHAR,
    "DESCR" TEXT,
    "QUANT" NUMERIC,
    "UNIDA" VARCHAR,
    "UNIHP" VARCHAR,
    "VRCMP" NUMERIC,
    "QTREAL" NUMERIC,
    "INDQSP" BOOLEAN,
    "INDDOMAX" BOOLEAN,
    "VOLAPA" NUMERIC,
    "INDELICMP" BOOLEAN,
    "INDASSOC" BOOLEAN,
    "INDQS" BOOLEAN,
    "PORTA" VARCHAR,
    "DTENTR" DATE,
    "CDPRIN" VARCHAR,
    "DILUI" NUMERIC,
    "DENSI" NUMERIC,
    "PRCUSTO" NUMERIC,
    "VRCMPORI" NUMERIC,
    "QTREALORI" NUMERIC,
    "VOLAPAORI" NUMERIC,
    "QUANTHP" NUMERIC,
    "UNIDAPRD" VARCHAR,
    "INDVEICULO" BOOLEAN,
    "INDDILUI" BOOLEAN,
    "QTREALUNI" NUMERIC,
    "CDPRINASS" VARCHAR,
    "INDDOMIN" BOOLEAN,
    "TPASS" VARCHAR,
    "TEOR" NUMERIC,
    "CORGRID" VARCHAR,
    "EQUIV" VARCHAR,
    "QTUTR" NUMERIC,
    "QTUI" NUMERIC,
    "QTBLH" NUMERIC,
    "QTMLH" NUMERIC,
    "QTMEQ" NUMERIC,
    "QTUFC" NUMERIC,
    "NRNOTIF" VARCHAR,
    "PRCOMPRA" NUMERIC,
    "QTPERDA" NUMERIC,
    "TPFORMAFARMA" VARCHAR,
    "QTFCC" NUMERIC,
    "QTMUF" NUMERIC,
    "QTBUF" NUMERIC,
    "EXTERNOPERC" NUMERIC,
    "INTERNOPERC" NUMERIC,
    "QSPCAP" NUMERIC
);


INSERT INTO silver.componentedasformulas (
    "CDFIL", "NRORC", "SERIEO", "ITEMID", "TPCMP", "CDPRO", "DESCR", "QUANT", "UNIDA", "UNIHP", "VRCMP", 
    "QTREAL", "INDQSP", "INDDOMAX", "VOLAPA", "INDELICMP", "INDASSOC", "INDQS", "PORTA", "DTENTR", 
    "CDPRIN", "DILUI", "DENSI", "PRCUSTO", "VRCMPORI", "QTREALORI", "VOLAPAORI", "QUANTHP", "UNIDAPRD", 
    "INDVEICULO", "INDDILUI", "QTREALUNI", "CDPRINASS", "INDDOMIN", "TPASS", "TEOR", "CORGRID", "EQUIV", 
    "QTUTR", "QTUI", "QTBLH", "QTMLH", "QTMEQ", "QTUFC", "NRNOTIF", "PRCOMPRA", "QTPERDA", "TPFORMAFARMA", 
    "QTFCC", "QTMUF", "QTBUF", "EXTERNOPERC", "INTERNOPERC", "QSPCAP"
)
SELECT 
    "CDFIL", "NRORC", "SERIEO", "ITEMID", "TPCMP", "CDPRO", "DESCR", CAST("QUANT" AS NUMERIC), "UNIDA", 
    "UNIHP", CAST("VRCMP" AS NUMERIC), CAST("QTREAL" AS NUMERIC), 
    CASE WHEN "INDQSP" = 'S' THEN TRUE ELSE FALSE END, 
    CASE WHEN "INDDOMAX" = 'S' THEN TRUE ELSE FALSE END, 
    CAST("VOLAPA" AS NUMERIC), 
    CASE WHEN "INDELICMP" = 'S' THEN TRUE ELSE FALSE END, 
    CASE WHEN "INDASSOC" = 'S' THEN TRUE ELSE FALSE END, 
    CASE WHEN "INDQS" = 'S' THEN TRUE ELSE FALSE END, 
    "PORTA", CAST("DTENTR" AS DATE), "CDPRIN", 
    CAST("DILUI" AS NUMERIC), CAST("DENSI" AS NUMERIC), 
    CAST("PRCUSTO" AS NUMERIC), CAST("VRCMPORI" AS NUMERIC), CAST("QTREALORI" AS NUMERIC), 
    CAST("VOLAPAORI" AS NUMERIC), CAST("QUANTHP" AS NUMERIC), "UNIDAPRD", 
    CASE WHEN "INDVEICULO" = 'S' THEN TRUE ELSE FALSE END, 
    CASE WHEN "INDDILUI" = 'S' THEN TRUE ELSE FALSE END, 
    CAST("QTREALUNI" AS NUMERIC), "CDPRINASS", 
    CASE WHEN "INDDOMIN" = 'S' THEN TRUE ELSE FALSE END, 
    "TPASS", CAST("TEOR" AS NUMERIC), "CORGRID", "EQUIV", 
    CAST("QTUTR" AS NUMERIC), CAST("QTUI" AS NUMERIC), 
    CAST("QTBLH" AS NUMERIC), CAST("QTMLH" AS NUMERIC), 
    CAST("QTMEQ" AS NUMERIC), CAST("QTUFC" AS NUMERIC), "NRNOTIF", 
    CAST("PRCOMPRA" AS NUMERIC), CAST("QTPERDA" AS NUMERIC), 
    "TPFORMAFARMA", CAST("QTFCC" AS NUMERIC), 
    CAST("QTMUF" AS NUMERIC), CAST("QTBUF" AS NUMERIC), 
    CAST("EXTERNOPERC" AS NUMERIC), CAST("INTERNOPERC" AS NUMERIC), 
    CAST("QSPCAP" AS NUMERIC)
FROM temporary."FC15110"
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.componentedasformulas 
    WHERE silver.componentedasformulas."CDFIL" = temporary."FC15110"."CDFIL"
    AND silver.componentedasformulas."NRORC" = temporary."FC15110"."NRORC"
    AND silver.componentedasformulas."SERIEO" = temporary."FC15110"."SERIEO"
    AND silver.componentedasformulas."ITEMID" = temporary."FC15110"."ITEMID"
);

