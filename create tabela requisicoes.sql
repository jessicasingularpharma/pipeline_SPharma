CREATE TABLE IF NOT EXISTS gold.requisicoes
(
    "CDFIL" VARCHAR,
    "NRRQU" VARCHAR,
    "TPRQU" VARCHAR,
    "CDCLI" VARCHAR,
    "NRCRM" VARCHAR,
    "DTENTR" DATE,
    "VRRQU" NUMERIC(18, 2),
    "CDCON" VARCHAR,
    "TPDSC" VARCHAR,
    "VRDSC" NUMERIC(18, 2),
    "VRRCB" NUMERIC(18, 2),
    "VRSDO" NUMERIC(18, 2),
    "DTEFE" DATE,
    "DTVENC" DATE,
    "DTPAG" DATE,
    "VRTXA" NUMERIC(18, 2),
    "VRLIQ" NUMERIC(18, 2),
    "NRNOT" VARCHAR,
    "VRTRC" NUMERIC(18, 2),
    "VRDSCRCB" NUMERIC(18, 2),
    "TPDSCRCB" VARCHAR,
    "VRTXARCB" NUMERIC(18, 2),
    "CDTXARCB" VARCHAR,
    "PRUNILIQ" NUMERIC(18, 2)
);

INSERT INTO gold.requisicoes (
    "CDFIL", "NRRQU", "TPRQU", "CDCLI", "NRCRM", "DTENTR", "VRRQU", "CDCON", "TPDSC", "VRDSC", 
    "VRRCB", "VRSDO", "DTEFE", "DTVENC", "DTPAG", "VRTXA", "VRLIQ", "NRNOT", "VRTRC", "VRDSCRCB", 
    "TPDSCRCB", "VRTXARCB", "CDTXARCB", "PRUNILIQ"
)
SELECT 
    temp."CDFIL", temp."NRRQU", temp."TPRQU", temp."CDCLI", temp."NRCRM", 
    CAST(temp."DTENTR" AS DATE), CAST(temp."VRRQU" AS NUMERIC(18, 2)), temp."CDCON", 
    temp."TPDSC", CAST(temp."VRDSC" AS NUMERIC(18, 2)), CAST(temp."VRRCB" AS NUMERIC(18, 2)), 
    CAST(temp."VRSDO" AS NUMERIC(18, 2)), CAST(temp."DTEFE" AS DATE), CAST(temp."DTVENC" AS DATE), 
    CAST(temp."DTPAG" AS DATE), CAST(temp."VRTXA" AS NUMERIC(18, 2)), CAST(temp."VRLIQ" AS NUMERIC(18, 2)), 
    temp."NRNOT", CAST(temp."VRTRC" AS NUMERIC(18, 2)), CAST(temp."VRDSCRCB" AS NUMERIC(18, 2)), 
    temp."TPDSCRCB", CAST(temp."VRTXARCB" AS NUMERIC(18, 2)), temp."CDTXARCB", CAST(temp."PRUNILIQ" AS NUMERIC(18, 2))
FROM temporary."FC17000" temp
WHERE NOT EXISTS (
    SELECT 1 
    FROM gold.requisicoes tgt 
    WHERE tgt."CDFIL" = temp."CDFIL"
      AND tgt."NRRQU" = temp."NRRQU"
      AND tgt."TPRQU" = temp."TPRQU"
      AND tgt."CDCLI" = temp."CDCLI"
      AND tgt."NRCRM" = temp."NRCRM"
      AND tgt."DTENTR" = CAST(temp."DTENTR" AS DATE)
);
