-- Acessando Varray telefone do cliente que possui a maior fidelidade;
SELECT t.contato
FROM  tb_cliente c , TABLE (c.telefone) t 
WHERE c.cpf in (
    	SELECT cpf from tb_cliente c2 WHERE c2.fidelidade = (
    		SELECT MAX(c3.fidelidade) FROM tb_cliente c3
        )
);
/

-- Acessando Varray elenco do filme que possui a maior classificacao indicativa;
SELECT e.nome_ator AS atores_do_filme_com_maior_classificaco_indificativa 
FROM tb_filme f, TABLE(elenco) e 
WHERE f.CLASSIFICACAO_INDICATIVA IN (
    SELECT f.CLASSIFICACAO_INDICATIVA 
    FROM tb_filme f
    WHERE f.CLASSIFICACAO_INDICATIVA IN (
        SELECT MAX(f2.CLASSIFICACAO_INDICATIVA) 
        FROM tb_filme f2
));
/

-- Acessando informaçoes da compra onde o mês da compra foi Julho.
SELECT cp.id_compra, cp.data_compra, DEREF(ingresso).valor AS valor_ingresso , DEREF(cp.cliente).cpf AS cpf_cliente
FROM tb_compra cp
WHERE EXTRACT(MONTH FROM cp.data_compra) = 7;
/

-- Acessando nested table assentos da sala com id 7
SELECT a.cod_assento, a.tipo_assento
FROM tb_sala s, TABLE(s.assentos) a 
WHERE s.id_sala = 7;
/

-- Selecionando o cpf, nome  todos os funcionarios que são supervisores
SELECT 
    DEREF(supervisor).nome AS nome_supervisor,
    DEREF(supervisor).cpf AS cpf_supervisor
FROM 
    tb_supervisiona s ;
/

-- Selecionando o cpf, nome de todos funcionarios que são  supervisionados
SELECT 
    DEREF(supervisionado).nome AS nome_supervisionado,
    DEREF(supervisionado).cpf AS cpf_supervisionado
FROM 
    tb_supervisiona s ;
/

-- Acessando os nomes dos filmes que possuem do ator Tom Hanks
SELECT f.nome
FROM tb_filme f, TABLE(f.elenco) e
WHERE e.nome_ator = 'Tom Hanks';
/

-- Verificando o id da sala e a capacidade, das salas que foram limpas no dia 30
SELECT DEREF(sala).id_sala AS id_sala, DEREF(sala).capacidade as capacidade
FROM tb_limpa s
WHERE EXTRACT(DAY FROM s.data) = 30;
/

SELECT e.nome_ator
FROM tb_filme f, TABLE(f.elenco) e
WHERE f.genero = 'Drama';
/

-- Coletando os dados do ingresso mais caro, da compra e do cliente
SELECT DEREF(ingresso).cod_ingresso AS codigo_ingresso,
       DEREF(ingresso).tipo_ingresso AS tipo_ingresso,
       DEREF(ingresso).valor AS valor_ingresso,
       c.id_compra,
       c.data_compra,
       DEREF(cliente).cpf AS cpf_cliente
FROM tb_compra c
WHERE DEREF(ingresso).valor = (SELECT MAX(valor) FROM tb_ingresso);
/

-- Coletando os dados do filme, data de reserva, assento e ingresso de um filme específico usando REF
SELECT DEREF(filme).nome AS nome_filme,
       DEREF(assento).cod_assento AS cod_assento,
       DEREF(assento).tipo_assento AS tipo_assento,
       DEREF(ingresso).valor AS valor,
       DEREF(ingresso).tipo_ingresso AS tipo_ingresso,
       r.data_reserva
FROM tb_reserva r
WHERE r.filme = (
	SELECT REF(F)
    FROM tb_filme F
    WHERE F.id_filme = 1
);
/

-- Coletando dados da sala e do funcionário que fizeram a limpeza de uma sala específica usando REF
SELECT DEREF(sala).id_sala AS id_sala,
       DEREF(funcionario).cpf AS cpf_funcionario,
       DEREF(funcionario).nome AS nome_funcionario,
       l.data AS data_limpeza
FROM tb_limpa l
WHERE l.sala = (
	SELECT REF(s)
    FROM tb_sala s
    WHERE s.id_sala = 3131
);
/