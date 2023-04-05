INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '132.462.635-17',
        'Jabulani',
        tp_arr_telefone(tp_telefone('(81)98279-7555')),
        18,
        tp_endereco('Rua joaquim', 42, '50670-490','Olinda'),
        1
    )
);
/

INSERT INTO tb_funcionario VALUES (
    tp_funcionario(
        '132.462.635-97',
        'Jabulani',
        tp_arr_telefone(tp_telefone('(81)98279-7555')),
        18,
        tp_endereco('Rua joaquim', 42, '50670-490','Olinda'),
        'gerente',
        '1900',
        1
    )
);
/

INSERT INTO tb_funcionario VALUES (
    tp_funcionario(
        '232.462.625-97',
        'Jabulani',
        tp_arr_telefone(tp_telefone('(81)98279-7555')),
        18,
        tp_endereco('Rua joaquim', 42, '50670-490','Olinda'),
        'lanterninha',
        '1000',
        2
    )
);

/

INSERT INTO tb_supervisiona VALUES (
    tp_supervisiona(
        (SELECT REF(C) FROM tb_funcionario C WHERE C.cpf = '132.462.635-97'),
       (SELECT REF(C) FROM tb_funcionario C WHERE C.cpf = '232.462.625-97')
    )
);

/

INSERT INTO tb_cupom VALUES (
  tp_cupom(
      1,
      30
  )
);
/
INSERT INTO tb_ingresso VALUES (
  tp_ingresso(
      '1234',
      'M',
      15
  )
);
/
INSERT INTO tb_compra VALUES (
  tp_compra(
    id_compra.NEXTVAL,
  (TO_DATE('2022-07-30 13:11', 'yyyy-mm-dd hh24:mi')),
    (SELECT REF(I) FROM tb_ingresso I WHERE I.COD_INGRESSO = 1234),
    (SELECT REF(C) FROM tb_cliente C WHERE C.CPF = '132.462.635-97'),
    (SELECT REF(CP) FROM tb_cupom CP WHERE CP.id_cupom = 1)
)
    );
/


INSERT INTO tb_filme VALUES (
    tp_filme(
      1,
      'Terror',
      15,
      'Jogos Mortais',
      tp_arr_elenco(tp_elenco('Matheus Aragão')),
      '02:45',
      'Mihael Guedes'
    )
);
/
INSERT INTO tb_sala VALUES (
    tp_sala(
      1,
      5,
      tp_nt_assentos(
        tp_assento(
          1,
          'Normal'
        ),
        tp_assento(
          2,
          'Normal'
        )
        tp_assento(
          3,
          'Normal'
        )
        tp_assento(
          4,
          'Normal'
        )
        tp_assento(
          5,
          'Normal'
        )
      )
    )
);

/
INSERT INTO tb_reserva VALUES (
  tp_reserva(
  (TO_DATE('2022-07-30 13:11', 'yyyy-mm-dd hh24:mi')),
  (SELECT REF(F) FROM tb_filme F WHERE F.id_filme = 1),
	(SELECT REF(I) FROM tb_ingresso I WHERE I.COD_INGRESSO = 1234),
	(SELECT REF(A) FROM tb_assento A WHERE A.cod_assento = 1)
    )
);
/
INSERT INTO tb_limpa VALUES (
    (TO_DATE('2022-07-30 13:11', 'yyyy-mm-dd hh24:mi')),
    (SELECT REF(S) FROM tb_sala S WHERE S.id_sala = 1),
    (SELECT REF(C) FROM tb_funcionario C WHERE C.cpf = '132.462.635-97')
);
-- ACIMA ESTÁ CORRETO