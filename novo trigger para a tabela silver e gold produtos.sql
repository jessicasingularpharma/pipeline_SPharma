CREATE OR REPLACE FUNCTION sync_to_gold()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o registro já existe na tabela gold
    IF NOT EXISTS (
        SELECT 1 
        FROM gold.produtos
        WHERE "CDPRO" = NEW."CDPRO"
    ) THEN
        -- Insere o novo registro na tabela gold
        INSERT INTO gold.produtos (
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
        VALUES (
            NEW."CDPRO", 
            NEW."DESCRPRD", 
            NEW."DESCRDET", 
            NEW."DESCR", 
            NEW."SITUA", 
            NEW."GRUPO", 
            NEW."SETOR", 
            NEW."LINHA", 
            NEW."CURVA", 
            NEW."UNIDA", 
            NEW."UNIRC", 
            NEW."MOEDA", 
            NEW."PRCOM", 
            NEW."PRCOMN", 
            NEW."PRVEN", 
            NEW."DTREAJ", 
            NEW."DTCAD", 
            NEW."DTCOM", 
            NEW."NRNOT", 
            NEW."CDICM", 
            NEW."CDIPI", 
            NEW."DOMAX", 
            NEW."UNIDM", 
            NEW."FLAGENV", 
            NEW."DOMINE", 
            NEW."UNIDMINE", 
            NEW."DOMIND", 
            NEW."UNIDMIND", 
            NEW."DTALT", 
            NEW."PRVENMAX", 
            NEW."CDSEMI", 
            NEW."HRALT", 
            NEW."CDPROH"
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER sync_silver_to_gold
AFTER INSERT OR UPDATE ON silver.produtos
FOR EACH ROW
EXECUTE FUNCTION sync_to_gold();

