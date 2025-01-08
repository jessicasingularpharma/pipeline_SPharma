CREATE TABLE golden.fact_vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES golden.dim_clientes(id_cliente),
    id_filial INT REFERENCES golden.dim_filiais(id_filial),
    id_produto INT REFERENCES golden.dim_produtos(id_produto),
    id_tempo DATE REFERENCES golden.dim_tempo(data),
    quantidade NUMERIC(10,2),
    valor_total NUMERIC(10,2),
    desconto NUMERIC(10,2),
    valor_liquido NUMERIC(10,2),
    forma_pagamento VARCHAR(50),
    canal_venda VARCHAR(50)
);


CREATE TABLE golden.fact_compras (
    id_compra SERIAL PRIMARY KEY,
    id_fornecedor INT REFERENCES golden.dim_fornecedores(id_fornecedor),
    id_filial INT REFERENCES golden.dim_filiais(id_filial),
    id_produto INT REFERENCES golden.dim_produtos(id_produto),
    id_tempo DATE REFERENCES golden.dim_tempo(data),
    quantidade NUMERIC(10,2),
    valor_total NUMERIC(10,2),
    desconto NUMERIC(10,2),
    frete NUMERIC(10,2),
    imposto NUMERIC(10,2),
    valor_liquido NUMERIC(10,2)
);
