-----------------INSERT CAMADA GOLD E SILVER CLIENTES----------------------------------------------------------
INSERT INTO silver.clientes (
    "CDCLI", "CDFIL", "TPCLI", "NRCNPJ", "NRINSCR", "OERG", "TPSEX", "NOMECLI", "DTNAS", "LCNAS", "UFNAS",
    "CDRACACOR", "ECIVIL", "PROFIS", "DTCAD", "NOMEPAI", "NOMEMAE", "NOMECONJ", "INDFUMA", "INDCAFE", "INDALCO",
    "TPSANGUE", "CDOCUP", "OCENDCOR", "EMAIL", "EMAIL2", "HPAGE", "PTDSC", "PTTXA", "OBSERV", "OBSER", "OBSERTER",
    "FLAGENV", "INDCHA", "INDREFRI", "INDBALA", "INDCHOCO", "CDPOT", "OBSPOT", "PTDSCV", "PTDSCD", "UFRG", "TPDOC",
    "DTALT", "NRCARTAO", "CLCLI", "INDSMS", "OCENDERENTREGA", "NRSUFRAMA", "INDISENTOICMS", "TEMPLATE", "CDINDICACAO",
    "REGISTROCLIENTE", "INDMONITORA", "DTREV", "NRINSCRM", "INDDEFVISUAL", "INDEMAIL", "DTALTSYNC", "HRALTSYNC",
    "DELEXTERIOR", "RESP_RETENCION", "RESP_CREE", "INTEGRA_CARTERA", "CODRETENCION", "CODRETICA", "RETIVA", "AIU",
    "REGSIMP", "CDCONV", "DTHRALT", "HASHREG", "VERSAOPAF", "CDPERFILDEST", "INDAPLICATIVOMSG", "INDTELEFONE"
)
SELECT 
    "CDCLI", "CDFIL", "TPCLI", "NRCNPJ", "NRINSCR", "OERG", "TPSEX", "NOMECLI", 
    CAST(NULLIF("DTNAS", '') AS DATE), "LCNAS", "UFNAS",
    "CDRACACOR", "ECIVIL", "PROFIS", 
    CAST(NULLIF("DTCAD", '') AS DATE), "NOMEPAI", "NOMEMAE", "NOMECONJ", 
    CASE WHEN "INDFUMA" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDCAFE" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDALCO" = 'true' THEN TRUE ELSE FALSE END,
    "TPSANGUE", "CDOCUP", "OCENDCOR", "EMAIL", "EMAIL2", "HPAGE", "PTDSC", "PTTXA", "OBSERV", "OBSER", "OBSERTER",
    CASE WHEN "FLAGENV" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDCHA" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDREFRI" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDBALA" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDCHOCO" = 'true' THEN TRUE ELSE FALSE END,
    "CDPOT", "OBSPOT", "PTDSCV", "PTDSCD", "UFRG", "TPDOC",
    CAST(NULLIF("DTALT", '') AS DATE), "NRCARTAO", "CLCLI", 
    CASE WHEN "INDSMS" = 'true' THEN TRUE ELSE FALSE END,
    "OCENDERENTREGA", "NRSUFRAMA", 
    CASE WHEN "INDISENTOICMS" = 'true' THEN TRUE ELSE FALSE END,
    "TEMPLATE", "CDINDICACAO", "REGISTROCLIENTE",
    CASE WHEN "INDMONITORA" = 'true' THEN TRUE ELSE FALSE END,
    CAST(NULLIF("DTREV", '') AS DATE), "NRINSCRM",
    CASE WHEN "INDDEFVISUAL" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDEMAIL" = 'true' THEN TRUE ELSE FALSE END,
    CAST(NULLIF("DTALTSYNC", '') AS DATE), CAST(NULLIF("HRALTSYNC", '') AS TIME),
    CASE WHEN "DELEXTERIOR" = 'true' THEN TRUE ELSE FALSE END,
    "RESP_RETENCION", "RESP_CREE", "INTEGRA_CARTERA", "CODRETENCION", "CODRETICA", "RETIVA", "AIU",
    "REGSIMP", "CDCONV", 
    CAST(NULLIF("DTHRALT", '') AS TIMESTAMP), "HASHREG", "VERSAOPAF", "CDPERFILDEST",
    CASE WHEN "INDAPLICATIVOMSG" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDTELEFONE" = 'true' THEN TRUE ELSE FALSE END
