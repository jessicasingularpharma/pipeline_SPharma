CREATE TABLE IF NOT EXISTS pb.fato_NotaFiscal
(
    "CDFIL" VARCHAR(50),
    "FORNECID" INTEGER,
    "DTENT" DATE,
    "NRNOT" VARCHAR(50),
    "CDFNR" VARCHAR(50),
    "NRPED" VARCHAR(50),
    "VRTOT" NUMERIC(10,2),
    "VRDSC" NUMERIC(10,2),
    "ITEMID" VARCHAR(50),
    "CDPRO" INTEGER,
    "QUANT" NUMERIC(10,2),
    "PRUNI" NUMERIC(10,2),
    "PRUNIR" NUMERIC(10,2),
    "QTREAL" NUMERIC(10,2),
    "NRLOT" VARCHAR(50),
    "DTFAB" DATE,
    "DTVAL" DATE,
    "VFRETE" NUMERIC(10,2),
    CONSTRAINT fk_fornecedores FOREIGN KEY ("FORNECID")
        REFERENCES pb.dim_Fornecedor("fornecid") -- Verifique se a tabela e a coluna estão corretas
);

----------insert fato nota fiscal---------
BEGIN;

INSERT INTO pb.fato_NotaFiscal (
    "CDFIL", 
    "FORNECID", 
    "DTENT", 
    "NRNOT", 
    "CDFNR", 
    "NRPED", 
    "VRTOT", 
    "VRDSC", 
    "ITEMID", 
    "CDPRO", 
    "QUANT", 
    "PRUNI", 
    "PRUNIR", 
    "QTREAL", 
    "NRLOT", 
    "DTFAB", 
    "DTVAL", 
    "VFRETE"
)
SELECT 
    "CDFIL", 
    "FORNECID", 
    "DTENT", 
    "NRNOT", 
    "CDFNR", 
    "NRPED", 
    "VRTOT", 
    "VRDSC", 
    "ITEMID", 
    "CDPRO", 
    "QUANT", 
    "PRUNI", 
    "PRUNIR", 
    "QTREAL", 
    "NRLOT", 
    "DTFAB", 
    "DTVAL", 
    "VFRETE"
FROM 
    gold.combined_notasfiscais;

COMMIT;