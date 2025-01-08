CREATE TABLE IF NOT EXISTS gold.clientes
(
    "CDCLI" VARCHAR(50) PRIMARY KEY, -- Identificador único do cliente
    "CDFIL" VARCHAR(50),
    "TPCLI" VARCHAR(50),
    "NRCNPJ" VARCHAR(20),
    "NRINSCR" VARCHAR(20),
    "OERG" VARCHAR(10),
    "TPSEX" CHAR(1), -- M (masculino) ou F (feminino)
    "NOMECLI" VARCHAR(255),
    "DTNAS" DATE,
    "LCNAS" VARCHAR(100),
    "UFNAS" CHAR(2),
    "CDRACACOR" VARCHAR(10),
    "ECIVIL" VARCHAR(20),
    "PROFIS" VARCHAR(100),
    "DTCAD" DATE, -- Data de cadastro
    "NOMEPAI" VARCHAR(255),
    "NOMEMAE" VARCHAR(255),
    "NOMECONJ" VARCHAR(255),
    "INDFUMA" BOOLEAN,
    "INDCAFE" BOOLEAN,
    "INDALCO" BOOLEAN,
    "TPSANGUE" VARCHAR(3),
    "CDOCUP" VARCHAR(50),
    "OCENDCOR" VARCHAR(255),
    "EMAIL" VARCHAR(255),
    "EMAIL2" VARCHAR(255),
    "HPAGE" VARCHAR(255),
    "PTDSC" VARCHAR(255),
    "PTTXA" VARCHAR(255),
    "OBSERV" TEXT,
    "OBSER" TEXT,
    "OBSERTER" TEXT,
    "FLAGENV" BOOLEAN,
    "INDCHA" BOOLEAN,
    "INDREFRI" BOOLEAN,
    "INDBALA" BOOLEAN,
    "INDCHOCO" BOOLEAN,
    "CDPOT" VARCHAR(50),
    "OBSPOT" TEXT,
    "PTDSCV" VARCHAR(50),
    "PTDSCD" VARCHAR(50),
    "UFRG" VARCHAR(2),
    "TPDOC" VARCHAR(20),
    "DTALT" DATE,
    "NRCARTAO" VARCHAR(50),
    "CLCLI" VARCHAR(50),
    "INDSMS" BOOLEAN,
    "OCENDERENTREGA" VARCHAR(255),
    "NRSUFRAMA" VARCHAR(20),
    "INDISENTOICMS" BOOLEAN,
    "TEMPLATE" TEXT,
    "CDINDICACAO" VARCHAR(50),
    "REGISTROCLIENTE" VARCHAR(255),
    "INDMONITORA" BOOLEAN,
    "DTREV" DATE,
    "NRINSCRM" VARCHAR(20),
    "INDDEFVISUAL" BOOLEAN,
    "INDEMAIL" BOOLEAN,
    "DTALTSYNC" DATE,
    "HRALTSYNC" TIME,
    "DELEXTERIOR" BOOLEAN,
    "RESP_RETENCION" VARCHAR(50),
    "RESP_CREE" VARCHAR(50),
    "INTEGRA_CARTERA" VARCHAR(50),
    "CODRETENCION" VARCHAR(50),
    "CODRETICA" VARCHAR(50),
    "RETIVA" VARCHAR(50),
    "AIU" VARCHAR(50),
    "REGSIMP" VARCHAR(50),
    "CDCONV" VARCHAR(50),
    "DTHRALT" TIMESTAMP,
    "HASHREG" VARCHAR(255),
    "VERSAOPAF" VARCHAR(50),
    "CDPERFILDEST" VARCHAR(50),
    "INDAPLICATIVOMSG" BOOLEAN,
    "INDTELEFONE" BOOLEAN
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
