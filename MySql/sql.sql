USE hcode;

SELECT *
FROM tb_pessoas;

INSERT INTO tb_pessoas
VALUES(1, 'João', 'M');

INSERT INTO tb_pessoas
  (nome, sexo)
VALUES
  ('F', 'Maria');

INSERT INTO tb_pessoas
  (nome, sexo)
VALUES
  ('Divanei', 'M'),
  ('Luiz', 'M'),
  ('Daniel', 'M'),
  ('José', 'M'),
  ('Djalma', 'M'),
  ('Tatiane', 'F'),
  ('Jaqueline', 'F'),
  ('Natali', 'F');

SELECT *
FROM tb_funcionarios;
SELECT *
FROM tb_pessoas;

-- INSERT INTO tb_funcionarios
SELECT id, nome, 960, CURRENT_DATE
(), sexo, NULL FROM tb_pessoas;


SELECT COUNT(*) AS total
FROM tb_funcionarios;

SELECT nome, salario AS atual,
  CONVERT(salario * 1.1, DEC(10,2)) AS 'Salario com aumento de 10%'
FROM tb_funcionarios;

SELECT *
FROM tb_funcionarios
WHERE sexo = 'M' AND salario > 1000;

SELECT *
FROM tb_funcionarios
WHERE sexo = 'F' OR salario > 1000;

UPDATE tb_funcionarios SET salario = salario * 1.4 WHERE  ID = 3;

SELECT *
FROM tb_funcionarios
WHERE nome NOT LIKE 'j%';

SELECT *
FROM tb_funcionarios
WHERE salario NOT BETWEEN 1000 AND 2000;

SELECT *
FROM tb_funcionarios
WHERE SOUNDEX(nome) = SOUNDEX('luis');

SELECT *
FROM tb_funcionarios
WHERE cadastro > '2016-01-01';

UPDATE tb_funcionarios SET admissao = CURRENT_DATE
() WHERE id =2;

SELECT *
FROM tb_funcionarios;

UPDATE tb_funcionarios SET admissao = DATE_ADD(CURRENT_DATE
(), INTERVAL 60 DAY) WHERE id =1;

SELECT DATEDIFF(admissao, CURRENT_DATE
()) AS 'diferenca de dias' FROM tb_funcionarios WHERE ID= 1;

SELECT *
FROM tb_funcionarios
WHERE MONTH(admissao) = 9;

SELECT *
FROM tb_funcionarios
ORDER BY 2;

SELECT *
FROM tb_funcionarios
ORDER BY salario DESC, nome ASC
;

SELECT *
FROM tb_funcionarios
ORDER BY salario LIMIT 0, 2;

SELECT * FROM tb_funcionarios
WHERE YEAR
(admissao) = 2018 AND Month
(admissao) = 7
ORDER BY salario LIMIT 0, 2;

UPDATE tb_funcionarios SET salario =  3000 WHERE  id = 5;

UPDATE  tb_funcionarios SET salario = 4000, admissao = '2015-12-12' WHERE id = 6;

SELECT *
FROM tb_funcionarios
WHERE id = 6;

DELETE FROM tb_funcionarios WHERE id = 1;

START TRANSACTION;

DELETE FROM tb_pessoas;

SELECT *
FROM tb_pessoas;

ROLLBACK;

COMMIT;

INSERT INTO tb_pessoas
VALUES
  (NULL, 'Jose', 'M');

TRUNCATE TABLE tb_pessoas;

DROP TABLE tb_funcionarios;
DROP TABLE tb_pessoas;

