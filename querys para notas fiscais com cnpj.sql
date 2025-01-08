SELECT 
    n.nrnot AS numero_nota_fiscal,
    n.dtent AS data_entrada,
    i.cdpro AS codigo_item,
    p.descrprd AS descricao_produto,
    i.pruni AS preco_item,
    SUM(i.quant) AS quantidade_total,
    n.vrtot AS total_comprado_nota
FROM 
    dw_compras.notas_de_entrada n
JOIN 
    dw_compras.itens_das_notas_fiscais i ON n.cdfil = i.cdfil AND n.nrnot = i.nrnot
JOIN 
    dw_compras.dim_produtos p ON CAST(i.cdpro AS INTEGER) = p.cdpro  -- Converte `i.cdpro` para INTEGER
WHERE 
    n.dtent BETWEEN '2022-01-01' AND '2024-10-31'  -- Período a ser ajustado conforme necessário
GROUP BY 
    n.nrnot, n.dtent, i.cdpro, p.descrprd, i.pruni, n.vrtot
ORDER BY 
    n.dtent, n.nrnot, i.cdpro;
