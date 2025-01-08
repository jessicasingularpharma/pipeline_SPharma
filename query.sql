SELECT 
    p.CDPRO AS codigo_do_produto, 
    p.DESCRPRD AS descricao_do_produto,
    f.RAZAO AS nome_do_fornecedor,
    f.NRCNPJ AS cnpj_do_fornecedor
FROM 
    dw_compras.dim_produtos p
LEFT JOIN 
    dw_compras.dim_produtos_por_fornecedor pf ON p.cdpro = pf.CDPRO
LEFT JOIN 
    dw_compras.dim_fornecedores f ON pf.NRCNPJ = f.NRCNPJ
WHERE 
    p.SITUA = 'A'
ORDER BY 
    p.CDPRO;


SELECT 
    p.cdpro AS codigo_do_produto,
    p.descrprd AS descricao_do_produto,
    STRING_AGG(f.razao, ', ') AS fornecedores,
    STRING_AGG(f.nrcnpj, ', ') AS cnpjs_dos_fornecedores
FROM 
    dw_compras.dim_produtos p
LEFT JOIN 
    dw_compras.dim_produtos_por_fornecedor pf ON p.cdpro = pf.cdpro
LEFT JOIN 
    dw_compras.dim_fornecedores f ON pf.fornecedor_id = f.fornecedor_id
WHERE 
    p.situa = 'A'
GROUP BY 
    p.cdpro, p.descrprd
ORDER BY 
    p.cdpro;

SELECT 
    p.cdpro AS codigo_do_produto,
    p.descrprd AS descricao_do_produto,
    STRING_AGG(f.razao, ', ') AS fornecedores,
    STRING_AGG(f.nrcnpj, ', ') AS cnpjs_dos_fornecedores
FROM 
    dw_compras.dim_produtos p
LEFT JOIN 
    dw_compras.dim_produtos_por_fornecedor pf ON p.cdpro = pf.cdpro
LEFT JOIN 
    dw_compras.dim_fornecedores f ON pf.fornecedor_id = f.fornecedor_id
WHERE 
    p.situa = 'A'
GROUP BY 
    p.cdpro, p.descrprd
ORDER BY 
    p.cdpro;


select * from dw_compras.dim_produtos


