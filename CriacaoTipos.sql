CREATE SEQUENCE id_compra INCREMENT by 1 START WITH 1;

CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
    contato VARCHAR2(50)
);
/
-- Criando array para atributo multivalorado
CREATE OR REPLACE TYPE tp_arr_telefone AS VARRAY (5) OF tp_telefone;
/
-- Tipo que armazena endereços 
CREATE OR REPLACE TYPE tp_endereco AS OBJECT(

    rua VARCHAR2(50),
    numero NUMBER,
    cep VARCHAR2(9),
    cidade VARCHAR2(50)
    
);
/
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    
    cpf VARCHAR2(14),
    nome VARCHAR2(30),
    telefone tp_arr_telefone,
    endereco tp_endereco,
    idade NUMBER

) NOT FINAL NOT INSTANTIABLE;
/
CREATE OR REPLACE TYPE BODY tp_pessoa AS
    MEMBER PROCEDURE get_pessoa_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
    END;
    FINAL MEMBER PROCEDURE display_address IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('O seu nome é ' || nome);
        DBMS_OUTPUT.PUT_LINE('Ele(a) mora em ' || endereco.cidade || ', ');
        DBMS_OUTPUT.PUT_LINE(endereco.cep);
    END;
END;
/
CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa(
    cargo VARCHAR2(30),
    salario NUMBER,
    cadastro_funcionario UNIQUE,
    OVERRIDING MEMBER PROCEDURE get_pessoa_info -- dando override para imprimir o cargo, salário, além das outras informações
);

/

CREATE OR REPLACE TYPE BODY tp_funcionario AS
    OVERRIDING MEMBER PROCEDURE get_pessoa_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
        DBMS_OUTPUT.PUT_LINE('cargo: ' || cargo);
        DBMS_OUTPUT.PUT_LINE('salario: ' || salario);
        DBMS_OUTPUT.PUT_LINE('cadastro_funcionario: ' || cadastro_funcionario);
    END;
END;

/
CREATE OR REPLACE TYPE tp_cliente UNDER tp_pessoa(
    fidelidade NUMBER,
     MEMBER PROCEDURE get_fidelidade_cliente -- dando override para imprimir o cargo, salário, além das outras informações
);
/

CREATE OR REPLACE TYPE BODY tp_cliente AS 
MEMBER PROCEDURE get_fidelidade_cliente  IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(fidelidade);
    END;
END;
/


CREATE OR REPLACE TYPE BODY tp_funcionario  AS
   OVERRIDING MEMBER PROCEDURE get_pessoa_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
        DBMS_OUTPUT.PUT_LINE('Salario: ' || salario);
        DBMS_OUTPUT.PUT_LINE('Cargo: ' || cargo);
        DBMS_OUTPUT.PUT_LINE('Cadastro Funcionario: ' || cadastro_funcionario);
    END;

END;

/
CREATE OR REPLACE TYPE tp_supervisiona AS OBJECT (
    cpf_supervisiona REF tp_funcionario,
    cpf_supervisionado REF tp_funcionario
);

/

CREATE OR REPLACE TYPE tp_cliente UNDER tp_pessoa(
     fidelidade NUMBER
    OVERRIDING MEMBER PROCEDURE get_pessoa_info
);

/

CREATE OR REPLACE TYPE BODY tp_cliente AS
    OVERRIDING MEMBER PROCEDURE get_pessoa_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
        DBMS_OUTPUT.PUT_LINE('fidelidade: ' || fidelidade);
       
    END;
END;
/


CREATE OR REPLACE TYPE tp_elenco AS OBJECT (
    nome_ator VARCHAR2(30)
);
/
-- Criando array para atributo multivalorado
CREATE OR REPLACE TYPE tp_arr_elenco AS VARRAY (50) OF tp_elenco;
/

CREATE OR REPLACE TYPE tp_filme AS OBJECT(
    id_filme NUMBER,
    genero VARCHAR2(35),
    classificacao_indicativa NUMBER,
    nome VARCHAR2(50),
    elenco tp_arr_elenco,
    duracao VARCHAR2(5),
    diretor VARCHAR2(20)
);
/

CREATE OR REPLACE TYPE BODY tp_filme AS
    MEMBER PROCEDURE get_filme_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('genero: ' || genero);
        DBMS_OUTPUT.PUT_LINE('classificacao_indicativa: ' || classificacao_indicativa);
        DBMS_OUTPUT.PUT_LINE('diretor: ' || diretor);
        DBMS_OUTPUT.PUT_LINE('duracao: ' || duracao);
    END;
END;

/

CREATE OR REPLACE TYPE tp_sala  AS OBJECT (
    id_sala NUMBER,
    numero NUMBER(3),
    capacidade NUMBER(3)
);

/

CREATE OR REPLACE TYPE tp_sessao AS OBJECT (
    codigo NUMBER(5),
    filme filme_type,
    sala tp_sala,
    horario DATE,
    valor_ingresso NUMBER(6,2)
);

/
CREATE OR REPLACE tp_assento AS OBJECT (
    cod_assento NUMBER,
    tipo VARCHAR2(10)
);
/

CREATE OR REPLACE TYPE tp_nt_assentos AS TABLE OF tp_assento;
/ 


CREATE OR REPLACE TYPE tp_sala AS OBJECT (
    id_sala NUMBER,
    capacidade NUMBER,
    assentos tp_nt_assentos
);
/


CREATE OR REPLACE TYPE tp_ingresso AS OBJECT (
    cod_ingresso INTEGER,
    tipo_ingresso VARCHAR2(2),
    valor NUMBER
);
/

CREATE OR REPLACE TYPE tp_reserva AS OBJECT (
    data_reserva DATE,
    filme REF tp_filme,
    ingresso REF tp_ingresso,
    assento REF tp_assento
);
/

CREATE OR REPLACE TYPE tp_limpa AS OBJECT (
    data DATE
    sala REF tp_sala UNIQUE ,
    funcionario REF tp_funcionario UNIQUE
);
/

CREATE OR REPLACE TYPE tp_cupom AS OBJECT (
    id NUMBER,
    desconto NUMBER
);
/
CREATE OR REPLACE TYPE tp_compra AS OBJECT (
    id_compra NUMBER,
    data_compra DATE,
    ingresso REF tp_ingresso,
    cpf_cliente VARCHAR2(14),
    id_cupom NUMBER

);
/
