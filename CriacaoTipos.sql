CREATE OR REPLACE TYPE tp_telefone AS OBJECT (

    numero VARCHAR2 (14)

);
/
-- Criando array para atributo multivalorado
CREATE OR REPLACE TYPE tp_arr_telefone AS VARRAY (5) OF tp_telefone;
/
-- Tipo que armazena endereços 
CREATE OR REPLACE TYPE tp_endereco AS OBJECT(

    cep VARCHAR2(9),
    numero NUMBER,
    rua VARCHAR2(50),
    bairro VARCHAR2(50),
    cidade VARCHAR2(50),
    estado VARCHAR2(50)
    
);
/

-- tem a tabela pessoa mas embaixo eu declaro cliente e funcionário, então não sei se ela vai realmente ser nescessária
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    
    cpf VARCHAR2(14),
    nome VARCHAR2(30),
    telefone tp_arr_telefone,
    endereco tp_endereco,

) NOT FINAL NOT INSTANTIABLE;

--- "NOT FINAL" indica que a classe não é final, ou seja, ela pode ser estendida por outras classes. Se a classe for definida como "FINAL", ela não pode ser estendida.
-- "NOT INSTANTIABLE" indica que a classe não pode ser instanciada. Isso significa que você não pode criar objetos diretamente daquela classe. Geralmente, essa opção é usada quando você deseja criar uma classe apenas para definir atributos e métodos que serão compartilhados por outras classes. Nesse caso, as outras classes que estendem a classe não instanciável podem criar objetos e herdar seus métodos e atributos.


-- adicionar esses detalhes de endereço, acho que fica melhor com esse detalhamento
/
CREATE OR REPLACE TYPE BODY tp_pessoa AS
    MEMBER PROCEDURE display_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
    END;
    FINAL MEMBER PROCEDURE display_address IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('O seu nome é ' || nome);
        DBMS_OUTPUT.PUT_LINE('Ele(a) mora em ' || endereco.cidade || ', ' || endereco.estado);
        DBMS_OUTPUT.PUT_LINE(endereco.cep);
    END;
END;
/
-- Tipo funcionario
CREATE OR REPLACE TYPE tb_funcionario AS OBJECT(

    cpf VARCHAR2(14),
    nome VARCHAR2(30),
    idade NUMBER,
    telefone tp_arr_telefone,
    endereco tp_endereco,
    salario NUMBER,
    cargo VARCHAR2(30),
    cadastro_funcionario DATE,
    supervisor_cpf VARCHAR2(14),
    MEMBER FUNCTION get_nome_supervisor RETURN VARCHAR2,
    MEMBER FUNCTION get_telefone_supervisor RETURN tp_arr_telefone,
    MEMBER PROCEDURE set_supervisor_cpf (p_supervisor_cpf VARCHAR2)
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
    MEMBER PROCEDURE display_info
);
/

CREATE OR REPLACE TYPE BODY tp_cliente AS
    CONSTRUCTOR FUNCTION tp_cliente RETURN SELF AS RESULT IS
    BEGIN
        RETURN;
    END;
    
    OVERRIDING MEMBER PROCEDURE display_info IS
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