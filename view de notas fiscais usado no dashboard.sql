-- View: gold.view_combined_notasfiscais_produtos

-- DROP VIEW gold.view_combined_notasfiscais_produtos;

CREATE OR REPLACE VIEW gold.view_combined_notasfiscais_produtos AS
SELECT 
    nf."CDFIL" AS "Filial_ID",
    nf."CDFNR" AS "Fornecedor_Código",
    nf."FORNECID" AS "Fornecedor_ID",
    nf."NRNOT" AS "Número_Nota",
    nf."DTENT" AS "Data_Entrada",
    nf."VRTOT" AS "Valor_Total",
    nf."VRDSC" AS "Valor_Desconto",
    nf."CDPRO" AS "Produto_Código",
    nf."QUANT" AS "Quantidade",
    nf."UNIDA" AS "Unidade",
    nf."PRUNI" AS "Preço_Unitário",
    nf."PRUNIR" AS "Preço_Unitário_Real",
    nf."QTREAL" AS "Quantidade_Real",
    p."DESCR" AS "Produto_Descrição",
    p."SITUA" AS "Produto_Situação",
    p."GRUPO" AS "Produto_Grupo",
    p."SETOR" AS "Produto_Setor",
    p."LINHA" AS "Produto_Linha",
    p."CURVA" AS "Produto_Curva",
    p."UNIDA" AS "Produto_Unidade",
    f.razao AS "Fornecedor_Razão_Social",
    f.fanta AS "Fornecedor_Nome_Fantasia",
    p."CLASSIFICACAO" AS "Classificacao_Produto"
FROM 
    gold.combined_notasfiscais nf
JOIN 
    gold.produtos p ON nf."CDPRO" = p."CDPRO"
JOIN 
    gold.fornecedores f ON nf."FORNECID" = f.fornecid;

ALTER TABLE gold.view_combined_notasfiscais_produtos
    OWNER TO postgres;


