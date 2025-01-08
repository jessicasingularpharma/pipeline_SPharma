CREATE TABLE IF NOT EXISTS gold.combined_notasfiscais
(
    -- Colunas da tabela notasfiscais
    "CDFIL" VARCHAR(50),        -- Código da Filial
    "FORNECID" INTEGER,         -- Identificador do Fornecedor (Integer)
    "DTENT" DATE,               -- Data de Entrada
    "NRNOT" VARCHAR(50),        -- Número da Nota
    "CDFNR" VARCHAR(50),        -- Código do Fornecedor
    "NRPED" VARCHAR(50),        -- Número do Pedido
    "VRTOT" NUMERIC(10, 2),     -- Valor Total
    "VRDSC" NUMERIC(10, 2),     -- Valor do Desconto
    
    -- Colunas da tabela itensdasnotasfiscais
    "ITEMID" VARCHAR(50),       -- Identificador do Item
    "CDPRO" INTEGER,            -- Código do Produto (Integer)
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
    "CPROD" VARCHAR(50),        -- Código do Produto
    "XPROD" VARCHAR(255),       -- Descrição do Produto
    "CNPJFAB" VARCHAR(20),      -- CNPJ do Fabricante
    "VFRETE" NUMERIC(10, 2)     -- Valor do Frete
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


DELETE FROM silver.itensdasnotasfiscais it
WHERE CAST(it."CDPRO" AS INTEGER) NOT IN (
    SELECT cdpro
    FROM gold.produtos
);


