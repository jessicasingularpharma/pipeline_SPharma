CREATE TABLE IF NOT EXISTS silver.itensdasvendas
(
    "CDFIL" VARCHAR(50),        -- Código da Filial
    "CDTML" VARCHAR(50),        -- Código do Terminal
    "DTOPE" DATE,               -- Data da Operação
    "OPERID" VARCHAR(50),       -- Identificador da Operação
    "ITEMID" VARCHAR(50),       -- Identificador do Item
    "CDFILR" VARCHAR(50),       -- Código da Filial de Recebimento
    "CDPRO" VARCHAR(50),        -- Código do Produto
    "QUANT" NUMERIC(10, 2),     -- Quantidade
    "PRUNI" NUMERIC(10, 2),     -- Preço Unitário
    "TPDSC" VARCHAR(50),        -- Tipo de Desconto
    "VRDSC" NUMERIC(10, 2),     -- Valor do Desconto
    "VRLIQ" NUMERIC(10, 2),     -- Valor Líquido
    "VRCXA" NUMERIC(10, 2),     -- Valor em Caixa
    "TPPAG" VARCHAR(50),        -- Tipo de Pagamento
    "VRTOT" NUMERIC(10, 2),     -- Valor Total
    "CDTXA" VARCHAR(50),        -- Código da Taxa
    "VRTXA" NUMERIC(10, 2),     -- Valor da Taxa
    "VRDSCV" NUMERIC(10, 2),    -- Valor do Desconto com Variação
    "VRTXAV" NUMERIC(10, 2),    -- Valor da Taxa com Variação
    "CDIPI" VARCHAR(50),        -- Código do IPI
    "PRCUSTO" NUMERIC(10, 2),   -- Preço de Custo
    "PTLUCRO" NUMERIC(10, 2),   -- Percentual de Lucro
    "DTPRESCR" DATE,            -- Data da Prescrição
    "QTPRESCR" NUMERIC(10, 2),  -- Quantidade Prescrita
    "PRCOMPRA" NUMERIC(10, 2),  -- Preço de Compra
    "PRUNILIQ" NUMERIC(10, 2),  -- Preço Unitário Líquido
    "CDCLI" VARCHAR(50),        -- Código do Cliente
    "NOMEPA" VARCHAR(255),      -- Nome do Pagador
    "CDMVTO" VARCHAR(50),       -- Código de Movimentação
    "ITEMIDH" VARCHAR(50)       -- Identificador do Item na História
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
