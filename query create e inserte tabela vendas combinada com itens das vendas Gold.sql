CREATE TABLE IF NOT EXISTS gold.combined_vendas
(
    -- Colunas da tabela vendas
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
    "STATUSENOTAS" VARCHAR(50), -- Status das Notas

    -- Colunas da tabela itensdasvendas
    "CDTML" VARCHAR(50),        -- Código do Terminal
    "ITEMID" VARCHAR(50),       -- Identificador do Item
    "CDFILR" VARCHAR(50),       -- Código da Filial de Recebimento
    "CDPRO" VARCHAR(50),        -- Código do Produto
    "QUANT" NUMERIC(10, 2),     -- Quantidade
    "PRUNI" NUMERIC(10, 2),     -- Preço Unitário
    "VRDSCV" NUMERIC(10, 2),    -- Valor do Desconto com Variação
    "VRTXAV" NUMERIC(10, 2),    -- Valor da Taxa com Variação
    "CDIPI" VARCHAR(50),        -- Código do IPI
    "PRCUSTO" NUMERIC(10, 2),   -- Preço de Custo
    "PTLUCRO" NUMERIC(10, 2),   -- Percentual de Lucro
    "DTPRESCR" DATE,            -- Data da Prescrição
    "QTPRESCR" NUMERIC(10, 2),  -- Quantidade Prescrita
    "PRCOMPRA" NUMERIC(10, 2),  -- Preço de Compra
    "PRUNILIQ" NUMERIC(10, 2),  -- Preço Unitário Líquido
    "NOMEPA" VARCHAR(255),      -- Nome do Pagador
    "CDMVTO" VARCHAR(50),       -- Código de Movimentação
    "ITEMIDH" VARCHAR(50)       -- Identificador do Item na História
);

INSERT INTO gold.combined_vendas (
    "CDFIL", "DTOPE", "OPERID", "TPPAG", "CDCON", "CDFUN", "CDCLI", "CDCONRE", "CDFUNRE", 
    "VRTOT", "TPDSC", "PTDSC", "VRDSC", "VRREC", "VRRED", "CDTXA", "VRTXA", "VRLIQ", "VRTRC", 
    "QTTOT", "VRCXA", "VRRCB", "CDSER", "VRARC", "NRPED", "NRNF", "NRPEDIDO", "VTQUANT", 
    "VTESPECIE", "VTMARCA", "VTNUMERO", "DTEMI", "DTSAI", "HRSAI", "NRINSCRST", "VRCTA", "VRFRE", 
    "VRTOTIPI", "VRTOTPROD", "NRNFCE", "STATUSENOTAS", "CDTML", "ITEMID", "CDFILR", "CDPRO", 
    "QUANT", "PRUNI", "VRDSCV", "VRTXAV", "CDIPI", "PRCUSTO", "PTLUCRO", "DTPRESCR", "QTPRESCR", 
    "PRCOMPRA", "PRUNILIQ", "NOMEPA", "CDMVTO", "ITEMIDH"
)
SELECT 
    v."CDFIL", v."DTOPE", v."OPERID", v."TPPAG", v."CDCON", v."CDFUN", v."CDCLI", v."CDCONRE", v."CDFUNRE", 
    v."VRTOT", v."TPDSC", v."PTDSC", v."VRDSC", v."VRREC", v."VRRED", v."CDTXA", v."VRTXA", v."VRLIQ", 
    v."VRTRC", v."QTTOT", v."VRCXA", v."VRRCB", v."CDSER", v."VRARC", v."NRPED", v."NRNF", v."NRPEDIDO", 
    v."VTQUANT", v."VTESPECIE", v."VTMARCA", v."VTNUMERO", v."DTEMI", v."DTSAI", v."HRSAI", v."NRINSCRST", 
    v."VRCTA", v."VRFRE", v."VRTOTIPI", v."VRTOTPROD", v."NRNFCE", v."STATUSENOTAS",
    iv."CDTML", iv."ITEMID", iv."CDFILR", iv."CDPRO", iv."QUANT", iv."PRUNI", iv."VRDSCV", iv."VRTXAV", 
    iv."CDIPI", iv."PRCUSTO", iv."PTLUCRO", iv."DTPRESCR", iv."QTPRESCR", iv."PRCOMPRA", iv."PRUNILIQ", 
    iv."NOMEPA", iv."CDMVTO", iv."ITEMIDH"
FROM silver.vendas v
JOIN silver.itensdasvendas iv
ON v."CDFIL" = iv."CDFIL"
AND v."DTOPE" = iv."DTOPE"
AND v."OPERID" = iv."OPERID"
WHERE NOT EXISTS (
    SELECT 1 
    FROM gold.combined_vendas cv
    WHERE cv."CDFIL" = v."CDFIL"
    AND cv."DTOPE" = v."DTOPE"
    AND cv."OPERID" = v."OPERID"
    AND cv."ITEMID" = iv."ITEMID"
);



ALTER TABLE gold.combined_vendas
ALTER COLUMN "CDPRO" TYPE INTEGER
USING "CDPRO"::integer;

ALTER TABLE gold.produtos
ALTER COLUMN cdpro TYPE VARCHAR(50);


ALTER TABLE gold.combined_vendas
ADD CONSTRAINT fk_produtos
FOREIGN KEY ("CDPRO")
REFERENCES gold.produtos (cdpro);






-- Verifique o tipo de dados de CDPRO em gold.combined_vendas
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'combined_vendas'
AND column_name = 'CDPRO';

-- Verifique o tipo de dados de cdpro em gold.produtos
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'produtos'
AND column_name = 'cdpro';

-- Alterar o tipo de dados da coluna CDPRO em gold.combined_vendas para INTEGER
ALTER TABLE gold.combined_vendas
ALTER COLUMN "CDPRO" TYPE INTEGER
USING "CDPRO"::integer;

ALTER TABLE gold.combined_vendas
ADD CONSTRAINT fk_produtos
FOREIGN KEY ("CDPRO")
REFERENCES gold.produtos (cdpro);



SELECT DISTINCT "CDPRO"
FROM gold.combined_vendas
WHERE "CDPRO" NOT IN (
    SELECT cdpro
    FROM gold.produtos
);
