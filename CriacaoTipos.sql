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
    idade NUMBER,
    endereco tp_endereco,
    MEMBER PROCEDURE get_pessoa_info,
    FINAL MEMBER PROCEDURE get_pessoa_endereco
) NOT FINAL NOT INSTANTIABLE;
/
    
CREATE OR REPLACE TYPE BODY tp_pessoa AS
    MEMBER PROCEDURE get_pessoa_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
    END;
    FINAL MEMBER PROCEDURE get_pessoa_endereco IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('O seu nome é ' || nome);
        DBMS_OUTPUT.PUT_LINE('Ele(a) mora em ' || endereco.cidade );
        DBMS_OUTPUT.PUT_LINE(endereco.cep);
    END;
END;
/

CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa(
    cargo VARCHAR2(30),
    salario NUMBER,
    cadastro_funcionario INTEGER,
    OVERRIDING MEMBER PROCEDURE get_pessoa_info
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
    supervisor REF tp_funcionario,
    supervisionado REF tp_funcionario
);

/

CREATE OR REPLACE TYPE tp_cliente UNDER tp_pessoa(
    fidelidade NUMBER,
    OVERRIDING MEMBER PROCEDURE get_pessoa_info,
    MEMBER PROCEDURE get_fidelidade_cliente
);
/

CREATE OR REPLACE TYPE BODY tp_cliente AS
    OVERRIDING MEMBER PROCEDURE get_pessoa_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
        DBMS_OUTPUT.PUT_LINE('fidelidade: ' || fidelidade);
       
    END;
    MEMBER PROCEDURE get_fidelidade_cliente  IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(fidelidade);
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
    diretor VARCHAR2(20),
    CONSTRUCTOR FUNCTION tp_filme (f1 tp_filme) RETURN SELF AS RESULT,
    MAP MEMBER FUNCTION num_elenco RETURN NUMBER,
    MEMBER PROCEDURE get_filme_info
);
/

CREATE OR REPLACE TYPE BODY tp_filme AS
    CONSTRUCTOR FUNCTION tp_filme (f1 tp_filme) RETURN SELF AS RESULT IS
        BEGIN
            id_filme := f1.id_filme; 
            genero := f1.genero; 
            classificacao_indicativa := f1.classificacao_indicativa; 
            nome := f1.nome;
            elenco := f1.elenco; 
            duracao := f1.duracao; 
            diretor := f1.diretor; 
            RETURN; 
        END;

    MAP MEMBER FUNCTION num_elenco RETURN NUMBER IS 
         num_count NUMBER;
    BEGIN
         SELECT COUNT (*) INTO num_count FROM TABLE (self.elenco);
         RETURN num_count;
    END;

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

CREATE OR REPLACE TYPE tp_assento AS OBJECT (
    cod_assento NUMBER,
    tipo_assento VARCHAR2(10)
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
    data DATE,
    sala REF tp_sala,
    funcionario REF tp_funcionario
);
/

CREATE OR REPLACE TYPE tp_cupom AS OBJECT (
    id_cupom NUMBER,
    desconto NUMBER,
    ORDER MEMBER FUNCTION comparar_desconto(cupom tp_cupom) RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY tp_cupom AS 
    ORDER MEMBER FUNCTION comparar_desconto (cupom tp_cupom) RETURN NUMBER IS
    BEGIN 
        return cupom.desconto - SELF.desconto;
    END;
END;
/

CREATE OR REPLACE TYPE tp_compra AS OBJECT (
    id_compra NUMBER,
    data_compra DATE,
    ingresso REF tp_ingresso,
    cliente REF tp_cliente,
    MEMBER FUNCTION get_ingresso_com_desconto RETURN NUMBER

);
/

ALTER TYPE tp_compra ADD attribute (cupom REF tp_cupom);
/

CREATE OR REPLACE TYPE BODY tp_compra AS
    MEMBER FUNCTION get_ingresso_com_desconto RETURN NUMBER IS
    desconto NUMBER;
    valor_final NUMBER;
    valor NUMBER;

    BEGIN
        SELECT DEREF(cupom).desconto, DEREF(ingresso).valor INTO desconto, valor from tb_compra WHERE id_compra = self.id_compra;
        valor_final := valor * (1 - desconto);
        RETURN valor_final;
    END;
END;
/