FROM temporary."FC07000" src
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.clientes tgt 
    WHERE src."CDCLI" = tgt."CDCLI"
);


INSERT INTO gold.clientes (
    "CDCLI", "CDFIL", "TPCLI", "NRCNPJ", "NRINSCR", "OERG", "TPSEX", "NOMECLI", "DTNAS", "LCNAS", "UFNAS",
    "CDRACACOR", "ECIVIL", "PROFIS", "DTCAD", "NOMEPAI", "NOMEMAE", "NOMECONJ", "INDFUMA", "INDCAFE", "INDALCO",
    "TPSANGUE", "CDOCUP", "OCENDCOR", "EMAIL", "EMAIL2", "HPAGE", "PTDSC", "PTTXA", "OBSERV", "OBSER", "OBSERTER",
    "FLAGENV", "INDCHA", "INDREFRI", "INDBALA", "INDCHOCO", "CDPOT", "OBSPOT", "PTDSCV", "PTDSCD", "UFRG", "TPDOC",
    "DTALT", "NRCARTAO", "CLCLI", "INDSMS", "OCENDERENTREGA", "NRSUFRAMA", "INDISENTOICMS", "TEMPLATE", "CDINDICACAO",
    "REGISTROCLIENTE", "INDMONITORA", "DTREV", "NRINSCRM", "INDDEFVISUAL", "INDEMAIL", "DTALTSYNC", "HRALTSYNC",
    "DELEXTERIOR", "RESP_RETENCION", "RESP_CREE", "INTEGRA_CARTERA", "CODRETENCION", "CODRETICA", "RETIVA", "AIU",
    "REGSIMP", "CDCONV", "DTHRALT", "HASHREG", "VERSAOPAF", "CDPERFILDEST", "INDAPLICATIVOMSG", "INDTELEFONE"
)
SELECT 
    "CDCLI", "CDFIL", "TPCLI", "NRCNPJ", "NRINSCR", "OERG", "TPSEX", "NOMECLI", 
    CAST("DTNAS" AS DATE), "LCNAS", "UFNAS",
    "CDRACACOR", "ECIVIL", "PROFIS", 
    CAST("DTCAD" AS DATE), "NOMEPAI", "NOMEMAE", "NOMECONJ", 
    CASE WHEN "INDFUMA" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDCAFE" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDALCO" = 'true' THEN TRUE ELSE FALSE END,
    "TPSANGUE", "CDOCUP", "OCENDCOR", "EMAIL", "EMAIL2", "HPAGE", "PTDSC", "PTTXA", "OBSERV", "OBSER", "OBSERTER",
    CASE WHEN "FLAGENV" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDCHA" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDREFRI" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDBALA" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDCHOCO" = 'true' THEN TRUE ELSE FALSE END,
    "CDPOT", "OBSPOT", "PTDSCV", "PTDSCD", "UFRG", "TPDOC",
    CAST("DTALT" AS DATE), "NRCARTAO", "CLCLI", 
    CASE WHEN "INDSMS" = 'true' THEN TRUE ELSE FALSE END,
    "OCENDERENTREGA", "NRSUFRAMA", 
    CASE WHEN "INDISENTOICMS" = 'true' THEN TRUE ELSE FALSE END,
    "TEMPLATE", "CDINDICACAO", "REGISTROCLIENTE",
    CASE WHEN "INDMONITORA" = 'true' THEN TRUE ELSE FALSE END,
    CAST("DTREV" AS DATE), "NRINSCRM",
    CASE WHEN "INDDEFVISUAL" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDEMAIL" = 'true' THEN TRUE ELSE FALSE END,
    CAST("DTALTSYNC" AS DATE), CAST("HRALTSYNC" AS TIME),
    CASE WHEN "DELEXTERIOR" = 'true' THEN TRUE ELSE FALSE END,
    "RESP_RETENCION", "RESP_CREE", "INTEGRA_CARTERA", "CODRETENCION", "CODRETICA", "RETIVA", "AIU",
    "REGSIMP", "CDCONV", 
    CAST("DTHRALT" AS TIMESTAMP), "HASHREG", "VERSAOPAF", "CDPERFILDEST",
    CASE WHEN "INDAPLICATIVOMSG" = 'true' THEN TRUE ELSE FALSE END,
    CASE WHEN "INDTELEFONE" = 'true' THEN TRUE ELSE FALSE END
