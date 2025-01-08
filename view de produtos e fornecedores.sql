CREATE MATERIALIZED VIEW gold.mat_view_produtos_fornecedores AS
SELECT 
    p."CDPRO",
    p."DESCRPRD",
    p."DESCRDET",
    p."DESCR",
    p."SITUA",
    p."GRUPO",
    p."SETOR",
    p."LINHA",
    p."CURVA",
    p."UNIDA" AS "UNIDA_PROD",
    p."UNIRC",
    p."MOEDA",
    p."PRCOM",
    p."PRCOMN",
    p."PRVEN",
    p."DTREAJ",
    p."DTCAD",
    p."DTCOM",
    p."NRNOT",
    p."CDICM",
    p."CDIPI",
    p."DOMAX",
    p."UNIDM",
    p."FLAGENV",
    p."DOMINE",
    p."UNIDMINE",
    p."DOMIND",
    p."UNIDMIND",
    p."DTALT",
    p."PRVENMAX",
    p."CDSEMI",
    p."HRALT",
    p."CDPROH",
    pf."FORNECID",
    pf."NRCNPJ",
    pf."UNIDA" AS "UNIDA_FORN",
    pf."PRCOMN" AS "PRCOMN_FORN",
    pf."CDCHAVE",
    pf."INDPREFERENCIAL",
    pf."FRACI",
    pf."ITEMID",
    pf."EAN",
    pf."IIE",
    f."razao",
    f."nrcnpj" AS "NRCNPJ_FORN",
    f."fanta",
    f."munic",
    f."unfed"
FROM gold.produtos p
LEFT JOIN silver.produtosporfornecedor pf ON p."CDPRO" = CAST(pf."CDPRO" AS integer)
LEFT JOIN gold.fornecedores f ON pf."FORNECID" = f."fornecid";

-- Atualize a materialized view periodicamente
REFRESH MATERIALIZED VIEW gold.mat_view_produtos_fornecedores;




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
    f.fanta AS "Fornecedor_Nome_Fantasia"
FROM 
    gold.combined_notasfiscais nf
JOIN 
    gold.produtos p ON nf."CDPRO" = p."CDPRO"
JOIN 
    gold.fornecedores f ON nf."FORNECID" = f.fornecid;

ALTER TABLE gold.view_combined_notasfiscais_produtos
    OWNER TO postgres;
