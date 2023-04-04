CREATE OR REPLACE TYPE tp_telefone AS OBJECT (

    contato VARCHAR2(50)

);
/
-- Criando array para atributo multivalorado
CREATE OR REPLACE TYPE tp_arr_telefone AS VARRAY (5) OF tp_telefon;e
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


CREATE OR REPPLACE TYPE BODY tp_funcionario  AS
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
    cpf_supervisionado REF tp_funcionario,
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
CREATE OR REPLACE TYPE tp_elenco AS OBJECT (

    id_filme UNIQUE
    nome_ator VARCHAR2(30)

);

/

-- Criando array para atributo multivalorado
CREATE OR REPLACE TYPE tp_arr_elenco AS VARRAY (5) OF tp_elenco;

/

CREATE OR REPLACE TYPE tp_filme AS OBJECT(

    id_filme UNIQUE,
    genero VARCHAR2(35),
    classificacao VARCHAR2(10),
    nome VARCHAR2(50),
    duracao VARCHAR2(5),
    diretor VARCHAR2(20),
);

/

CREATE OR REPLACE TYPE BODY tp_filme AS
    MEMBER PROCEDURE get_pessoa_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: '  nome);
        DBMS_OUTPUT.PUT_LINE('genero: '  genero);
        DBMS_OUTPUT.PUT_LINE('classificacao: '  classificacao);
        DBMS_OUTPUT.PUT_LINE('diretor: '  diretor);
        DBMS_OUTPUT.PUT_LINE('duracao: ' || duracao);
    END;
END;

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