FROM silver.clientes src
WHERE NOT EXISTS (
    SELECT 1 
    FROM gold.clientes tgt 
    WHERE src."CDCLI" = tgt."CDCLI"
);

-------------------INSERT TABELA SILVER E GOLD VENDAS--------------------------------------------

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




-----------INSERT TABELA SILVER E GOLD NOTAS FISCAIS ---------------------

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

----------------------------INSERT FORNECEDORES SILVER----------------------------------------------------------
INSERT INTO silver.fornecedores (FORNECID, RAZAO, NRCNPJ, FANTA, MUNIC, UNFED)
SELECT 
    CAST(temporary."FC02000"."FORNECID" AS INTEGER), 
    CAST(temporary."FC02000"."RAZAO" AS CHARACTER VARYING), 
    CAST(temporary."FC02000"."NRCNPJ" AS CHARACTER VARYING), 
    CAST(temporary."FC02000"."FANTA" AS CHARACTER VARYING), 
    CAST(temporary."FC02000"."MUNIC" AS CHARACTER VARYING), 
    CAST(temporary."FC02000"."UNFED" AS CHARACTER VARYING)
FROM temporary."FC02000"
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.fornecedores 
    WHERE silver.fornecedores.FORNECID = CAST(temporary."FC02000"."FORNECID" AS INTEGER)
);


-------INSERT SILVER E GOLD TABELA PRODUTOS---------------

INSERT INTO silver.produtos (CDPRO, DESCRPRD, DESCR, GRUPO, SETOR, UNIDA, SITUA, INDCIP, CURVA, LINHA)
SELECT 
    CAST(temporary."FC03000"."CDPRO" AS INTEGER),          
    CAST(temporary."FC03000"."DESCRPRD" AS CHARACTER VARYING(20)), 
    CAST(temporary."FC03000"."DESCR" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."GRUPO" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."SETOR" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."UNIDA" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."SITUA" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."INDCIP" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."CURVA" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."LINHA" AS CHARACTER VARYING)
FROM temporary."FC03000"
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.produtos 
    WHERE silver.produtos.CDPRO = CAST(temporary."FC03000"."CDPRO" AS INTEGER)
);

INSERT INTO gold.produtos (CDPRO, DESCRPRD, DESCR, GRUPO, SETOR, UNIDA, SITUA, INDCIP, CURVA, LINHA)
SELECT 
    CAST(temporary."FC03000"."CDPRO" AS INTEGER),          
    CAST(temporary."FC03000"."DESCRPRD" AS CHARACTER VARYING(20)), 
    CAST(temporary."FC03000"."DESCR" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."GRUPO" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."SETOR" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."UNIDA" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."SITUA" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."INDCIP" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."CURVA" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."LINHA" AS CHARACTER VARYING)
FROM temporary."FC03000"
WHERE NOT EXISTS (
    SELECT 1 
    FROM gold.produtos 
    WHERE gold.produtos.CDPRO = CAST(temporary."FC03000"."CDPRO" AS INTEGER)
);