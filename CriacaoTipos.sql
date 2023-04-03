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
    cidade VARCHAR2(50),
    
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
    salario NUMBER
    
    cadastro_funcionario UNIQUE

    OVERRIDING MEMBER PROCEDURE get_pessoa_info -- dando override para imprimir o cargo, salário, além das outras informações
);
/

-- Tipo cliente
CREATE OR REPLACE TYPE tp_cliente AS OBJECT (
    cpf VARCHAR2(14),
    nome VARCHAR2(30),
    idade VARCHAR2(3),
    telefone tp_arr_telefone,
    endereco tp_endereco,
    fidelidade VARCHAR2(1),
    CONSTRUCTOR FUNCTION tp_cliente RETURN SELF AS RESULT,
    MEMBER PROCEDURE get_pessoa_info
);
/

CREATE OR REPLACE TYPE BODY tp_cliente AS
    CONSTRUCTOR FUNCTION tp_cliente RETURN SELF AS RESULT IS
    BEGIN
        RETURN;
    END;
    
    OVERRIDING MEMBER PROCEDURE get_pessoa_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
        DBMS_OUTPUT.PUT_LINE('Idade: ' || idade);
        DBMS_OUTPUT.PUT_LINE('Telefone: ');
        FOR i IN telefone.FIRST..telefone.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('     ' || telefone(i));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Endereco: ');
        DBMS_OUTPUT.PUT_LINE('     ' || endereco.rua || ', ' || endereco.numero);
        DBMS_OUTPUT.PUT_LINE('     ' || endereco.bairro || ', ' || endereco.cidade || ' - ' || endereco.estado);
        DBMS_OUTPUT.PUT_LINE('Fidelidade: ' || fidelidade);
    END;
END;
/
CREATE TYPE filme_type AS OBJECT (

    codigo NUMBER(5),
    titulo VARCHAR2(100),
    duracao NUMBER(3),
    classificacao CHAR(2),
    diretor VARCHAR2(100),
    genero VARCHAR2(50),
    sinopse VARCHAR2(1000)
);
/
CREATE TYPE sala_type AS OBJECT (

    numero NUMBER(3),
    capacidade NUMBER(3)
);
/
CREATE TYPE sessao_type AS OBJECT (

    codigo NUMBER(5),
    filme filme_type,
    sala sala_type,
    horario DATE,
    valor_ingresso NUMBER(6,2)
);
/
CREATE TYPE ingresso_type AS OBJECT (

    codigo NUMBER(5),
    sessao sessao_type,
    cliente cliente_type,
    data_compra DATE,
    valor NUMBER(6,2),
    poltrona VARCHAR2(5)
);