CREATE TABLE IF NOT EXISTS dw_compras.dim_produtos
(
    cdpro integer NOT NULL,
    descrprd character varying COLLATE pg_catalog."default",
    descr character varying COLLATE pg_catalog."default",
    grupo character varying COLLATE pg_catalog."default",
    setor character varying COLLATE pg_catalog."default",
    unida character varying COLLATE pg_catalog."default",
    situa character varying COLLATE pg_catalog."default",
    indcip character varying COLLATE pg_catalog."default",
    curva character varying COLLATE pg_catalog."default",
    linha character varying COLLATE pg_catalog."default",
    fornecedor_id integer,
    CONSTRAINT dim_produtos_pkey PRIMARY KEY (cdpro),
    CONSTRAINT dim_produtos_fornecedor_id_fkey FOREIGN KEY (fornecedor_id)
        REFERENCES dw_compras.dim_fornecedores (fornecedor_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO dw_compras.dim_produtos (CDPRO, DESCRPRD, DESCR, GRUPO, SETOR, UNIDA)
SELECT 
    CAST(temporary."FC03000"."CDPRO" AS INTEGER),          
    CAST(temporary."FC03000"."DESCRPRD" AS CHARACTER VARYING(20)), 
    CAST(temporary."FC03000"."DESCR" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."GRUPO" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."SETOR" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."UNIDA" AS CHARACTER VARYING)
FROM temporary."FC03000";


----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dw_compras.dim_produtos_por_filial
(
    cdpro integer NOT NULL,
    descrprd character varying(20) COLLATE pg_catalog."default",
    descr character varying COLLATE pg_catalog."default",
    grupo character varying COLLATE pg_catalog."default",
    setor character varying COLLATE pg_catalog."default",
    unida character varying COLLATE pg_catalog."default",
    CONSTRAINT dim_produtos_por_filial_pkey PRIMARY KEY (cdpro),
    CONSTRAINT dim_produtos_por_filial_cdpro_fkey FOREIGN KEY (cdpro)
        REFERENCES dw_compras.dim_produtos (cdpro) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO dw_compras.dim_produtos_por_filial (CDPRO, DESCRPRD, DESCR, GRUPO, SETOR, UNIDA)
SELECT 
    CAST(temporary."FC03000"."CDPRO" AS INTEGER),          
    CAST(temporary."FC03000"."DESCRPRD" AS CHARACTER VARYING(20)), 
    CAST(temporary."FC03000"."DESCR" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."GRUPO" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."SETOR" AS CHARACTER VARYING),
    CAST(temporary."FC03000"."UNIDA" AS CHARACTER VARYING)
FROM temporary."FC03000";

-- Cria a sequência manualmente para a coluna movimentacao_id
CREATE SEQUENCE IF NOT EXISTS dw_compras.fato_produtos_por_filial_movimentacao_id_seq;

-- Cria a tabela fato_produtos_por_filial, associando movimentacao_id à sequência criada
CREATE TABLE IF NOT EXISTS dw_compras.fato_produtos_por_filial
(
    movimentacao_id integer NOT NULL DEFAULT nextval('dw_compras.fato_produtos_por_filial_movimentacao_id_seq'),
    cdfil integer,
    cdpro integer,
    dtmov date,
    flagestmin character(1) COLLATE pg_catalog."default",
    indestmin character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'S'::bpchar,
    estmi numeric,
    estma numeric,
    estat numeric,
    prcomctb numeric(15,5),
    prcomtrf numeric(15,5),
    CONSTRAINT fato_produtos_por_filial_pkey PRIMARY KEY (movimentacao_id),
    CONSTRAINT fato_produtos_por_filial_cdpro_fkey FOREIGN KEY (cdpro)
        REFERENCES dw_compras.dim_produtos (cdpro) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_produtos_por_filial_cdfil_fkey FOREIGN KEY (cdfil)
        REFERENCES dw_compras.dim_filiais (cdfil) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


	select * from temporary."FC03100"
SELECT * FROM dw_compras.dim_produtos_por_filial;


SELECT
    f.descrfil AS nome_da_filial,
    p.descrprd AS nome_do_produto,
    fp.estat AS estoque_atual,
    fp.dtmov AS data_movimentacao
FROM
    dw_compras.fato_produtos_por_filial fp
JOIN
    dw_compras.dim_produtos p ON fp.cdpro = p.cdpro
JOIN
    dw_compras.dim_filiais f ON fp.cdfil = f.cdfil
WHERE
    fp.dtmov BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY
    f.descrfil, p.descrprd, fp.dtmov;


SELECT
    f.descrfil AS nome_da_filial,
    p.descrprd AS nome_do_produto,
    fp.estat AS estoque_atual,
    fp.dtmov AS data_movimentacao
FROM
    dw_compras.fato_produtos_por_filial fp
JOIN
    dw_compras.dim_produtos p ON fp.cdpro = p.cdpro
JOIN
    dw_compras.dim_filiais f ON fp.cdfil = f.cdfil
ORDER BY
    f.descrfil, p.descrprd, fp.dtmov;

SELECT * FROM dw_compras.fato_produtos_por_filial LIMIT 10;
SELECT * FROM dw_compras.fato_produtos_por_filial
WHERE dtmov BETWEEN '2023-01-01' AND '2023-12-31'
LIMIT 10;



select * from dw_compras.fato_produtos_por_filial;--sem dados---
SELECT * FROM dw_compras.dim_produtos;---ok---tem problemas na coluna situa,curva e linha---
select * from dw_compras.fato_movimentacao_produtos;--ok--
















SELECT fornecid, nrnot, COUNT(*)
FROM dw_compras.notas_de_entrada
GROUP BY fornecid, nrnot
HAVING COUNT(*) > 1;

























