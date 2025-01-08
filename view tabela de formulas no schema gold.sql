CREATE VIEW gold.unified_formulas AS
SELECT 
    f."CDFIL" AS "Formula_CDFIL",
    f."NRORC" AS "Formula_NRORC",
    f."SERIEO" AS "Formula_SERIEO",
    f."PFCRM" AS "Formula_PFCRM",
    f."UFCRM" AS "Formula_UFCRM",
    f."NRCRM" AS "Formula_NRCRM",
    f."VOLUME" AS "Formula_VOLUME",
    f."UNIVOL" AS "Formula_UNIVOL",
    f."TPCAP" AS "Formula_TPCAP",
    f."QTFOR" AS "Formula_QTFOR",
    f."QTCONT" AS "Formula_QTCONT",
    f."PRREAL" AS "Formula_PRREAL",
    f."PRCUSTO" AS "Formula_PRCUSTO",
    f."CDEMB" AS "Formula_CDEMB",
    f."DTENTR" AS "Formula_DTENTR",
    f."ID" AS "Formula_ID",
    f."GRUPOTERAP" AS "Formula_GRUPOTERAP",
    f."PRCOMPRA" AS "Formula_PRCOMPRA",
    c."CDFIL" AS "Component_CDFIL",
    c."SERIEO" AS "Component_SERIEO",
    c."ITEMID" AS "Component_ITEMID",
    c."TPCMP" AS "Component_TPCMP",
    c."CDPRO" AS "Component_CDPRO",
    c."DESCR" AS "Component_DESCR",
    c."QUANT" AS "Component_QUANT",
    c."UNIDA" AS "Component_UNIDA",
    c."QTREAL" AS "Component_QTREAL",
    c."DTENTR" AS "Component_DTENTR",
    c."CDPRIN" AS "Component_CDPRIN"
FROM 
    silver.formulas f
    LEFT JOIN silver.componentesformulas c ON f."NRORC" = c."NRORC";

