
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
INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '987.654.321-00',
        'John Doe',
        tp_arr_telefone(tp_telefone('(11)12345-6789')),
        25,
        tp_endereco('Av. Paulista', 123, '01311-000', 'São Paulo'),
        2
    )
);
/
INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '111.222.333-44',
        'Jane Smith',
        tp_arr_telefone(tp_telefone('(21)98765-4321')),
        32,
        tp_endereco('Rua da Praia', 567, '22000-000', 'Rio de Janeiro'),
        12312
    )
);
/

INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '555.666.777-88',
        'Michael Johnson',
        tp_arr_telefone(tp_telefone('(31)55555-4444')),
        40,
        tp_endereco('Avenida Central', 789, '30100-111', 'Belo Horizonte'),
        1312323
    )
);
/
INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '444.555.666-77',
        'Maria Santos',
        tp_arr_telefone(tp_telefone('(61)44444-5555')),
        36,
        tp_endereco('Av. Sete de Setembro', 303, '70000-444', 'Brasília'),
        1
    )
);
/
INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '999.000.111-22',
        'Carlos Oliveira',
        tp_arr_telefone(tp_telefone('(71)99999-0000')),
        50,
        tp_endereco('Rua do Comércio', 404, '40000-555', 'Salvador'),
        2
    )
);
/



INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '121.222.333-44',
        'Laura Garcia',
        tp_arr_telefone(tp_telefone('(84)11111-2222')),
        29,
        tp_endereco('Av. Beira Mar', 505, '59000-666', 'Natal'),
        3
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
        8575
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
        415
    )
);

/
INSERT INTO tb_funcionario VALUES (
    tp_funcionario(
        '957.654.321-01',
        'John Doe',
        tp_arr_telefone(tp_telefone('(11)12345-6789')),
        25,
        tp_endereco('Av. Paulista', 123, '01311-000', 'São Paulo'),
        'atendente',
        '1500',
       21
    )
);
/
INSERT INTO tb_funcionario VALUES (
    tp_funcionario(
        '111.222.333-02',
        'Jane Smith',
        tp_arr_telefone(tp_telefone('(21)98765-4321')),
        32,
        tp_endereco('Rua da Praia', 567, '22000-000', 'Rio de Janeiro'),
        'vendedor',
        '1800',
       934534
    )
);
/
INSERT INTO tb_funcionario VALUES (
    tp_funcionario(
        '555.666.777-03',
        'Michael Johnson',
        tp_arr_telefone(tp_telefone('(31)55555-4444')),
        40,
        tp_endereco('Avenida Central', 789, '30100-111', 'Belo Horizonte'),
        'estoquista',
        '1600',
       34324
    )
);
/

INSERT INTO tb_funcionario VALUES (
    tp_funcionario(
        '777.888.999-04',
        'Anna Lee',
        tp_arr_telefone(tp_telefone('(41)77777-8888')),
        22,
        tp_endereco('Rua das Flores', 101, '80000-222', 'Curitiba'),
        'caixa',
        '1700',
       2343412
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
      3,
      0.3
  )
);
/
INSERT INTO tb_cupom VALUES (
  tp_cupom(
      5,
      0.5
  )
);
/
INSERT INTO tb_cupom VALUES (
  tp_cupom(
      2,
      0.2
  )
);
/
INSERT INTO tb_cupom VALUES (
  tp_cupom(
      1,
      0.1
  )
);
/

INSERT INTO tb_assento VALUES (
1,
'Normal'
)
/
INSERT INTO tb_assento VALUES (
2,
'Normal'
)
/

INSERT INTO tb_assento VALUES (
3,
'Especial'
)
/

INSERT INTO tb_ingresso VALUES (
  tp_ingresso(
      '1234',
      'I',
      30
  )
);
/

INSERT INTO tb_ingresso VALUES (
  tp_ingresso(
      '23232',
      'M',
      10
  )
);
/

INSERT INTO tb_ingresso VALUES (
  tp_ingresso(
      '1312',
      'M',
      15
  )
);
/

INSERT INTO tb_ingresso VALUES (
  tp_ingresso(
      '3123',
      'I',
      75
  )
);
/

