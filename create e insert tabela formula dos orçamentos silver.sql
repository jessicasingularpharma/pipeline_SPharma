CREATE TABLE IF NOT EXISTS silver.formulasorçamentos
(
    "CDFIL" VARCHAR,
    "NRORC" VARCHAR,
    "SERIEO" VARCHAR,
    "PFCRM" VARCHAR,
    "UFCRM" VARCHAR,
    "NRCRM" VARCHAR,
    "VOLUME" NUMERIC,
    "UNIVOL" VARCHAR,
    "TPCAP" VARCHAR,
    "QTFOR" NUMERIC,
    "QTCONT" NUMERIC,
    "TITROT" VARCHAR,
    "ROTULOID" VARCHAR,
    "PRCOBR" NUMERIC,
    "PTTXA" NUMERIC,
    "VRTXA" NUMERIC,
    "PTDSC" NUMERIC,
    "VRDSC" NUMERIC,
    "PRREAL" NUMERIC,
    "DTRET" DATE,
    "HRRET" TIME,
    "PRCUSTO" NUMERIC,
    "CDCONRE" VARCHAR,
    "CDFUNRE" VARCHAR,
    "CDCONDG" VARCHAR,
    "CDFUNDG" VARCHAR,
    "QTAPROV" NUMERIC,
    "CDFRM" VARCHAR,
    "CDEMB" VARCHAR,
    "DTENTR" DATE,
    "INDQSP" BOOLEAN,
    "ID" SERIAL PRIMARY KEY,
    "DTCAD" DATE,
    "HRCAD" TIME,
    "VOLUMEORI" NUMERIC,
    "INDCALCVOL" BOOLEAN,
    "UNIVOLORI" VARCHAR,
    "UNICONT" VARCHAR,
    "DTVAL" DATE,
    "POSOL" VARCHAR,
    "CDCLI" VARCHAR,
    "NOMEPA" VARCHAR,
    "ENDEPA" VARCHAR,
    "FTENCHCAP" NUMERIC,
    "FTENCHFOR" NUMERIC,
    "FTCOMPRESSAO" NUMERIC,
    "FTSOBRECARGA" NUMERIC,
    "INDREVENTERICO" BOOLEAN,
    "INDLIBLENTA" BOOLEAN,
    "FTCOMPREXCIP" NUMERIC,
    "GRUPOTERAP" VARCHAR,
    "PRCOMPRA" NUMERIC,
    "CDPRESCRICAOWEB" VARCHAR,
    "PTDSCPROG" NUMERIC,
    "DTPRESCR" DATE,
    "QTPRESCR" NUMERIC,
    "INDPAG" BOOLEAN,
    "INDUSOCONT" BOOLEAN,
    "QTDIASTRAT" NUMERIC,
    "TPFORMAFARMA" VARCHAR,
    "INDBLISTER" BOOLEAN,
    "DTVENCPRESCR" DATE,
    "INDPREAPROV" BOOLEAN,
    "DTLAB" DATE,
    "HRLAB" TIME,
    "CDFILOFON" VARCHAR,
    "NRORCFON" VARCHAR,
    "SERIEOFON" VARCHAR,
    "IDPEDIDOOMNICHANNEL" VARCHAR,
    "OBSERFIC" TEXT,
    "HRPRESCR" TIME,
    "DTMODIFICACAO" DATE,
    "INDREPET" BOOLEAN,
    "BAIRRPA" VARCHAR,
    "MUNICPA" VARCHAR,
    "NRCEPPA" VARCHAR,
    "NUMRGR" VARCHAR,
    "DTNASPA" DATE,
    "TPSEXPA" VARCHAR,
    "PESOANIMAL" NUMERIC,
    "CODESPECIE" VARCHAR,
    "CODRACA" VARCHAR,
    "FORMA" VARCHAR,
    "IDSUGESTAO" VARCHAR,
    "TPPA" VARCHAR,
    "CDPET" VARCHAR,
    "INDLIBLENTAINT" BOOLEAN,
    "TPCAPSULAINT" VARCHAR
);

