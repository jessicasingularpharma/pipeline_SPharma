CREATE TABLE IF NOT EXISTS gold.orcamentos
(
    "CDFIL" VARCHAR,
    "NRORC" VARCHAR,
    "CDCLI" VARCHAR,
    "DTENTR" DATE,
    "VRRQU" NUMERIC(18, 2),
    "VRDSC" NUMERIC(18, 2),
    "VRTXA" NUMERIC(18, 2),
    "NOMEPA" VARCHAR
);

INSERT INTO gold.orcamentos (
    "CDFIL", "NRORC", "CDCLI", "DTENTR", "VRRQU", "VRDSC", "VRTXA", "NOMEPA"
)
SELECT 
    "CDFIL",
    "NRORC",
    "CDCLI",
    CAST("DTENTR" AS DATE),
    CAST("VRRQU" AS NUMERIC(18, 2)),
    CAST("VRDSC" AS NUMERIC(18, 2)),
    CAST("VRTXA" AS NUMERIC(18, 2)),
    "NOMEPA"
FROM temporary."FC15000" temp
WHERE NOT EXISTS (
    SELECT 1
    FROM gold.orcamentos tgt
    WHERE tgt."CDFIL" = temp."CDFIL"
      AND tgt."NRORC" = temp."NRORC"
      AND tgt."CDCLI" = temp."CDCLI"
      AND tgt."DTENTR" = CAST(temp."DTENTR" AS DATE)
);

