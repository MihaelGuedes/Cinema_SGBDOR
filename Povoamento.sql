INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '132.462.635-97',
        'Jabulani',
        tp_arr_telefone(tp_telefone('(81)98279-7555')),
        18,
        tp_endereco('Rua joaquim', 42, '50670-490','Olinda'),
        1
    )
);

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

INSERT INTO tb_funcionario VALUES (
    tp_funcionario(
        '132.462.635-97',
        'Jabulani',
        tp_arr_telefone(tp_telefone('(81)98279-7555')),
        18,
        tp_endereco('Rua joaquim', 42, '50670-490','Olinda'),
        'lanterninha',
        '1000',
        1
    )
);

INSERT INTO tb_supervisiona VALUES (
    tp_supervisiona(
        tp_funcionario(
        '132.462.635-97',
        'Jabulani',
        tp_arr_telefone(tp_telefone('(81)98279-7555')),
        18,
        tp_endereco('Rua joaquim', 42, '50670-490','Olinda'),
        'gerente',
        '1900',
        1
      ),
      tp_funcionario(
        '132.462.635-97',
        'Jabulani',
        tp_arr_telefone(tp_telefone('(81)98279-7555')),
        18,
        tp_endereco('Rua joaquim', 42, '50670-490','Olinda'),
        'lanterninha',
        '1000',
        1
     )
    )
);

INSERT INTO tb_cupom VALUES (
  tp_cupom(
      id_cupom.NEXTVAL,
      30
  )
);

INSERT INTO tb_ingresso VALUES (
  tp_ingresso(
      '1234',
      'M',
      15
  )
);

INSERT INTO tb_compra VALUES (
  tp_compra(
    14324,
    '2023-05-05',
    tp_ingresso(
        '1234',
        'M',
        15
    ),
    tp_cliente(
        '132.462.635-97',
        'Jabulani',
        tp_arr_telefone(tp_telefone('(81)98279-7555')),
        18,
        tp_endereco('Rua joaquim', 42, '50670-490','Olinda'),
        1
    ),
    tp_cupom(
        id_cupom.NEXTVAL,
        30
    )
  )
);

INSERT INTO tb_filme VALUES (
    tp_filme(
      1,
      'Terror',
      15,
      'Jogos Mortais',
      tp_arr_elenco(tp_elenco('Matheus Aragão', 'Caio Castro')),
      '02:45',
      'Mihael Guedes'
    )
);

INSERT INTO tb_assento VALUES (
    tp_assento(
      1,
      'Normal'
    )
);

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

INSERT INTO tb_reserva VALUES (
  tp_reserva(
    '2023-05-05',
    tp_filme(
      1,
      'Terror',
      15,
      'Jogos Mortais',
      tp_arr_elenco(tp_elenco('Matheus Aragão', 'Caio Castro')),
      '02:45',
      'Mihael Guedes'
    ),
    tp_ingresso(
        '1234',
        'M',
        15
    ),
    tp_assento(
      1,
      'Normal'
    )
  )
);

INSERT IN tb_limpa VALUES (
  '2023-05-05',
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
    ),
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