CREATE TABLE tb_pessoas
(
  idpessoa INT
  AUTO_INCREMENT NOT NULL,
desnome VARCHAR
  (256) NOT NULL,
dtadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  (),
CONSTRAINT PK_pessoas PRIMARY KEY
  (idpessoa)
) ENGINE = InnoDB;


  CREATE TABLE tb_funcionarios
  (
    idfuncionario INT
    AUTO_INCREMENT NOT NULL,
    idpessoa INT NOT NULL,
    vlsalario DECIMAL
    (10,2) NOT NULL DEFAULT 1000.00,
    dtadmissao DATE NOT NULL,
    CONSTRAINT PK_funcionarios PRIMARY KEY
    (idfuncionario),
    CONSTRAINT FK_funcionarios_pessoas foreign key
    (idpessoa)
	REFERENCES tb_pessoas
    (idpessoa)
);

    INSERT INTO tb_pessoas
    VALUES
      (NULL, 'João', NULL);

    SELECT *
    FROM tb_pessoas;

    INSERT INTO tb_funcionarios
    VALUES
      (NULL, 1, 5000, current_date
    ());

    SELECT *
    FROM tb_funcionarios;

    INSERT INTO tb_funcionarios
    VALUES
      (NULL, 2, 5000, current_date
    ());

    USE hcode;

    SELECT *
    FROM tb_funcionarios a INNER JOIN tb_pessoas b ON a.idpessoa = b.idpessoa;

    SELECT *
    FROM tb_funcionarios INNER JOIN tb_pessoas USING (idpessoa) ;

    INSERT INTO tb_pessoas
    VALUES
      (NULL, 'Glaucio', NULL);

    SELECT *
    FROM tb_pessoas a LEFT JOIN tb_funcionarios b ON a.idpessoa = b.idpessoa;

    SELECT *
    FROM tb_pessoas a RIGHT JOIN tb_funcionarios b ON a.idpessoa = b.idpessoa;

    INSERT INTO tb_pessoas
    VALUES
      (NULL, 'José' , NULL);

    SELECT idepessoa
    FROM tb_pessoas
    WHERE desnome LIKE 'J%';

    DELETE FROM tb_pessoas WHERE idpessoa IN (SELECT idepessoa
    FROM tb_pessoas
    WHERE desnome LIKE 'J%');

    CREATE TABLE tb_pedidos
    (
      idpedido INT
      AUTO_INCREMENT NOT NULL,
    idpessoa INT NOT NULL,
    dtpedido DATETIME NOT NULL,
    vlpedido DEC
      (10,2),
    CONSTRAINT PK_pedidos PRIMARY KEY
      (idpedido),
    CONSTRAINT FK_pedidos_pessoas FOREIGN KEY
      (idpessoa) REFERENCES tb_pessoas
      (idpessoa)
);


      SELECT *
      FROM tb_pedidos;

      INSERT INTO tb_pedidos
      VALUES
        (NULL, 2, CURRENT_DATE
      (), 9999.99);
      INSERT INTO tb_pedidos
      VALUES
        (NULL, 2, CURRENT_DATE
      (), 8888.54);

      INSERT INTO tb_pedidos
      VALUES
        (NULL, 3, CURRENT_DATE
      (), 400000.00);

      SELECT b.desnome, SUM(a.vlpedido) AS Total
      FROM tb_pedidos a INNER JOIN tb_pessoas b   USING (idpessoa)
      GROUP BY b.idpessoa;

      SELECT b.desnome, SUM(a.vlpedido) AS Total, CONVERT(AVG(a.vlpedido), DEC(10,2)) AS Media
      FROM tb_pedidos a INNER JOIN tb_pessoas b   USING (idpessoa)
      GROUP BY b.idpessoa;


      SELECT b.desnome,
        SUM(a.vlpedido) AS Total,
        CONVERT(AVG(a.vlpedido), DEC(10,2)) AS Media,
        CONVERT(MIN(a.vlpedido), DEC(10,2)) AS 'Menor Valor',
        CONVERT(MAX(a.vlpedido), DEC(10,2)) AS 'Maior Valor',
        COUNT(*) AS 'Total de Pedidos'
      FROM tb_pedidos a INNER JOIN tb_pessoas b   USING (idpessoa)
      GROUP BY b.idpessoa
      HAVING SUM(a.vlpedido) > 40000
      ORDER BY desnome;

      CREATE  VIEW v_pedidostotais
      AS
        SELECT b.desnome,
          SUM(a.vlpedido) AS Total,
          CONVERT(AVG(a.vlpedido), DEC(10,2)) AS Media,
          CONVERT(MIN(a.vlpedido), DEC(10,2)) AS 'Menor Valor',
          CONVERT(MAX(a.vlpedido), DEC(10,2)) AS 'Maior Valor',
          COUNT(*) AS 'Total de Pedidos'
        FROM tb_pedidos a INNER JOIN tb_pessoas b   USING (idpessoa)
        GROUP BY b.idpessoa
        ORDER BY desnome;

      SELECT *
      FROM v_pedidostotais;

      DELIMITER $$

      CREATE PROCEDURE sp_pessoa_save (
 pdesnome VARCHAR
      (256)
)
      BEGIN
        INSERT INTO tb_pessoas
        VALUES(NULL, pdesnome, NULL);

        SELECT *
        FROM tb_pessoas
        WHERE idpessoa = LAST_INSERT_ID();
      END
      $$

