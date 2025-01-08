INSERT INTO silver.vendas (
    "CDFIL", "DTOPE", "OPERID", "TPPAG", "CDCON", "CDFUN", "CDCLI", "CDCONRE", "CDFUNRE", 
    "VRTOT", "TPDSC", "PTDSC", "VRDSC", "VRREC", "VRRED", "CDTXA", "VRTXA", "VRLIQ", "VRTRC", 
    "QTTOT", "VRCXA", "VRRCB", "CDSER", "VRARC", "NRPED", "NRNF", "NRPEDIDO", "VTQUANT", 
    "VTESPECIE", "VTMARCA", "VTNUMERO", "DTEMI", "DTSAI", "HRSAI", "NRINSCRST", "VRCTA", "VRFRE", 
    "VRTOTIPI", "VRTOTPROD", "NRNFCE", "STATUSENOTAS"
)
SELECT 
    src."CDFIL", 
    CAST(src."DTOPE" AS DATE), 
    src."OPERID", 
    src."TPPAG", 
    src."CDCON", 
    src."CDFUN", 
    src."CDCLI", 
    src."CDCONRE", 
    src."CDFUNRE", 
    CAST(src."VRTOT" AS NUMERIC(10, 2)), 
    src."TPDSC", 
    src."PTDSC", 
    CAST(src."VRDSC" AS NUMERIC(10, 2)), 
    CAST(src."VRREC" AS NUMERIC(10, 2)), 
    CAST(src."VRRED" AS NUMERIC(10, 2)), 
    src."CDTXA", 
    CAST(src."VRTXA" AS NUMERIC(10, 2)), 
    CAST(src."VRLIQ" AS NUMERIC(10, 2)), 
    CAST(src."VRTRC" AS NUMERIC(10, 2)), 
    CAST(src."QTTOT" AS NUMERIC(10, 2)), 
    CAST(src."VRCXA" AS NUMERIC(10, 2)), 
    CAST(src."VRRCB" AS NUMERIC(10, 2)), 
    src."CDSER", 
    CAST(src."VRARC" AS NUMERIC(10, 2)), 
    src."NRPED", 
    src."NRNF", 
    src."NRPEDIDO", 
    CAST(src."VTQUANT" AS NUMERIC(10, 2)), 
    src."VTESPECIE", 
    src."VTMARCA", 
    src."VTNUMERO", 
    CAST(src."DTEMI" AS DATE), 
    CAST(src."DTSAI" AS DATE), 
    CAST(src."HRSAI" AS TIME), 
    src."NRINSCRST", 
    CAST(src."VRCTA" AS NUMERIC(10, 2)), 
    CAST(src."VRFRE" AS NUMERIC(10, 2)), 
    CAST(src."VRTOTIPI" AS NUMERIC(10, 2)), 
    CAST(src."VRTOTPROD" AS NUMERIC(10, 2)), 
    src."NRNFCE", 
    src."STATUSENOTAS"
FROM temporary."FC31100" src
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.vendas tgt 
    WHERE tgt."CDFIL" = src."CDFIL"
    AND tgt."DTOPE" = CAST(src."DTOPE" AS DATE)
    AND tgt."OPERID" = src."OPERID"
);


INSERT INTO silver.itensdasvendas (
    "CDFIL", "CDTML", "DTOPE", "OPERID", "ITEMID", "CDFILR", "CDPRO", "QUANT", "PRUNI", 
    "TPDSC", "VRDSC", "VRLIQ", "VRCXA", "TPPAG", "VRTOT", "CDTXA", "VRTXA", "VRDSCV", 
    "VRTXAV", "CDIPI", "PRCUSTO", "PTLUCRO", "DTPRESCR", "QTPRESCR", "PRCOMPRA", 
    "PRUNILIQ", "CDCLI", "NOMEPA", "CDMVTO", "ITEMIDH"
)
SELECT 
    src."CDFIL", 
    src."CDTML", 
    CAST(src."DTOPE" AS DATE), 
    src."OPERID", 
    src."ITEMID", 
    src."CDFILR", 
    src."CDPRO", 
    CAST(src."QUANT" AS NUMERIC(10, 2)), 
    CAST(src."PRUNI" AS NUMERIC(10, 2)), 
    src."TPDSC", 
    CAST(src."VRDSC" AS NUMERIC(10, 2)), 
    CAST(src."VRLIQ" AS NUMERIC(10, 2)), 
    CAST(src."VRCXA" AS NUMERIC(10, 2)), 
    src."TPPAG", 
    CAST(src."VRTOT" AS NUMERIC(10, 2)), 
    src."CDTXA", 
    CAST(src."VRTXA" AS NUMERIC(10, 2)), 
    CAST(src."VRDSCV" AS NUMERIC(10, 2)), 
    CAST(src."VRTXAV" AS NUMERIC(10, 2)), 
    src."CDIPI", 
    CAST(src."PRCUSTO" AS NUMERIC(10, 2)), 
    CAST(src."PTLUCRO" AS NUMERIC(10, 2)), 
    CAST(src."DTPRESCR" AS DATE), 
    CAST(src."QTPRESCR" AS NUMERIC(10, 2)), 
    CAST(src."PRCOMPRA" AS NUMERIC(10, 2)), 
    CAST(src."PRUNILIQ" AS NUMERIC(10, 2)), 
    src."CDCLI", 
    src."NOMEPA", 
    src."CDMVTO", 
    src."ITEMIDH"