INSERT INTO tb_compra VALUES (
  tp_compra(
    id_compra.NEXTVAL,
  (TO_DATE('2022-07-30 13:11', 'yyyy-mm-dd hh24:mi')),
    (SELECT REF(I) FROM tb_ingresso I WHERE I.COD_INGRESSO = 1234),
    (SELECT REF(C) FROM tb_cliente C WHERE C.CPF = '132.462.635-17'),
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
INSERT INTO tb_filme VALUES (
    tp_filme(
      2,
      'Ação',
      12,
      'Velozes e Furiosos 9',
      tp_arr_elenco(tp_elenco('Vin Diesel')),
      '02:15',
      'Justin Lin'
    )
);
/
INSERT INTO tb_filme VALUES (
    tp_filme(
      3,
      'Comédia',
      14,
      'Superbad',
      tp_arr_elenco(tp_elenco('Jonah Hill'), tp_elenco('Michael Cera'), tp_elenco('Christopher Mintz-Plasse')),
      '01:53',
      'Greg Mottola'
    )
);
/



/
INSERT INTO tb_filme VALUES (
    tp_filme(
      4,
      'Drama',
      16,
      'O Lado Bom da Vida',
      tp_arr_elenco(tp_elenco('Bradley Cooper'), tp_elenco('Jennifer Lawrence'), tp_elenco('Robert De Niro')),
      '02:02',
      'David O. Russell'
    )
);
/


INSERT INTO tb_filme VALUES (
    tp_filme(
      5,
      'Animação',
      10,
      'Toy Story 4',
      tp_arr_elenco(tp_elenco('Tom Hanks')),
      '01:40',
      'Josh Cooley'
    )
);
/

   INSERT INTO tb_sala VALUES (
    tp_sala(
      7,
      5,
      tp_nt_assentos(
        tp_assento(
          1,
          'Normal'
        ),
        tp_assento(
          2,
          'Normal'
        ),
        tp_assento(
          3,
          'Normal'
        ), 
        tp_assento(
          4,
          'Normal'
        ),
        tp_assento(
          5,
          'Normal'
        ) 
      )
    )
); 
/

   INSERT INTO tb_sala VALUES (
    tp_sala(
      1217,
      5,
      tp_nt_assentos(
        tp_assento(
          1,
          'Normal'
        ),
        tp_assento(
          2,
          'Normal'
        ),
        tp_assento(
          3,
          'Normal'
        ), 
        tp_assento(
          4,
          'Normal'
        ),
        tp_assento(
          5,
          'Normal'
        ) 
      )
    )
); 
/

   INSERT INTO tb_sala VALUES (
    tp_sala(
      3131,
      5,
      tp_nt_assentos(
        tp_assento(
          1,
          'Normal'
        ),
        tp_assento(
          2,
          'Normal'
        ),
        tp_assento(
          3,
          'Normal'
        ), 
        tp_assento(
          4,
          'Normal'
        ),
        tp_assento(
          5,
          'Normal'
        ) 
      )
    )
); 
/

   INSERT INTO tb_sala VALUES (
    tp_sala(
      313131,
      5,
      tp_nt_assentos(
        tp_assento(
          1,
          'Normal'
        ),
        tp_assento(
          2,
          'Especial'
        ),
        tp_assento(
          3,
          'Especial'
        ), 
        tp_assento(
          4,
          'Normal'
        ),
        tp_assento(
          5,
          'Especial'
        ) 
      )
    )
); 
/
INSERT INTO tb_sala VALUES (
    tp_sala(
      133,
      3,
      tp_nt_assentos(
        tp_assento(
          1,
          'Normal'
        ),
        tp_assento(
          2,
          'Especial'
        ),
        tp_assento(
          3,
          'Normal'
        )
      )
    )
);
/
INSERT INTO tb_sala VALUES (
    tp_sala(
     3124,
      8,
      tp_nt_assentos(
        tp_assento(
          1,
          'Normal'
        ),
        tp_assento(
          2,
          'Normal'
        ),
        tp_assento(
          3,
          'Normal'
        ),
        tp_assento(
          4,
          'Normal'
        ),
        tp_assento(
          5,
          'Normal'
        ),
        tp_assento(
          6,
          'Normal'
        ),
        tp_assento(
          7,
          'Normal'
        ),
        tp_assento(
          8,
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
    (SELECT REF(S) FROM tb_sala S WHERE S.id_sala = 133),
    (SELECT REF(C) FROM tb_funcionario C WHERE C.cpf = '132.462.635-97')
);
-- ACIMA ESTÁ CORRETO