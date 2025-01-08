-- Adicionar chave estrangeira entre combined_notasfiscais e fornecedores
-- Primeiro, adicionar a restrição de unicidade na coluna fornecid
ALTER TABLE gold.fornecedores
ADD CONSTRAINT unique_fornecid UNIQUE (fornecid);

-- Converter a coluna FORNECID para integer
ALTER TABLE gold.combined_notasfiscais
ALTER COLUMN "FORNECID" TYPE integer USING "FORNECID"::integer;

-- Adicionar a restrição de chave estrangeira
-- Em seguida, adicionar a restrição de chave estrangeira na tabela combined_notasfiscais
ALTER TABLE gold.combined_notasfiscais
ADD CONSTRAINT fk_fornecedores
FOREIGN KEY ("FORNECID")
REFERENCES gold.fornecedores (fornecid);




-- Adicionar chave estrangeira entre combined_notasfiscais e produtos
-- Primeiro, adicionar a restrição de unicidade na coluna cdpro
ALTER TABLE gold.produtos
ADD CONSTRAINT unique_cdpro UNIQUE (cdpro);

-- Converter a coluna CDPRO para integer
ALTER TABLE gold.combined_notasfiscais
ALTER COLUMN "CDPRO" TYPE integer USING "CDPRO"::integer;

-- Adicionar a restrição de chave estrangeira
ALTER TABLE gold.combined_notasfiscais
ADD CONSTRAINT fk_produtos
FOREIGN KEY ("CDPRO")
REFERENCES gold.produtos (cdpro);





