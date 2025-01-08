CREATE OR REPLACE FUNCTION temporary.sync_to_silver()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO silver.produtos (
        "CDPRO", 
        "DESCRPRD", 
        "DESCRDET", 
        "DESCR", 
        "SITUA", 
        "GRUPO", 
        "SETOR", 
        "LINHA", 
        "CURVA", 
        "UNIDA", 
        "UNIRC", 
        "MOEDA", 
        "PRCOM", 
        "PRCOMN", 
        "PRVEN", 
        "DTREAJ", 
        "DTCAD", 
        "DTCOM", 
        "NRNOT", 
        "CDICM", 
        "CDIPI", 
        "DOMAX", 
        "UNIDM", 
        "FLAGENV", 
        "DOMINE", 
        "UNIDMINE", 
        "DOMIND", 
        "UNIDMIND", 
        "DTALT", 
        "PRVENMAX", 
        "CDSEMI", 
        "HRALT", 
        "CDPROH"
    )
    SELECT 
        CAST(NEW."CDPRO" AS INTEGER), 
        CAST(NEW."DESCRPRD" AS TEXT), 
        CAST(NEW."DESCRDET" AS TEXT), 
        CAST(NEW."DESCR" AS TEXT), 
        CAST(NEW."SITUA" AS VARCHAR(20)), 
        CAST(NEW."GRUPO" AS VARCHAR(50)), 
        CAST(NEW."SETOR" AS VARCHAR(50)), 
        CAST(NEW."LINHA" AS VARCHAR(50)), 
        CAST(NEW."CURVA" AS CHAR(1)), 
        CAST(NEW."UNIDA" AS VARCHAR(10)), 
        CAST(NEW."UNIRC" AS VARCHAR(10)), 
        CAST(NEW."MOEDA" AS VARCHAR(3)), 
        CAST(NEW."PRCOM" AS NUMERIC(18, 2)), 
        CAST(NEW."PRCOMN" AS NUMERIC(18, 2)), 
        CAST(NEW."PRVEN" AS NUMERIC(18, 2)), 
        CAST(NEW."DTREAJ" AS DATE), 
        CAST(NEW."DTCAD" AS DATE), 
        CAST(NEW."DTCOM" AS DATE), 
        CAST(NEW."NRNOT" AS VARCHAR(20)), 
        CAST(NEW."CDICM" AS NUMERIC(5, 2)), 
        CAST(NEW."CDIPI" AS NUMERIC(5, 2)), 
        CAST(NEW."DOMAX" AS NUMERIC(18, 4)), 
        CAST(NEW."UNIDM" AS VARCHAR(10)), 
        CASE 
            WHEN NEW."FLAGENV" = 'S' THEN TRUE 
            ELSE FALSE 
        END, 
        CAST(NEW."DOMINE" AS NUMERIC(18, 4)), 
        CAST(NEW."UNIDMINE" AS VARCHAR(10)), 
        CAST(NEW."DOMIND" AS NUMERIC(18, 4)), 
        CAST(NEW."UNIDMIND" AS VARCHAR(10)), 
        CAST(NEW."DTALT" AS DATE), 
        CAST(NEW."PRVENMAX" AS NUMERIC(18, 2)), 
        CAST(NEW."CDSEMI" AS VARCHAR(20)), 
        CAST(NEW."HRALT" AS TIME), 
        CAST(NEW."CDPROH" AS VARCHAR(20))
    ON CONFLICT ("CDPRO") DO NOTHING;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_sync_to_silver
AFTER INSERT OR UPDATE ON temporary."FC03000"
FOR EACH ROW
EXECUTE FUNCTION temporary.sync_to_silver();
