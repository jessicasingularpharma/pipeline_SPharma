SELECT 
    cnf."CDFIL",
    cnf."DTENT",
    cnf."NRNOT",
    cnf."CDFNR",
    cnf."VRTOT",
    cnf."CDPRO",
    cnf."QUANT",
    cnf."UNIDA",
    cnf."PRUNIR",
    cnf."XPROD",
    f."fanta" AS "Nome_Fantasia_Fornecedor"
FROM 
    gold.combined_notasfiscais cnf
INNER JOIN 
    gold.produtos p ON cnf."CDPRO" = p."CDPRO"
INNER JOIN 
    gold.fornecedores f ON cnf."FORNECID" = f."fornecid"
WHERE 
    p."CLASSIFICACAO" = 'BLEND'
    AND EXTRACT(YEAR FROM cnf."DTENT") IN (2021, 2022, 2023, 2024);
