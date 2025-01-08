CREATE TABLE IF NOT EXISTS silver.itensdasnotasfiscais
(
    "CDFIL" VARCHAR(50),        -- Código da Filial
    "FORNECID" VARCHAR(50),     -- Identificador do Fornecedor
    "DTENT" DATE,               -- Data de Entrada
    "NRNOT" VARCHAR(50),        -- Número da Nota
    "ITEMID" VARCHAR(50),       -- Identificador do Item
    "CDFNR" VARCHAR(50),        -- Código do Fornecedor
    "CDPRO" VARCHAR(50),        -- Código do Produto
    "QUANT" NUMERIC(10, 2),     -- Quantidade
    "UNIDA" VARCHAR(20),        -- Unidade
    "PRUNI" NUMERIC(10, 2),     -- Preço Unitário
    "PRUNIR" NUMERIC(10, 2),    -- Preço Unitário Real
    "QTREAL" NUMERIC(10, 2),    -- Quantidade Real
    "NRLOT" VARCHAR(50),        -- Número do Lote
    "DTFAB" DATE,               -- Data de Fabricação
    "DTVAL" DATE,               -- Data de Validade
    "CTLOT" VARCHAR(50),        -- Contém Lote
    "CDPROUNITARIO" VARCHAR(50),-- Código do Produto Unitário
    "INDFRACI" BOOLEAN,         -- Indicador de Fracionamento
    "FRACI" NUMERIC(10, 2),     -- Fracionamento
    "VRDSC" NUMERIC(10, 2),     -- Valor do Desconto
    "VRTOT" NUMERIC(10, 2),     -- Valor Total
    "CPROD" VARCHAR(50),        -- Código do Produto
    "XPROD" VARCHAR(255),       -- Descrição do Produto
    "CNPJFAB" VARCHAR(20),      -- CNPJ do Fabricante
    "VFRETE" NUMERIC(10, 2)     -- Valor do Frete
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

