CREATE OR REPLACE FUNCTION inserir_dados_vendas_silver()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserir dados na tabela silver.vendas
    INSERT INTO silver.vendas (
        "CDFIL", "DTOPE", "OPERID", "TPPAG", "CDCON", "CDFUN", "CDCLI", "CDCONRE", "CDFUNRE", 
        "VRTOT", "TPDSC", "PTDSC", "VRDSC", "VRREC", "VRRED", "CDTXA", "VRTXA", "VRLIQ", "VRTRC", 
        "QTTOT", "VRCXA", "VRRCB", "CDSER", "VRARC", "NRPED", "NRNF", "NRPEDIDO", "VTQUANT", 
        "VTESPECIE", "VTMARCA", "VTNUMERO", "DTEMI", "DTSAI", "HRSAI", "NRINSCRST", "VRCTA", "VRFRE", 
        "VRTOTIPI", "VRTOTPROD", "NRNFCE", "STATUSENOTAS"
    )
    SELECT 
        NEW."CDFIL", 
        CAST(NEW."DTOPE" AS DATE), 
        NEW."OPERID", 
        NEW."TPPAG", 
        NEW."CDCON", 
        NEW."CDFUN", 
        NEW."CDCLI", 
        NEW."CDCONRE", 
        NEW."CDFUNRE", 
        CAST(NEW."VRTOT" AS NUMERIC(10, 2)), 
        NEW."TPDSC", 
        NEW."PTDSC", 
        CAST(NEW."VRDSC" AS NUMERIC(10, 2)), 
        CAST(NEW."VRREC" AS NUMERIC(10, 2)), 
        CAST(NEW."VRRED" AS NUMERIC(10, 2)), 
        NEW."CDTXA", 
        CAST(NEW."VRTXA" AS NUMERIC(10, 2)), 
        CAST(NEW."VRLIQ" AS NUMERIC(10, 2)), 
        CAST(NEW."VRTRC" AS NUMERIC(10, 2)), 
        CAST(NEW."QTTOT" AS NUMERIC(10, 2)), 
        CAST(NEW."VRCXA" AS NUMERIC(10, 2)), 
        CAST(NEW."VRRCB" AS NUMERIC(10, 2)), 
        NEW."CDSER", 
        CAST(NEW."VRARC" AS NUMERIC(10, 2)), 
        NEW."NRPED", 
        NEW."NRNF", 
        NEW."NRPEDIDO", 
        CAST(NEW."VTQUANT" AS NUMERIC(10, 2)), 
        NEW."VTESPECIE", 
        NEW."VTMARCA", 
        NEW."VTNUMERO", 
        CAST(NEW."DTEMI" AS DATE), 
        CAST(NEW."DTSAI" AS DATE), 
        CAST(NEW."HRSAI" AS TIME), 
        NEW."NRINSCRST", 
        CAST(NEW."VRCTA" AS NUMERIC(10, 2)), 
        CAST(NEW."VRFRE" AS NUMERIC(10, 2)), 
        CAST(NEW."VRTOTIPI" AS NUMERIC(10, 2)), 
        CAST(NEW."VRTOTPROD" AS NUMERIC(10, 2)), 
        NEW."NRNFCE", 
        NEW."STATUSENOTAS"
    WHERE NOT EXISTS (
        SELECT 1 
        FROM silver.vendas tgt 
        WHERE tgt."CDFIL" = NEW."CDFIL"
        AND tgt."DTOPE" = CAST(NEW."DTOPE" AS DATE)
        AND tgt."OPERID" = NEW."OPERID"
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION inserir_itens_silver()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserir dados na tabela silver.itensdasvendas
    INSERT INTO silver.itensdasvendas (
        "CDFIL", "CDTML", "DTOPE", "OPERID", "ITEMID", "CDFILR", "CDPRO", "QUANT", "PRUNI", 
        "TPDSC", "VRDSC", "VRLIQ", "VRCXA", "TPPAG", "VRTOT", "CDTXA", "VRTXA", "VRDSCV", 
        "VRTXAV", "CDIPI", "PRCUSTO", "PTLUCRO", "DTPRESCR", "QTPRESCR", "PRCOMPRA", 
        "PRUNILIQ", "CDCLI", "NOMEPA", "CDMVTO", "ITEMIDH"
    )
    SELECT 
        NEW."CDFIL", 
        NEW."CDTML", 
        CAST(NEW."DTOPE" AS DATE), 
        NEW."OPERID", 
        NEW."ITEMID", 
        NEW."CDFILR", 
        NEW."CDPRO", 
        CAST(NEW."QUANT" AS NUMERIC(10, 2)), 
        CAST(NEW."PRUNI" AS NUMERIC(10, 2)), 
        NEW."TPDSC", 
        CAST(NEW."VRDSC" AS NUMERIC(10, 2)), 
        CAST(NEW."VRLIQ" AS NUMERIC(10, 2)), 
        CAST(NEW."VRCXA" AS NUMERIC(10, 2)), 
        NEW."TPPAG", 
        CAST(NEW."VRTOT" AS NUMERIC(10, 2)), 
        NEW."CDTXA", 
        CAST(NEW."VRTXA" AS NUMERIC(10, 2)), 
        CAST(NEW."VRDSCV" AS NUMERIC(10, 2)), 
        CAST(NEW."VRTXAV" AS NUMERIC(10, 2)), 
        NEW."CDIPI", 
        CAST(NEW."PRCUSTO" AS NUMERIC(10, 2)), 
        CAST(NEW."PTLUCRO" AS NUMERIC(10, 2)), 
        CAST(NEW."DTPRESCR" AS DATE), 
        CAST(NEW."QTPRESCR" AS NUMERIC(10, 2)), 
        CAST(NEW."PRCOMPRA" AS NUMERIC(10, 2)), 
        CAST(NEW."PRUNILIQ" AS NUMERIC(10, 2)), 
        NEW."CDCLI", 
        NEW."NOMEPA", 
        NEW."CDMVTO", 
        NEW."ITEMIDH"
    WHERE NOT EXISTS (
        SELECT 1 
        FROM silver.itensdasvendas tgt 
        WHERE tgt."CDFIL" = NEW."CDFIL"
        AND tgt."CDTML" = NEW."CDTML"
        AND tgt."DTOPE" = CAST(NEW."DTOPE" AS DATE)
        AND tgt."OPERID" = NEW."OPERID"
        AND tgt."ITEMID" = NEW."ITEMID"
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;




CREATE TRIGGER trg_inserir_dados_vendas_silver
AFTER INSERT ON temporary."FC31100"
FOR EACH ROW
EXECUTE FUNCTION inserir_dados_vendas_silver();

CREATE TRIGGER trg_inserir_itens_silver
AFTER INSERT ON temporary."FC31110"
FOR EACH ROW
EXECUTE FUNCTION inserir_itens_silver();


