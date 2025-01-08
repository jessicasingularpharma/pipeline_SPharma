CREATE TABLE IF NOT EXISTS silver.vendas
(
    "CDFIL" VARCHAR(50),        -- Código da Filial
    "DTOPE" DATE,               -- Data da Operação
    "OPERID" VARCHAR(50),       -- Identificador da Operação
    "TPPAG" VARCHAR(50),        -- Tipo de Pagamento
    "CDCON" VARCHAR(50),        -- Código do Contrato
    "CDFUN" VARCHAR(50),        -- Código da Função
    "CDCLI" VARCHAR(50),        -- Código do Cliente
    "CDCONRE" VARCHAR(50),      -- Código do Contrato de Recebimento
    "CDFUNRE" VARCHAR(50),      -- Código da Função de Recebimento
    "VRTOT" NUMERIC(10, 2),     -- Valor Total
    "TPDSC" VARCHAR(50),        -- Tipo de Desconto
    "PTDSC" VARCHAR(50),        -- Percentual de Desconto
    "VRDSC" NUMERIC(10, 2),     -- Valor do Desconto
    "VRREC" NUMERIC(10, 2),     -- Valor Recebido
    "VRRED" NUMERIC(10, 2),     -- Valor Reduzido
    "CDTXA" VARCHAR(50),        -- Código da Taxa
    "VRTXA" NUMERIC(10, 2),     -- Valor da Taxa
    "VRLIQ" NUMERIC(10, 2),     -- Valor Líquido
    "VRTRC" NUMERIC(10, 2),     -- Valor de Troca
    "QTTOT" NUMERIC(10, 2),     -- Quantidade Total
    "VRCXA" NUMERIC(10, 2),     -- Valor em Caixa
    "VRRCB" NUMERIC(10, 2),     -- Valor Recebido de Volta
    "CDSER" VARCHAR(50),        -- Código do Serviço
    "VRARC" NUMERIC(10, 2),     -- Valor do Arquivo
    "NRPED" VARCHAR(50),        -- Número do Pedido
    "NRNF" VARCHAR(50),         -- Número da Nota Fiscal
    "NRPEDIDO" VARCHAR(50),     -- Número do Pedido
    "VTQUANT" NUMERIC(10, 2),   -- Volume da Quantidade
    "VTESPECIE" VARCHAR(50),    -- Especificação do Volume
    "VTMARCA" VARCHAR(50),      -- Marca do Volume
    "VTNUMERO" VARCHAR(50),     -- Número do Volume
    "DTEMI" DATE,               -- Data de Emissão
    "DTSAI" DATE,               -- Data de Saída
    "HRSAI" TIME,               -- Hora de Saída
    "NRINSCRST" VARCHAR(50),    -- Número de Inscrição Estadual
    "VRCTA" NUMERIC(10, 2),     -- Valor da Conta
    "VRFRE" NUMERIC(10, 2),     -- Valor do Frete
    "VRTOTIPI" NUMERIC(10, 2),  -- Valor Total do IPI
    "VRTOTPROD" NUMERIC(10, 2), -- Valor Total dos Produtos
    "NRNFCE" VARCHAR(50),       -- Número da NFC-e
    "STATUSENOTAS" VARCHAR(50)  -- Status das Notas
);

INSERT INTO silver.vendas (
    "CDFIL", "DTOPE", "OPERID", "TPPAG", "CDCON", "CDFUN", "CDCLI", "CDCONRE", "CDFUNRE", 
    "VRTOT", "TPDSC", "PTDSC", "VRDSC", "VRREC", "VRRED", "CDTXA", "VRTXA", "VRLIQ", "VRTRC", 
    "QTTOT", "VRCXA", "VRRCB", "CDSER", "VRARC", "NRPED", "NRNF", "NRPEDIDO", "VTQUANT", 
    "VTESPECIE", "VTMARCA", "VTNUMERO", "DTEMI", "DTSAI", "HRSAI", "NRINSCRST", "VRCTA", "VRFRE", 
    "VRTOTIPI", "VRTOTPROD", "NRNFCE", "STATUSENOTAS"
)
SELECT 
    src."CDFIL", 
    CAST(src."DTOPE" AS DATE), 
    src."OPERID", 
    src."TPPAG", 
    src."CDCON", 
    src."CDFUN", 
    src."CDCLI", 
    src."CDCONRE", 
    src."CDFUNRE", 
    CAST(src."VRTOT" AS NUMERIC(10, 2)), 
    src."TPDSC", 
    src."PTDSC", 
    CAST(src."VRDSC" AS NUMERIC(10, 2)), 
    CAST(src."VRREC" AS NUMERIC(10, 2)), 
    CAST(src."VRRED" AS NUMERIC(10, 2)), 
    src."CDTXA", 
    CAST(src."VRTXA" AS NUMERIC(10, 2)), 
    CAST(src."VRLIQ" AS NUMERIC(10, 2)), 
    CAST(src."VRTRC" AS NUMERIC(10, 2)), 
    CAST(src."QTTOT" AS NUMERIC(10, 2)), 
    CAST(src."VRCXA" AS NUMERIC(10, 2)), 
    CAST(src."VRRCB" AS NUMERIC(10, 2)), 
    src."CDSER", 
    CAST(src."VRARC" AS NUMERIC(10, 2)), 
    src."NRPED", 
    src."NRNF", 
    src."NRPEDIDO", 
    CAST(src."VTQUANT" AS NUMERIC(10, 2)), 
    src."VTESPECIE", 
    src."VTMARCA", 
    src."VTNUMERO", 
    CAST(src."DTEMI" AS DATE), 
    CAST(src."DTSAI" AS DATE), 
    CAST(src."HRSAI" AS TIME), 
    src."NRINSCRST", 
    CAST(src."VRCTA" AS NUMERIC(10, 2)), 
    CAST(src."VRFRE" AS NUMERIC(10, 2)), 
    CAST(src."VRTOTIPI" AS NUMERIC(10, 2)), 
    CAST(src."VRTOTPROD" AS NUMERIC(10, 2)), 
    src."NRNFCE", 
    src."STATUSENOTAS"
FROM temporary."FC31100" src
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.vendas tgt 
    WHERE tgt."CDFIL" = src."CDFIL"
    AND tgt."DTOPE" = CAST(src."DTOPE" AS DATE)
    AND tgt."OPERID" = src."OPERID"
);
