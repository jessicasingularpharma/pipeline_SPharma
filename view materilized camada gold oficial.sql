-- Criar a view materializada
CREATE MATERIALIZED VIEW gold.produtos_detalhados AS
SELECT 
    spf."FORNECID",
    forn."razao" AS "RAZAO_SOCIAL",
    forn."fanta" AS "NOME_FANTASIA",
    spf."CDPRO",
    spf."NRCNPJ",
    spf."UNIDA" AS "UNIDA_FORNECEDOR",
    spf."PRCOMN" AS "PRCOMN_FORNECEDOR",
    spf."EAN",
    spf."INDPREFERENCIAL",
    gp."DESCRPRD",
    gp."DESCRDET",
    gp."DESCR",
    gp."SITUA",
    gp."GRUPO",
    gp."SETOR",
    gp."LINHA",
    gp."CURVA",
    gp."UNIDA" AS "UNIDA_PRODUTO",
    gp."MOEDA",
    gp."PRCOM" AS "PRCOM_PRODUTO",
    gp."PRVEN",
    gp."DTREAJ",
    gp."DTCAD",
    gp."CLASSIFICACAO"
FROM 
    silver.produtosporfornecedor spf
LEFT JOIN 
    gold.produtos gp
ON 
    spf."CDPRO"::integer = gp."CDPRO"
LEFT JOIN
    gold.fornecedores forn
ON
    spf."FORNECID" = forn."fornecid";


-- Atualizar a view materializada
CREATE OR REPLACE FUNCTION refresh_produtos_detalhados()
RETURNS void AS $$
BEGIN
    REFRESH MATERIALIZED VIEW gold.produtos_detalhados;
END;
$$ LANGUAGE plpgsql;

-- Agendar atualizações automáticas (opcional)
-- Este agendamento deve ser configurado no ambiente do banco, como no pg_cron.