CREATE OR REPLACE VIEW pb.vw_NotaFiscal_Fornecedores AS
SELECT 
    nf."CDFIL" AS "Código da Filial",
    nf."DTENT" AS "Data de Entrada",
    nf."NRNOT" AS "Número da Nota",
    nf."CDFNR" AS "Código do Fornecedor",
    forn."razao" AS "Razão Social",
    forn."nrcnpj" AS "CNPJ",
    nf."NRPED" AS "Número do Pedido",
    nf."VRTOT" AS "Valor Total",
    nf."VRDSC" AS "Valor de Desconto",
    nf."ITEMID" AS "ID do Item",
    nf."CDPRO" AS "Código do Produto",
    nf."QUANT" AS "Quantidade",
    nf."PRUNI" AS "Preço Unitário",
    nf."PRUNIR" AS "Preço Unitário Real",
    nf."QTREAL" AS "Quantidade Real",
    nf."NRLOT" AS "Número do Lote",
    nf."DTFAB" AS "Data de Fabricação",
    nf."DTVAL" AS "Data de Validade",
    nf."VFRETE" AS "Valor do Frete"
FROM 
    pb.fato_NotaFiscal nf
LEFT JOIN 
    pb.Dim_Fornecedor forn
ON 
    nf."FORNECID" = forn."fornecid";
