SELECT 
    n.nrnot AS numero_nota_fiscal,
    n.dtent AS data_entrada,
    i.cdpro AS codigo_item,
    p.descrprd AS descricao_produto,
    i.pruni AS preco_item,
    SUM(i.quant) AS quantidade_total,
    n.vrtot AS total_comprado_nota,
    f.fanta AS nome_fornecedor,
    f.nrcnpj AS cnpj_fornecedor
FROM 
    dw_compras.notas_de_entrada n
JOIN 
    dw_compras.itens_das_notas_fiscais i ON n.cdfil = i.cdfil AND n.nrnot = i.nrnot
JOIN 
    dw_compras.dim_produtos p ON CAST(i.cdpro AS INTEGER) = p.cdpro
JOIN
    dw_compras.dim_fornecedores f ON n.fornecid = f.fornecid
WHERE 
    n.dtent BETWEEN '2022-01-01' AND '2024-10-01'  -- Período a ser ajustado conforme necessário
GROUP BY 
    n.nrnot, n.dtent, i.cdpro, p.descrprd, i.pruni, n.vrtot, f.fanta, f.nrcnpj
ORDER BY 
    n.dtent, n.nrnot, i.cdpro;





SELECT 
    n.nrnot AS numero_nota_fiscal,
    n.dtent AS data_entrada,
    i.cdpro AS codigo_item,
    p.descrprd AS descricao_produto,
    i.pruni AS preco_item,
    i.quant AS quantidade_item,  -- Quantidade de cada item
    n.vrtot AS total_comprado_nota,
    f.fanta AS nome_fornecedor,
    f.nrcnpj AS cnpj_fornecedor
FROM 
    dw_compras.notas_de_entrada n
JOIN 
    dw_compras.itens_das_notas_fiscais i ON n.cdfil = i.cdfil AND n.nrnot = i.nrnot
JOIN 
    dw_compras.dim_produtos p ON CAST(i.cdpro AS INTEGER) = p.cdpro
JOIN
    dw_compras.dim_fornecedores f ON n.fornecid = f.fornecid
WHERE 
    n.dtent BETWEEN '2022-01-01' AND '2024-10-01'  -- Período a ser ajustado conforme necessário
ORDER BY 
    n.dtent, n.nrnot, i.cdpro;



SELECT 
    n.nrnot AS numero_nota_fiscal,
    n.dtent AS data_entrada,
    i.cdpro AS codigo_item,
    p.descrprd AS descricao_produto,
    i.pruni AS preco_unitario_item,
    i.quant AS quantidade_item,
    (i.pruni * i.quant) AS valor_total_item, -- Calcula o valor total por item
    n.vrtot AS total_comprado_nota,
    f.fanta AS nome_fornecedor,
    f.nrcnpj AS cnpj_fornecedor
FROM 
    dw_compras.notas_de_entrada n
JOIN 
    dw_compras.itens_das_notas_fiscais i ON n.cdfil = i.cdfil AND n.nrnot = i.nrnot
JOIN 
    dw_compras.dim_produtos p ON CAST(i.cdpro AS INTEGER) = p.cdpro
JOIN
    dw_compras.dim_fornecedores f ON n.fornecid = f.fornecid
WHERE 
    n.dtent BETWEEN '2022-01-01' AND '2024-10-31'  -- Período a ser ajustado conforme necessário
ORDER BY 
    n.dtent, n.nrnot, i.cdpro;



