INSERT INTO golden.dim_clientes (codigo_cliente, nome_cliente, sexo, data_cadastro)
SELECT DISTINCT "CDCLI", "NOMECLI", "TPSEX", "DTCAD"
FROM gold.clientes gc
WHERE NOT EXISTS (
    SELECT 1
    FROM golden.dim_clientes dc
    WHERE dc.codigo_cliente = gc."CDCLI"
);


INSERT INTO golden.dim_fornecedores (codigo_fornecedor, razao_social, cnpj, fantasia, municipio, uf)
SELECT DISTINCT fornecid, razao, nrcnpj, fanta, munic, unfed
FROM gold.fornecedores gf
WHERE NOT EXISTS (
    SELECT 1
    FROM golden.dim_fornecedores df
    WHERE df.codigo_fornecedor = gf.fornecid
);


INSERT INTO golden.dim_produtos (codigo_produto, descricao_produto, grupo, setor, linha, curva, unidade, preco_compra, preco_venda, data_cadastro, situacao)
SELECT DISTINCT "CDPRO", "DESCRPRD", "GRUPO", "SETOR", "LINHA", "CURVA", "UNIDA", "PRCOM", "PRVEN", "DTCAD", "SITUA"
FROM gold.produtos gp
WHERE NOT EXISTS (
    SELECT 1
    FROM golden.dim_produtos dp
    WHERE dp.codigo_produto = gp."CDPRO"
);


INSERT INTO golden.dim_tempo (data, dia, mes, ano, trimestre, nome_mes, nome_dia_semana, semana_ano)
SELECT DISTINCT 
    gnf."DTENT" AS data, 
    EXTRACT(DAY FROM gnf."DTENT") AS dia, 
    EXTRACT(MONTH FROM gnf."DTENT") AS mes, 
    EXTRACT(YEAR FROM gnf."DTENT") AS ano, 
    CEIL(EXTRACT(MONTH FROM gnf."DTENT")/3) AS trimestre, 
    TO_CHAR(gnf."DTENT", 'Month') AS nome_mes, 
    TO_CHAR(gnf."DTENT", 'Day') AS nome_dia_semana, 
    EXTRACT(WEEK FROM gnf."DTENT") AS semana_ano
FROM gold.combined_notasfiscais gnf
WHERE NOT EXISTS (
    SELECT 1
    FROM golden.dim_tempo dt
    WHERE dt.data = gnf."DTENT"
)
UNION
SELECT DISTINCT 
    gv."DTOPE" AS data, 
    EXTRACT(DAY FROM gv."DTOPE") AS dia, 
    EXTRACT(MONTH FROM gv."DTOPE") AS mes, 
    EXTRACT(YEAR FROM gv."DTOPE") AS ano, 
    CEIL(EXTRACT(MONTH FROM gv."DTOPE")/3) AS trimestre, 
    TO_CHAR(gv."DTOPE", 'Month') AS nome_mes, 
    TO_CHAR(gv."DTOPE", 'Day') AS nome_dia_semana, 
    EXTRACT(WEEK FROM gv."DTOPE") AS semana_ano
FROM gold.combined_vendas gv
WHERE NOT EXISTS (
    SELECT 1
    FROM golden.dim_tempo dt
    WHERE dt.data = gv."DTOPE"
);
