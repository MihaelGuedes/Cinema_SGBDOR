-- Acessando Varray telefone do cliente que possui a maior fidelidade;
SELECT t.contato
FROM  tb_cliente c , TABLE (c.telefone) t 
WHERE c.cpf in (
    	SELECT cpf from tb_cliente c2 WHERE c2.fidelidade = (
    		SELECT MAX(c3.fidelidade) FROM tb_cliente c3
        )
);
/