FROM temporary."FC31110" src
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.itensdasvendas tgt 
    WHERE tgt."CDFIL" = src."CDFIL"
    AND tgt."CDTML" = src."CDTML"
    AND tgt."DTOPE" = CAST(src."DTOPE" AS DATE)
    AND tgt."OPERID" = src."OPERID"
    AND tgt."ITEMID" = src."ITEMID"
);


INSERT INTO gold.combined_vendas (
    "CDFIL", "DTOPE", "OPERID", "TPPAG", "CDCON", "CDFUN", "CDCLI", "CDCONRE", "CDFUNRE", 
    "VRTOT", "TPDSC", "PTDSC", "VRDSC", "VRREC", "VRRED", "CDTXA", "VRTXA", "VRLIQ", "VRTRC", 
    "QTTOT", "VRCXA", "VRRCB", "CDSER", "VRARC", "NRPED", "NRNF", "NRPEDIDO", "VTQUANT", 
    "VTESPECIE", "VTMARCA", "VTNUMERO", "DTEMI", "DTSAI", "HRSAI", "NRINSCRST", "VRCTA", "VRFRE", 
    "VRTOTIPI", "VRTOTPROD", "NRNFCE", "STATUSENOTAS", "CDTML", "ITEMID", "CDFILR", "CDPRO", 
    "QUANT", "PRUNI", "VRDSCV", "VRTXAV", "CDIPI", "PRCUSTO", "PTLUCRO", "DTPRESCR", "QTPRESCR", 
    "PRCOMPRA", "PRUNILIQ", "NOMEPA", "CDMVTO", "ITEMIDH"
)
SELECT 
    v."CDFIL", v."DTOPE", v."OPERID", v."TPPAG", v."CDCON", v."CDFUN", v."CDCLI", v."CDCONRE", v."CDFUNRE", 
    v."VRTOT", v."TPDSC", v."PTDSC", v."VRDSC", v."VRREC", v."VRRED", v."CDTXA", v."VRTXA", v."VRLIQ", 
    v."VRTRC", v."QTTOT", v."VRCXA", v."VRRCB", v."CDSER", v."VRARC", v."NRPED", v."NRNF", v."NRPEDIDO", 
    v."VTQUANT", v."VTESPECIE", v."VTMARCA", v."VTNUMERO", v."DTEMI", v."DTSAI", v."HRSAI", v."NRINSCRST", 
    v."VRCTA", v."VRFRE", v."VRTOTIPI", v."VRTOTPROD", v."NRNFCE", v."STATUSENOTAS",
    iv."CDTML", iv."ITEMID", iv."CDFILR", CAST(iv."CDPRO" AS INTEGER), iv."QUANT", iv."PRUNI", iv."VRDSCV", iv."VRTXAV", 
    iv."CDIPI", iv."PRCUSTO", iv."PTLUCRO", iv."DTPRESCR", iv."QTPRESCR", iv."PRCOMPRA", iv."PRUNILIQ", 
    iv."NOMEPA", iv."CDMVTO", iv."ITEMIDH"
FROM silver.vendas v
JOIN silver.itensdasvendas iv
ON v."CDFIL" = iv."CDFIL"
AND v."DTOPE" = iv."DTOPE"
AND v."OPERID" = iv."OPERID"
WHERE NOT EXISTS (
    SELECT 1 
    FROM gold.combined_vendas cv
    WHERE cv."CDFIL" = v."CDFIL"
    AND cv."DTOPE" = v."DTOPE"
    AND cv."OPERID" = v."OPERID"
    AND cv."ITEMID" = iv."ITEMID"
);