INSERT INTO silver.formulasorçamentos (
    "CDFIL", "NRORC", "SERIEO", "PFCRM", "UFCRM", "NRCRM", "VOLUME", "UNIVOL", "TPCAP", "QTFOR", "QTCONT",
    "TITROT", "ROTULOID", "PRCOBR", "PTTXA", "VRTXA", "PTDSC", "VRDSC", "PRREAL", "DTRET", "HRRET", "PRCUSTO",
    "CDCONRE", "CDFUNRE", "CDCONDG", "CDFUNDG", "QTAPROV", "CDFRM", "CDEMB", "DTENTR", "INDQSP", "DTCAD",
    "HRCAD", "VOLUMEORI", "INDCALCVOL", "UNIVOLORI", "UNICONT", "DTVAL", "POSOL", "CDCLI", "NOMEPA", "ENDEPA",
    "FTENCHCAP", "FTENCHFOR", "FTCOMPRESSAO", "FTSOBRECARGA", "INDREVENTERICO", "INDLIBLENTA", "FTCOMPREXCIP",
    "GRUPOTERAP", "PRCOMPRA", "CDPRESCRICAOWEB", "PTDSCPROG", "DTPRESCR", "QTPRESCR", "INDPAG", "INDUSOCONT",
    "QTDIASTRAT", "TPFORMAFARMA", "INDBLISTER", "DTVENCPRESCR", "INDPREAPROV", "DTLAB", "HRLAB", "CDFILOFON",
    "NRORCFON", "SERIEOFON", "IDPEDIDOOMNICHANNEL", "OBSERFIC", "HRPRESCR", "DTMODIFICACAO", "INDREPET", "BAIRRPA",
    "MUNICPA", "NRCEPPA", "NUMRGR", "DTNASPA", "TPSEXPA", "PESOANIMAL", "CODESPECIE", "CODRACA", "FORMA", "IDSUGESTAO",
    "TPPA", "CDPET", "INDLIBLENTAINT", "TPCAPSULAINT"
)
SELECT 
    "CDFIL", "NRORC", "SERIEO", "PFCRM", "UFCRM", "NRCRM", CAST("VOLUME" AS NUMERIC), "UNIVOL", "TPCAP", 
    CAST("QTFOR" AS NUMERIC), CAST("QTCONT" AS NUMERIC), "TITROT", "ROTULOID", CAST("PRCOBR" AS NUMERIC), 
    CAST("PTTXA" AS NUMERIC), CAST("VRTXA" AS NUMERIC), CAST("PTDSC" AS NUMERIC), CAST("VRDSC" AS NUMERIC), 
    CAST("PRREAL" AS NUMERIC), CAST("DTRET" AS DATE), CAST("HRRET" AS TIME), CAST("PRCUSTO" AS NUMERIC), "CDCONRE", 
    "CDFUNRE", "CDCONDG", "CDFUNDG", CAST("QTAPROV" AS NUMERIC), "CDFRM", "CDEMB", CAST("DTENTR" AS DATE), 
    CASE WHEN "INDQSP" = 'S' THEN TRUE ELSE FALSE END, 
    CAST("DTCAD" AS DATE), CAST("HRCAD" AS TIME), CAST("VOLUMEORI" AS NUMERIC), 
    CASE WHEN "INDCALCVOL" = 'S' THEN TRUE ELSE FALSE END, 
    "UNIVOLORI", "UNICONT", CAST("DTVAL" AS DATE), "POSOL", "CDCLI", "NOMEPA", 
    "ENDEPA", CAST("FTENCHCAP" AS NUMERIC), CAST("FTENCHFOR" AS NUMERIC), CAST("FTCOMPRESSAO" AS NUMERIC), 
    CAST("FTSOBRECARGA" AS NUMERIC), CASE WHEN "INDREVENTERICO" = 'S' THEN TRUE ELSE FALSE END, 
    CASE WHEN "INDLIBLENTA" = 'S' THEN TRUE ELSE FALSE END, 
    CAST("FTCOMPREXCIP" AS NUMERIC), "GRUPOTERAP", CAST("PRCOMPRA" AS NUMERIC), "CDPRESCRICAOWEB", 
    CAST("PTDSCPROG" AS NUMERIC), CAST("DTPRESCR" AS DATE), CAST("QTPRESCR" AS NUMERIC), 
    CASE WHEN "INDPAG" = 'S' THEN TRUE ELSE FALSE END, 
    CASE WHEN "INDUSOCONT" = 'S' THEN TRUE ELSE FALSE END, 
    CAST("QTDIASTRAT" AS NUMERIC), "TPFORMAFARMA", CASE WHEN "INDBLISTER" = 'S' THEN TRUE ELSE FALSE END, 
    CAST("DTVENCPRESCR" AS DATE), CASE WHEN "INDPREAPROV" = 'S' THEN TRUE ELSE FALSE END, 
    CAST("DTLAB" AS DATE), CAST("HRLAB" AS TIME), "CDFILOFON", "NRORCFON", "SERIEOFON", "IDPEDIDOOMNICHANNEL", 
    "OBSERFIC", CAST("HRPRESCR" AS TIME), CAST("DTMODIFICACAO" AS DATE), 
    CASE WHEN "INDREPET" = 'S' THEN TRUE ELSE FALSE END, 
    "BAIRRPA", "MUNICPA", "NRCEPPA", "NUMRGR", CAST("DTNASPA" AS DATE), "TPSEXPA", 
    CAST("PESOANIMAL" AS NUMERIC), "CODESPECIE", "CODRACA", "FORMA", "IDSUGESTAO", 
    "TPPA", "CDPET", CASE WHEN "INDLIBLENTAINT" = 'S' THEN TRUE ELSE FALSE END, "TPCAPSULAINT"
FROM temporary."FC15100"
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.formulasorçamentos 
    WHERE silver.formulasorçamentos."CDFIL" = temporary."FC15100"."CDFIL"
    AND silver.formulasorçamentos."NRORC" = temporary."FC15100"."NRORC"
    AND silver.formulasorçamentos."SERIEO" = temporary."FC15100"."SERIEO"
);


