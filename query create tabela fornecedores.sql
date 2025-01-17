CREATE TABLE IF NOT EXISTS silver.fornecedores (
    fornecedor_id SERIAL PRIMARY KEY,
    FORNECID INTEGER NOT NULL,
    RAZAO CHARACTER VARYING NOT NULL,
    NRCNPJ CHARACTER VARYING,
    FANTA CHARACTER VARYING,
    MUNIC CHARACTER VARYING,
    UNFED CHARACTER VARYING
);

-- Inserir dados na tabela de dimensão dim_fornecedores
INSERT INTO silver.fornecedores (FORNECID, RAZAO, NRCNPJ, FANTA, MUNIC, UNFED)
SELECT 
    CAST(temporary."FC02000"."FORNECID" AS INTEGER), 
    CAST(temporary."FC02000"."RAZAO" AS CHARACTER VARYING), 
    CAST(temporary."FC02000"."NRCNPJ" AS CHARACTER VARYING), 
    CAST(temporary."FC02000"."FANTA" AS CHARACTER VARYING), 
    CAST(temporary."FC02000"."MUNIC" AS CHARACTER VARYING), 
    CAST(temporary."FC02000"."UNFED" AS CHARACTER VARYING)
FROM temporary."FC02000"
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.fornecedores 
    WHERE silver.fornecedores.FORNECID = CAST(temporary."FC02000"."FORNECID" AS INTEGER)
);



