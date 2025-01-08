-- Inserir DADOS TABELA  PRODUTOS camada GOLd---

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

---inserte tabela combinede vendas camada gold----

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

----insert camada gold de combined_notas fiscais---

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