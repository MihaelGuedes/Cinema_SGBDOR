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
