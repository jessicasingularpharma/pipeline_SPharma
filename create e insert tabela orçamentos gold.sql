CREATE TABLE IF NOT EXISTS silver.orcamentos
(
    "CDFIL" VARCHAR,
    "NRORC" VARCHAR,
    "CDFILD" VARCHAR,
    "CDCLI" VARCHAR,
    "DTENTR" DATE,
    "VRRQU" NUMERIC,
    "VRDSC" NUMERIC,
    "VRTXA" NUMERIC,
    "NRCPMN" VARCHAR,
    "FLAGENV" BOOLEAN,
    "NOMEPA" VARCHAR,
    "OBSPA" TEXT,
    "ENDEPA" VARCHAR,
    "CDCON" VARCHAR,
    "CDFUN" VARCHAR,
    "CONDP" VARCHAR,
    "CDCAPTACAO" VARCHAR
);

INSERT INTO silver.orcamentos (
    "CDFIL", "NRORC", "CDFILD", "CDCLI", "DTENTR", "VRRQU", "VRDSC", "VRTXA", "NRCPMN", "FLAGENV", 
    "NOMEPA", "OBSPA", "ENDEPA", "CDCON", "CDFUN", "CONDP", "CDCAPTACAO"
)
SELECT 
    "CDFIL", "NRORC", "CDFILD", "CDCLI", 
    CAST("DTENTR" AS DATE), 
    CAST("VRRQU" AS NUMERIC), 
    CAST("VRDSC" AS NUMERIC), 
    CAST("VRTXA" AS NUMERIC), 
    "NRCPMN", 
    CAST("FLAGENV" AS BOOLEAN), 
    "NOMEPA", 
    "OBSPA", 
    "ENDEPA", 
    "CDCON", 
    "CDFUN", 
    "CONDP", 
    "CDCAPTACAO"
FROM temporary."FC15000"
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.orcamentos 
    WHERE silver.orcamentos."CDFIL" = temporary."FC15000"."CDFIL"
    AND silver.orcamentos."NRORC" = temporary."FC15000"."NRORC"
    AND silver.orcamentos."CDFILD" = temporary."FC15000"."CDFILD"
    AND silver.orcamentos."CDCLI" = temporary."FC15000"."CDCLI"
    AND silver.orcamentos."DTENTR" = CAST(temporary."FC15000"."DTENTR" AS DATE)
);

