CREATE TABLE IF NOT EXISTS silver.formulas
(
    "CDFIL" varchar(50),
    "NRORC" varchar(50),
    "SERIEO" varchar(50),
    "PFCRM" varchar(50),
    "UFCRM" varchar(50),
    "NRCRM" varchar(50),
    "VOLUME" numeric(10,2),
    "UNIVOL" varchar(50),
    "TPCAP" varchar(50),
    "QTFOR" numeric(10,2),
    "QTCONT" numeric(10,2),
    "PRREAL" numeric(10,2),
    "PRCUSTO" numeric(10,2),
    "CDFRM" varchar(50),
    "CDEMB" varchar(50),
    "DTENTR" date,
    "ID" varchar(50),
    "GRUPOTERAP" varchar(50),
    "PRCOMPRA" numeric(10,2)
);


INSERT INTO silver.formulas
(
    "CDFIL",
    "NRORC",
    "SERIEO",
    "PFCRM",
    "UFCRM",
    "NRCRM",
    "VOLUME",
    "UNIVOL",
    "TPCAP",
    "QTFOR",
    "QTCONT",
    "PRREAL",
    "PRCUSTO",
    "CDFRM",
    "CDEMB",
    "DTENTR",
    "ID",
    "GRUPOTERAP",
    "PRCOMPRA"
)
SELECT
    "CDFIL",
    "NRORC",
    "SERIEO",
    "PFCRM",
    "UFCRM",
    "NRCRM",
    CAST("VOLUME" AS numeric(10,2)),
    "UNIVOL",
    "TPCAP",
    CAST("QTFOR" AS numeric(10,2)),
    CAST("QTCONT" AS numeric(10,2)),
    CAST("PRREAL" AS numeric(10,2)),
    CAST("PRCUSTO" AS numeric(10,2)),
    "CDFRM",
    "CDEMB",
    CAST("DTENTR" AS date),
    "ID",
    "GRUPOTERAP",
    CAST("PRCOMPRA" AS numeric(10,2))
FROM temporary."FC15100"
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.formulas 
    WHERE 
        silver.formulas."CDFIL" = temporary."FC15100"."CDFIL" AND
        silver.formulas."NRORC" = temporary."FC15100"."NRORC" AND
        silver.formulas."SERIEO" = temporary."FC15100"."SERIEO" AND
        silver.formulas."PFCRM" = temporary."FC15100"."PFCRM" AND
        silver.formulas."UFCRM" = temporary."FC15100"."UFCRM" AND
        silver.formulas."NRCRM" = temporary."FC15100"."NRCRM"
);

