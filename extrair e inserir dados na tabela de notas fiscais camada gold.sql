INSERT INTO silver.notasfiscais (
    "CDFIL", "FORNECID", "DTENT", "NRNOT", "CDFNR", "NRPED", "VRTOT", "VRDSC"
)
SELECT 
    "CDFIL", 
    "FORNECID", 
    CAST("DTENT" AS DATE), 
    "NRNOT", 
    "CDFNR", 
    "NRPED", 
    CAST("VRTOT" AS NUMERIC(10, 2)), 
    CAST("VRDSC" AS NUMERIC(10, 2))
FROM temporary."FC11000" src
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.notasfiscais tgt 
    WHERE tgt."CDFIL" = src."CDFIL" 
    AND tgt."FORNECID" = src."FORNECID" 
    AND tgt."DTENT" = CAST(src."DTENT" AS DATE)
    AND tgt."NRNOT" = src."NRNOT"
);


INSERT INTO silver.itensdasnotasfiscais (
    "CDFIL", "FORNECID", "DTENT", "NRNOT", "ITEMID", "CDFNR", "CDPRO", "QUANT", "UNIDA", 
    "PRUNI", "PRUNIR", "QTREAL", "NRLOT", "DTFAB", "DTVAL", "CTLOT", "CDPROUNITARIO", 
    "INDFRACI", "FRACI", "VRDSC", "VRTOT", "CPROD", "XPROD", "CNPJFAB", "VFRETE"
)
SELECT 
    "CDFIL", 
    "FORNECID", 
    CAST("DTENT" AS DATE), 
    "NRNOT", 
    "ITEMID", 
    "CDFNR", 
    "CDPRO", 
    CAST("QUANT" AS NUMERIC(10, 2)), 
    "UNIDA", 
    CAST("PRUNI" AS NUMERIC(10, 2)), 
    CAST("PRUNIR" AS NUMERIC(10, 2)), 
    CAST("QTREAL" AS NUMERIC(10, 2)), 
    "NRLOT", 
    CAST("DTFAB" AS DATE), 
    CAST("DTVAL" AS DATE), 
    "CTLOT", 
    "CDPROUNITARIO", 
    CASE WHEN "INDFRACI" = 'S' THEN TRUE ELSE FALSE END, 
    CAST("FRACI" AS NUMERIC(10, 2)), 
    CAST("VRDSC" AS NUMERIC(10, 2)), 
    CAST("VRTOT" AS NUMERIC(10, 2)), 
    "CPROD", 
    "XPROD", 
    "CNPJFAB", 
    CAST("VFRETE" AS NUMERIC(10, 2))
FROM temporary."FC11100" src
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.itensdasnotasfiscais tgt 
    WHERE tgt."CDFIL" = src."CDFIL"
    AND tgt."FORNECID" = src."FORNECID"
    AND tgt."DTENT" = CAST(src."DTENT" AS DATE)
    AND tgt."NRNOT" = src."NRNOT"
    AND tgt."ITEMID" = src."ITEMID"
);



INSERT INTO gold.combined_notasfiscais (
    "CDFIL", "FORNECID", "DTENT", "NRNOT", "CDFNR", "NRPED", "VRTOT", "VRDSC",
    "ITEMID", "CDPRO", "QUANT", "UNIDA", "PRUNI", "PRUNIR", "QTREAL", "NRLOT", 
    "DTFAB", "DTVAL", "CTLOT", "CDPROUNITARIO", "INDFRACI", "FRACI", "CPROD", 
    "XPROD", "CNPJFAB", "VFRETE"
)
SELECT 
    nf."CDFIL", CAST(nf."FORNECID" AS INTEGER), nf."DTENT", nf."NRNOT", nf."CDFNR", nf."NRPED", nf."VRTOT", nf."VRDSC",
    it."ITEMID", CAST(it."CDPRO" AS INTEGER), it."QUANT", it."UNIDA", it."PRUNI", it."PRUNIR", it."QTREAL", it."NRLOT", 
    it."DTFAB", it."DTVAL", it."CTLOT", it."CDPROUNITARIO", it."INDFRACI", it."FRACI", it."CPROD", 
    it."XPROD", it."CNPJFAB", it."VFRETE"
FROM silver.notasfiscais nf
JOIN silver.itensdasnotasfiscais it
ON nf."CDFIL" = it."CDFIL"
AND CAST(nf."FORNECID" AS INTEGER) = CAST(it."FORNECID" AS INTEGER)
AND nf."DTENT" = it."DTENT"
AND nf."NRNOT" = it."NRNOT"
WHERE NOT EXISTS (
    SELECT 1 
    FROM gold.combined_notasfiscais cnf
    WHERE cnf."CDFIL" = nf."CDFIL"
    AND cnf."FORNECID" = CAST(nf."FORNECID" AS INTEGER)
    AND cnf."DTENT" = nf."DTENT"
    AND cnf."NRNOT" = nf."NRNOT"
    AND cnf."ITEMID" = it."ITEMID"
);


