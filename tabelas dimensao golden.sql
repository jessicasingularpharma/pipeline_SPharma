CREATE TABLE golden.dim_filiais (
    id_filial SERIAL PRIMARY KEY,
    codigo_filial VARCHAR(50) NOT NULL,
    nome_filial VARCHAR(255)
);


CREATE TABLE golden.dim_clientes (
    id_cliente SERIAL PRIMARY KEY,
    id_filial INT REFERENCES golden.dim_filiais(id_filial),
    codigo_cliente VARCHAR(50) NOT NULL,
    nome_cliente VARCHAR(255),
    sexo CHAR(1),
    data_cadastro DATE
);


CREATE TABLE golden.dim_produtos (
    id_produto SERIAL PRIMARY KEY,
    id_filial INT REFERENCES golden.dim_filiais(id_filial),
    codigo_produto INTEGER NOT NULL,
    descricao_produto TEXT,
    grupo VARCHAR(50),
    setor VARCHAR(50),
    linha VARCHAR(50),
    curva CHAR(1),
    unidade VARCHAR(10),
    preco_compra NUMERIC(18,2),
    preco_venda NUMERIC(18,2),
    data_cadastro DATE,
    situacao VARCHAR(20)
);

CREATE TABLE golden.dim_fornecedores (
    id_fornecedor SERIAL PRIMARY KEY,
    codigo_fornecedor INTEGER NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    cnpj VARCHAR(20),
    fantasia VARCHAR(255),
    municipio VARCHAR(255),
    uf VARCHAR(2)
);



CREATE TABLE golden.dim_tempo (
    data DATE PRIMARY KEY,
    dia INT,
    mes INT,
    ano INT,
    trimestre INT,
    nome_mes VARCHAR(20),
    nome_dia_semana VARCHAR(20),
    semana_ano INT
);
