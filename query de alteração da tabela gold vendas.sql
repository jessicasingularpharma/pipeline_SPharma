SELECT * FROM gold.combined_vendas
LIMIT 100

ALTER TABLE gold.combined_vendas
ADD CONSTRAINT pk_combined_vendas PRIMARY KEY ("OPERID", "ITEMID");

CREATE INDEX idx_combined_vendas_cdcli ON gold.combined_vendas ("CDCLI");
CREATE INDEX idx_combined_vendas_cdpro ON gold.combined_vendas ("CDPRO");
