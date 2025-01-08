CREATE TABLE IF NOT EXISTS silver.componentesformulas
(
    "CDFIL" varchar(50),
    "NRORC" varchar(50),
    "SERIEO" varchar(50),
    "ITEMID" varchar(50),
    "TPCMP" varchar(50),
    "CDPRO" integer,
    "DESCR" text,
    "QUANT" numeric(10,2),
    "UNIDA" varchar(50),
    "UNIHP" varchar(50),
    "QTREAL" numeric(10,2),
    "DTENTR" date,
    "CDPRIN" varchar(50)
);

INSERT INTO silver.componentesformulas
(
    "CDFIL",
    "NRORC",
    "SERIEO",
    "ITEMID",
    "TPCMP",
    "CDPRO",
    "DESCR",
    "QUANT",
    "UNIDA",
    "UNIHP",
    "QTREAL",
    "DTENTR",
    "CDPRIN"
)
SELECT
    "CDFIL",
    "NRORC",
    "SERIEO",
    "ITEMID",
    "TPCMP",
    "CDPRO",
    "DESCR",
    "QUANT",
    "UNIDA",
    "UNIHP",
    "QTREAL",
    "DTENTR",
    "CDPRIN"
FROM temporary.fc15110_adjusted
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.componentesformulas 
    WHERE 
        silver.componentesformulas."CDFIL" = temporary.fc15110_adjusted."CDFIL" AND
        silver.componentesformulas."NRORC" = temporary.fc15110_adjusted."NRORC" AND
        silver.componentesformulas."SERIEO" = temporary.fc15110_adjusted."SERIEO" AND
        silver.componentesformulas."ITEMID" = temporary.fc15110_adjusted."ITEMID" AND
        silver.componentesformulas."TPCMP" = temporary.fc15110_adjusted."TPCMP"
);





CREATE TABLE IF NOT EXISTS temporary.fc15110_adjusted AS
SELECT 
    "CDFIL",
    "NRORC",
    "SERIEO",
    "ITEMID",
    "TPCMP",
    CASE 
        WHEN CAST("CDPRO" AS numeric) >= 10^8 THEN NULL 
        ELSE CAST("CDPRO" AS integer) 
    END AS "CDPRO",
    "DESCR",
    CASE 
        WHEN CAST("QUANT" AS numeric) >= 10^8 THEN 99999999.99 
        ELSE CAST("QUANT" AS numeric(10,2)) 
    END AS "QUANT",
    "UNIDA",
    "UNIHP",
    CASE 
        WHEN CAST("QTREAL" AS numeric) >= 10^8 THEN 99999999.99 
        ELSE CAST("QTREAL" AS numeric(10,2)) 
    END AS "QTREAL",
    CAST("DTENTR" AS date) AS "DTENTR",
    "CDPRIN"
FROM temporary."FC15110";



