CREATE OR REPLACE FUNCTION insert_into_silver_notasfiscais()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO silver.notasfiscais (
        "CDFIL", "FORNECID", "DTENT", "NRNOT", "CDFNR", "NRPED", "VRTOT", "VRDSC"
    )
    SELECT 
        NEW."CDFIL", 
        NEW."FORNECID", 
        CAST(NEW."DTENT" AS DATE), 
        NEW."NRNOT", 
        NEW."CDFNR", 
        NEW."NRPED", 
        CAST(NEW."VRTOT" AS NUMERIC(10, 2)), 
        CAST(NEW."VRDSC" AS NUMERIC(10, 2))
    WHERE NOT EXISTS (
        SELECT 1 
        FROM silver.notasfiscais tgt 
        WHERE tgt."CDFIL" = NEW."CDFIL" 
        AND tgt."FORNECID" = NEW."FORNECID" 
        AND tgt."DTENT" = CAST(NEW."DTENT" AS DATE)
        AND tgt."NRNOT" = NEW."NRNOT"
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_into_silver_itensdasnotasfiscais()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO silver.itensdasnotasfiscais (
        "CDFIL", "FORNECID", "DTENT", "NRNOT", "ITEMID", "CDFNR", "CDPRO", "QUANT", "UNIDA", 
        "PRUNI", "PRUNIR", "QTREAL", "NRLOT", "DTFAB", "DTVAL", "CTLOT", "CDPROUNITARIO", 
        "INDFRACI", "FRACI", "VRDSC", "VRTOT", "CPROD", "XPROD", "CNPJFAB", "VFRETE"
    )
    SELECT 
        NEW."CDFIL", 
        NEW."FORNECID", 
        CAST(NEW."DTENT" AS DATE), 
        NEW."NRNOT", 
        NEW."ITEMID", 
        NEW."CDFNR", 
        NEW."CDPRO", 
        CAST(NEW."QUANT" AS NUMERIC(10, 2)), 
        NEW."UNIDA", 
        CAST(NEW."PRUNI" AS NUMERIC(10, 2)), 
        CAST(NEW."PRUNIR" AS NUMERIC(10, 2)), 
        CAST(NEW."QTREAL" AS NUMERIC(10, 2)), 
        NEW."NRLOT", 
        CAST(NEW."DTFAB" AS DATE), 
        CAST(NEW."DTVAL" AS DATE), 
        NEW."CTLOT", 
        NEW."CDPROUNITARIO", 
        CASE WHEN NEW."INDFRACI" = 'S' THEN TRUE ELSE FALSE END, 
        CAST(NEW."FRACI" AS NUMERIC(10, 2)), 
        CAST(NEW."VRDSC" AS NUMERIC(10, 2)), 
        CAST(NEW."VRTOT" AS NUMERIC(10, 2)), 
        NEW."CPROD", 
        NEW."XPROD", 
        NEW."CNPJFAB", 
        CAST(NEW."VFRETE" AS NUMERIC(10, 2))
    WHERE NOT EXISTS (
        SELECT 1 
        FROM silver.itensdasnotasfiscais tgt 
        WHERE tgt."CDFIL" = NEW."CDFIL"
        AND tgt."FORNECID" = NEW."FORNECID"
        AND tgt."DTENT" = CAST(NEW."DTENT" AS DATE)
        AND tgt."NRNOT" = NEW."NRNOT"
        AND tgt."ITEMID" = NEW."ITEMID"
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION insert_into_gold_combined_notasfiscais()
RETURNS TRIGGER AS $$
BEGIN
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

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_insert_into_silver_notasfiscais
AFTER INSERT OR UPDATE ON temporary."FC11000"
FOR EACH ROW EXECUTE FUNCTION insert_into_silver_notasfiscais();

CREATE TRIGGER trigger_insert_into_silver_itensdasnotasfiscais
AFTER INSERT OR UPDATE ON temporary."FC11100"
FOR EACH ROW EXECUTE FUNCTION insert_into_silver_itensdasnotasfiscais();

CREATE TRIGGER trigger_insert_into_gold_combined_notasfiscais
AFTER INSERT OR UPDATE ON silver.notasfiscais
FOR EACH ROW EXECUTE FUNCTION insert_into_gold_combined_notasfiscais();