DELIMITER ;

CALL sp_pessoa_save
      ('Massaharu');

      USE hcode;




      DELIMITER $$

      CREATE PROCEDURE sp_funcionario_save (
	pdesnome VARCHAR
      (256),
    pvlsalario DECIMAL
      (10,2),
    pdtadmissao DATETIME
)
      BEGIN

        DECLARE vidpessoa INT;

      START TRANSACTION;

      IF NOT EXISTS (SELECT idpessoa
      FROM tb_pessoas
      WHERE desnome = pdesnome) THEN
      INSERT INTO tb_pessoas
      VALUES
        (NULL, pdesnome, NULL);
      SET vidpessoa
      = LAST_INSERT_ID
      ();
    ELSE
      SELECT 'Usuario já cadastrado !' AS resultado;
      ROLLBACK;
      END
      IF;
    
	IF NOT EXISTS (SELECT idpessoa
      FROM tb_funcionarios
      WHERE idpessoa = vidpessoa) THEN
      INSERT INTO tb_funcionarios
      VALUES
        (NULL, vidpessoa, pvlsalario, pdtadmissao);
      ELSE
      SELECT 'Cadastrado com sucesso' AS resultado;
      ROLLBACK;
      END
      IF;
    COMMIT;
      SELECT 'Dados cadastrado com sucesso' AS resultado;


      END $$

DELIMITER ;

      SELECT *
      FROM tb_pessoas;

      CALL sp_funcionario_save
      ('Divanei', 5000, CURRENT_DATE
      ());

DELIMITER $$

      CREATE FUNCTION fn_imposto_renda (
	pvlsalario DECIMAL (10,2)
)
RETURNS DEC
      (10,2)
      BEGIN

        DECLARE vimposto DECIMAL
        (10,2);
        /*
    ATÉ 1903,98 NÃO PAGA IMPOSTO
    1903,99 ATÉ 2826,65 PAGA 7,5$ DEDUZIR NO IMPOSTO 142,80
    2826,66 ATÉ 3751,05 PAGA 15% DEDUZIR DO IMPOSTO 354,80
    3751,06 ATÉ 4664,68 PAGA 22,5 DEDUZIR DO IMPOSTO 636,13
    ACIMA 4664,68 PAGA 27,5% DEDUZIR DO IMPOSTO 869,36
    */
        SET vimposto
        = CASE
		WHEN pvlsalario <= 1903.98 THEN 0
        WHEN pvlsalario >= 1903.99 AND pvlsalario <= 2826.65 THEN
        (pvlsalario * .075) - 142.80
        WHEN pvlsalario >= 2826.66 AND pvlsalario <= 3751.05 THEN
        (pvlsalario * .15) - 354.80
        WHEN pvlsalario >= 3751.06 AND pvlsalario <= 4664.68 THEN
        (pvlsalario * .225) - 636.13
        WHEN pvlsalario >= 4664.68 THEN
        (pvlsalario * .275) - 869.36
      END;

      RETURN vimposto;

      END $$

DELIMITER ;

      SELECT * , fn_imposto_renda(a.vlsalario) AS vimposto
      FROM tb_funcionarios a
        INNER JOIN tb_pessoas b  USING (idpessoa);
