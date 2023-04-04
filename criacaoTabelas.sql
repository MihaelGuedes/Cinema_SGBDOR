-- Tabela de Cargo
CREATE TABLE tb_cargo OF tp_cargo (
    tipo_cargo PRIMARY KEY,
    salario NOT NULL
);
/

-- TABELA FUNCIONARIOS --

CREATE TABLE tb_funcionario OF tp_corretor (
    cpf PRIMARY KEY,
    nome NOT NULL,
    idade NOT NULL,
    telefone NOT NULL,
    endereco NOT NULL,
    salario NOT NULL,
    cargo NOT NULL,
    cadastro_funcionario NOT NULL,
    supervisor_cpf NOT NULL,
    supervisor_cpf WITH ROWID REFERENCES tb_funcionario NOT NULL,
    CONSTRAINT funcionario_ck CHECK (cpf LIKE ('___.___.___-__')));
/

-- TABELA CLIENTE --
CREATE TABLE tb_cliente OF tp_cliente (
    cpf PRIMARY KEY,
    nome NOT NULL,
    idade NOT NULL,
    telefone NOT NULL,
    endereco NOT NULL,
    fidelidade  NOT NULL,
    CONSTRAINT cliente_ck CHECK (cpf LIKE ('___.___.___-__'))
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
    codigo_ingresso PRIMARY KEY,
    tipo_ingresso NOT NULL,
    valor NOT NULL
);
/

-- TABELA DE COMPRAS --

CREATE TABLE tb_compra OF tp_compra (
    cpf PRIMARY KEY,
    codigo_ingresso PRIMARY KEY,
    id_compra PRIMARY KEY,
    id_cupom NOT NULL,
    data_compra NOT NULL,
    cpf WITH ROWID REFERENCES tb_cliente NOT NULL,
    id_cupom WITH ROWID REFERENCES tb_cupom NOT NULL,
    codigo_ingresso WITH ROWID REFERENCES tb_ingresso NOT NULL,
    CONSTRAINT gerente_ck CHECK (cpf LIKE ('___.___.___-__'))
);
/

-- TABELA DE FILME --
CREATE TABLE tb_filme OF tp_filme(
    id_filme PRIMARY KEY,
    nome NOT NULL,
    genero NOT NULL,
    duracao NOT NULL,
    diretor NOT NULL,
    elenco NOT NULL,
    classificacao NOT NULL
);

-- TABELA DE ELENCO --
CREATE TABLE tb_elenco OF tp_elenco(
    id_filme PRIMARY KEY,
    nome_ator NOT NULL,
    id_filme WITH ROWID REFERENCES tb_filme NOT NULL,
);

-- TABELA DE SALA --
CREATE TABLE tb_sala OF tp_sala(
    id_sala PRIMARY KEY,
    capacidade NOT NULL,
);

-- TABELA DE ASSENTO --
CREATE TABLE tb_assento OF tp_assento(
    id_sala PRIMARY KEY,
    cod_assento PRIMARY KEY,
    tipo_assento NOT NULL,
    id_sala WITH ROWID REFERENCES tb_sala NOT NULL,
);

-- TABELA DE RESERVA --
CREATE TABLE tb_reserva OF tp_reserva(
    id_filme PRIMARY KEY,
    codigo_ingresso NOT NULL,
    id_sala NOT NULL,
    codigo_assento NOT NULL,
    data_reserva NOT NULL,
    id_filme WITH ROWID REFERENCES tb_filme NOT NULL,
    codigo_ingresso WITH ROWID REFERENCES tb_ingresso NOT NULL,
    id_sala WITH ROWID REFERENCES tb_sala NOT NULL,
    codigo_assento WITH ROWID REFERENCES tb_assento NOT NULL,
);

-- TABELA LIMPA --
CREATE TABLE tb_limpa OF tp_limpa(
    id_sala NOT NULL,
    data_limpeza PRIMARY KEY,
    cpf_funcionario NOT NULL,
    id_sala WITH ROWID REFERENCES tb_sala NOT NULL,
    cpf_funcionario WITH ROWID REFERENCES tb_funcionario NOT NULL,
);

