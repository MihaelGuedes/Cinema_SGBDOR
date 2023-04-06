-- TABELA CLIENTE --
CREATE TABLE tb_cliente OF tp_cliente (
    cpf PRIMARY KEY,
    nome NOT NULL,
    telefone NOT NULL,
    idade NOT NULL,
    endereco NOT NULL,
    fidelidade NOT NULL,
    CONSTRAINT cliente_ck CHECK (cpf LIKE ('___.___.___-__'))
);
/

-- TABELA FUNCIONARIO --
CREATE TABLE tb_funcionario OF tp_funcionario (
    cpf PRIMARY KEY,
    nome NOT NULL,
    telefone NOT NULL,
    idade NOT NULL,
    endereco NOT NULL,
    cargo NOT NULL,
    salario NOT NULL, 
    cadastro_funcionario NOT NULL UNIQUE,
    CONSTRAINT funcionario_ck CHECK (cpf LIKE ('___.___.___-__'))
);
/

-- Tabela de supervisão
CREATE TABLE tb_supervisiona OF tp_supervisiona (
    supervisor WITH ROWID REFERENCES tb_funcionario NOT NULL,
    supervisionado WITH ROWID REFERENCES tb_funcionario NOT NULL
);
/

-- Tabela de cupom
CREATE TABLE tb_cupom OF tp_cupom (
    id_cupom PRIMARY KEY,
    desconto NOT NULL
);
/

-- Tabela de ingresso
CREATE TABLE tb_ingresso OF tp_ingresso (
    cod_ingresso PRIMARY KEY,
    tipo_ingresso NOT NULL,
    valor NOT NULL
);
/

-- TABELA DE COMPRAS --
CREATE TABLE tb_compra OF tp_compra (
    id_compra PRIMARY KEY,
    data_compra NOT NULL,
    ingresso SCOPE IS tb_ingresso NOT NULL,
    cliente SCOPE IS tb_cliente NOT NULL,
    cupom SCOPE IS tb_cupom NOT NULL
);
/

-- TABELA DE FILME --
CREATE TABLE tb_filme OF tp_filme(
    id_filme PRIMARY KEY,
    genero NOT NULL,
    classificacao_indicativa NOT NULL,
    nome NOT NULL,
    elenco NOT NULL,
    duracao NOT NULL,
    diretor NOT NULL
);
/

-- TABELA DE ASSENTO --
CREATE TABLE tb_assento OF tp_assento(
    cod_assento PRIMARY KEY,
    tipo_assento NOT NULL
);
/

-- TABELA DE SALA --
CREATE TABLE tb_sala OF tp_sala(
    id_sala PRIMARY KEY,
    capacidade NOT NULL
) NESTED TABLE assentos STORE AS assentos_da_sala;
/

-- TABELA DE RESERVA --
CREATE TABLE tb_reserva OF tp_reserva(
    data_reserva NOT NULL,
    filme WITH ROWID REFERENCES tb_filme NOT NULL,
    ingresso WITH ROWID REFERENCES tb_ingresso NOT NULL,
    assento WITH ROWID REFERENCES tb_assento NOT NULL
);
/

-- TABELA LIMPA --
CREATE TABLE tb_limpa OF tp_limpa(
    data PRIMARY KEY,
    sala WITH ROWID REFERENCES tb_sala NOT NULL,
    funcionario WITH ROWID REFERENCES tb_funcionario NOT NULL
);
