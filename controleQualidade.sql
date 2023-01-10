CREATE DATABASE DESAFIO;

USE DESAFIO;

CREATE SCHEMA PRODUCAO;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE PRODUCAO.TIPO_PRODUTO(
	CD_TIPO_PRODUTO						INT					PRIMARY KEY			IDENTITY(1,1)
,	NM_PRODUTO							VARCHAR(30)			NOT NULL
);

CREATE TABLE PRODUCAO.PRODUTO(
	CD_PRODUTO							INT					PRIMARY KEY			IDENTITY(1,1)
,	CD_LINHA_PRODUCAO					INT					NOT NULL
,	CD_TIPO_PRODUTO						INT					NOT NULL
,	AA_FABRICACAO_PRODUTO				DATE				NOT NULL
,	CONSTRAINT CD_TIPO_PRODUTO			FOREIGN KEY(CD_TIPO_PRODUTO)			REFERENCES PRODUCAO.TIPO_PRODUTO		(CD_TIPO_PRODUTO)
																							ON DELETE CASCADE
																							ON UPDATE CASCADE
);

CREATE TABLE PRODUCAO.SETOR(
	CD_SETOR							INT					PRIMARY KEY			IDENTITY(1,1)
,	NM_SETOR							VARCHAR(50)			NOT NULL
);

CREATE TABLE PRODUCAO.INSPETOR(
	CD_MATRICULA_INSPETOR				INT					PRIMARY KEY			IDENTITY(1,1)
,	CD_SETOR							INT					NOT NULL
,	NM_INSPETOR							VARCHAR (50)		NOT NULL
,	CONSTRAINT CD_SETOR					FOREIGN KEY(CD_SETOR)					REFERENCES PRODUCAO.SETOR (CD_SETOR)
																							ON DELETE CASCADE
																							ON UPDATE CASCADE
);

CREATE TABLE PRODUCAO.FICHA_AVALIACAO(
	CD_FICHA_AVALIACAO					INT					PRIMARY KEY			IDENTITY(1,1)
,	CD_MATRICULA_INSPETOR				INT					NOT NULL
,	DT_FICHA_AVALIACAO					DATE				NOT NULL
,	CONSTRAINT CD_MATRICULA_INSPETOR	FOREIGN KEY(CD_MATRICULA_INSPETOR)		REFERENCES PRODUCAO.INSPETOR(CD_MATRICULA_INSPETOR)
																							ON DELETE CASCADE
																							ON UPDATE CASCADE
);

CREATE TABLE PRODUCAO.AVALIACAO(
	SG_AVALIACAO						VARCHAR(2)			PRIMARY KEY			NOT NULL
,	DS_AVALIACAO						VARCHAR(50)			NOT NULL
);

CREATE TABLE PRODUCAO.ITEM_FICHA_AVALIACAO(
	CD_ITEM_FICHA_AVALIACAO				INT					PRIMARY KEY			IDENTITY(1,1)
,	CD_FICHA_AVALIACAO					INT					NOT NULL
,	CD_PRODUTO							INT					NOT NULL
,	SG_AVALIACAO						VARCHAR(2)			NOT NULL
,	HR_AVALIACAO						TIME				NOT NULL
,	CONSTRAINT CD_PRODUTO				FOREIGN KEY(CD_PRODUTO)					REFERENCES PRODUCAO.PRODUTO(CD_PRODUTO)
																						   ON DELETE CASCADE
																						   ON UPDATE CASCADE     
,	CONSTRAINT CD_FICHA_AVALIACAO		FOREIGN KEY(CD_FICHA_AVALIACAO)			REFERENCES PRODUCAO.FICHA_AVALIACAO(CD_FICHA_AVALIACAO)
																						   ON DELETE CASCADE
																						   ON UPDATE CASCADE
,	CONSTRAINT SG_AVALIACAO				FOREIGN KEY(SG_AVALIACAO)				REFERENCES PRODUCAO.AVALIACAO (SG_AVALIACAO)
																						   ON DELETE CASCADE
																						   ON UPDATE CASCADE
);

---------------------------------------------------------------------------------------------------------------------------------
--Alimentação da base de dados:

BEGIN TRANSACTION;
INSERT INTO PRODUCAO.TIPO_PRODUTO(NM_PRODUTO)
VALUES  ('Geladeira')
,		('Máquina de lavar')
,		('Fogão')
,		('Freezer')
,		('Frigobar')
COMMIT;
SELECT * FROM PRODUCAO.TIPO_PRODUTO;

BEGIN TRANSACTION;
INSERT INTO PRODUCAO.PRODUTO(CD_LINHA_PRODUCAO, CD_TIPO_PRODUTO, AA_FABRICACAO_PRODUTO)
VALUES  (2, 1, '2022'), (3, 2, '2022'), (4, 3, '2022'), (1, 5, '2022'), (2, 5, '2022')
,		(3, 1, '2022'), (4, 2, '2022'), (1, 3, '2022'), (2, 4, '2022'), (3, 5, '2022')
,		(3, 1, '2022'), (1, 2, '2022'), (2, 3, '2022'), (3, 4, '2022'), (4, 2, '2022')
,		(3, 3, '2022'), (1, 4, '2022'), (4, 5, '2022'), (3, 2, '2022'), (4, 1, '2022')
,		(1, 1, '2022'), (2, 2, '2022'), (3, 3, '2022'), (1, 5, '2022'), (2, 5, '2022')
,		(3, 1, '2022'), (4, 2, '2022'), (1, 3, '2022'), (2, 4, '2022'), (3, 5, '2022')
,		(4, 1, '2022'), (1, 2, '2022'), (2, 3, '2022'), (3, 4, '2022'), (4, 2, '2022')
,		(3, 3, '2022'), (1, 4, '2022'), (4, 5, '2022'), (3, 2, '2022'), (4, 1, '2022')
,		(3, 5, '2022'), (4, 1, '2022'), (1, 2, '2022'), (2, 3, '2022'), (3, 4, '2022')
,		(4, 2, '2022'), (3, 3, '2022'), (1, 4, '2022'), (4, 5, '2022'), (3, 2, '2022')
,		(4, 1, '2022');
COMMIT;
SELECT * FROM PRODUCAO.PRODUTO;

BEGIN TRANSACTION;
INSERT INTO PRODUCAO.AVALIACAO(SG_AVALIACAO, DS_AVALIACAO)
VALUES  ('OK','Liberado')
,		('EL','Problema elétrico')
,		('PT','Problema de pintura')
,		('PE','Problema na estrutura')
,		('TR','Todo rejeitado')
COMMIT;
SELECT * FROM PRODUCAO.AVALIACAO;

BEGIN TRANSACTION;
INSERT INTO PRODUCAO.SETOR(NM_SETOR)
VALUES  ('Qualidade')
,		('Administrativo')
,		('RH')
,		('Comercial')
,		('Financeiro')
COMMIT;
SELECT * FROM PRODUCAO.SETOR;

BEGIN TRANSACTION;
INSERT INTO PRODUCAO.INSPETOR(CD_SETOR, NM_INSPETOR)
VALUES  (1, 'André'),		(1, 'Maria')
,		(1, 'Julia'),		(1, 'Vera')
,		(1, 'Mara'),		(1, 'Fernanda')	
,		(1, 'Trancoso'),	(1, 'Helena')
,		(1, 'Paula'),		(1, 'Victoria')
COMMIT;
SELECT * FROM PRODUCAO.INSPETOR;

BEGIN TRANSACTION;
INSERT INTO PRODUCAO.FICHA_AVALIACAO(CD_MATRICULA_INSPETOR, DT_FICHA_AVALIACAO)
VALUES  (1,'20221202'), (2,'20221203'), (3,'20221204'), (6,'20221205'), (7,'20221206')
,		(6,'20221207'), (5,'20221208'), (4,'20221209'), (3,'20221210'), (2,'20221211')
,		(1,'20221212'), (2,'20221213'), (6,'20221214'), (8,'20221215'), (7,'20221216')
,		(1,'20221217'), (2,'20221218'), (3,'20221219'), (6,'20221220'), (7,'20221221')
,		(6,'20221222'), (5,'20221223')
COMMIT;
SELECT * FROM PRODUCAO.FICHA_AVALIACAO;

BEGIN TRANSACTION;
INSERT INTO PRODUCAO.ITEM_FICHA_AVALIACAO(CD_FICHA_AVALIACAO, CD_PRODUTO, SG_AVALIACAO, HR_AVALIACAO)
--Ordenados por Ficha
VALUES  (1, 1, 'EL', '09:05'), (1, 2, 'OK', '09:25'), (1, 3, 'OK', '12:07'), (1, 4, 'OK', '13:08'), (1, 5, 'EL', '15:31')
,		(2, 1, 'OK', '07:01'), (2, 5, 'OK', '07:50'), (2, 7, 'TR', '08:00'), (2, 8, 'OK', '09:01')
,		(3, 9, 'EL', '07:00'), (3, 10, 'PT', '08:05'), (3, 9, 'OK', '09:20'), (3, 10, 'OK', '10:00')
,		(4, 11, 'PE', '15:00'), (4, 12, 'PE', '15:40'), (4, 13, 'EL', '16:05'), (4, 11, 'OK', '16:20')
,		(5, 14, 'PT', '13:00'), (5, 15, 'EL', '13:20'), (5, 12, 'OK', '13:50'), (5, 13, 'OK', '14:00'), (5, 14, 'OK', '14:25'), (5, 15, 'OK', '14:51'), (5, 16, 'TR', '15:01')
,		(6, 36, 'OK', '08:02'), (6, 37, 'PE', '08:35'), (6, 38, 'PT', '08:50'), (6, 37, 'OK', '10:06'), (6, 38, 'PT', '09:34')
,		(7, 39, 'OK', '09:08'), (7, 40, 'OK', '09:29'), (7, 41, 'PT', '10:17')
,		(8, 42, 'OK', '09:01'), (8, 41, 'OK', '09:20'), (8, 43, 'EL', '09:50')
,		(9, 43, 'PE', '10:16'), (9, 44, 'OK', '11:01')
,		(10, 45, 'OK', '15:00'), (10, 46, 'PE', '15:58')
,		(11, 47, 'TR', '13:00'), (11, 48, 'PE', '13:53')
,		(12, 46, 'OK', '13:00'), (12, 49, 'TR', '13:50')
,		(13, 48, 'OK', '07:00'), (13, 43, 'OK', '07:20')
,		(14, 50, 'PT', '07:36'), (14, 51, 'OK', '07:58'), (14, 50, 'PT', '08:14')
,		(15, 17, 'EL', '09:05'), (15, 20, 'OK', '09:20'), (15, 19, 'PT', '09:35'), (15, 16, 'OK', '09:50'), (15, 17, 'OK', '10:00'), (15, 18, 'OK', '10:15')
,		(16, 19, 'OK', '08:02'), (16, 21, 'PE', '08:35'), (16, 28, 'OK', '08:50'), (16, 30, 'OK', '10:06')
,		(17, 21, 'OK', '09:08'), (17, 22, 'OK', '09:29'), (17, 23, 'PT', '10:17')
,		(18, 23, 'OK', '09:01'), (18, 24, 'OK', '09:20'), (18, 25, 'EL', '09:50')
,		(19, 26, 'OK', '10:16'), (19, 25, 'OK', '11:01')
,		(20, 27, 'OK', '15:00'), (20, 29, 'OK', '15:58')
,		(21, 31, 'OK', '13:00'), (21, 32, 'OK', '13:53')
,		(22, 33, 'OK', '13:00'), (22, 34, 'OK', '13:50'), (22, 35, 'OK', '14:26')
COMMIT;
SELECT * FROM PRODUCAO.ITEM_FICHA_AVALIACAO;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Resolução das questões do desafio:

USE DESAFIO;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1. Quantas horas de controle de qualidade o inspetor Trancoso da Silva fez no dia 16/12/2022?
SELECT CAST(DATEDIFF(MINUTE, MIN(IFA.HR_AVALIACAO) , CONVERT(TIME, MAX(IFA.HR_AVALIACAO)))/60 AS VARCHAR(4))+ ':' +
	   CAST(DATEDIFF(MINUTE, MIN(IFA.HR_AVALIACAO), CONVERT(TIME, MAX(IFA.HR_AVALIACAO)))%60 AS VARCHAR(4)) AS "Horas Trancoso"
FROM   PRODUCAO.INSPETOR AS I,
       PRODUCAO.FICHA_AVALIACAO AS FA,
	   PRODUCAO.ITEM_FICHA_AVALIACAO AS IFA
WHERE  I.CD_MATRICULA_INSPETOR = FA.CD_MATRICULA_INSPETOR
	   AND FA.DT_FICHA_AVALIACAO = '20221216'
	   AND FA.CD_FICHA_AVALIACAO = IFA.CD_FICHA_AVALIACAO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--2. Quantas horas o inspetor Trancoso da Silva trabalhou no período de 01/12/2022 à 22/12/2022?
SELECT CAST(DATEDIFF(MINUTE, MIN(IFA.HR_AVALIACAO), CONVERT(TIME, MAX(IFA.HR_AVALIACAO)))/60 AS VARCHAR(4))+ ':' +
	   CAST(DATEDIFF(MINUTE, MIN(IFA.HR_AVALIACAO), CONVERT(TIME, MAX(IFA.HR_AVALIACAO)))%60 AS VARCHAR(4)) as "Horas Trancoso"
FROM   PRODUCAO.INSPETOR AS INSP,
       PRODUCAO.FICHA_AVALIACAO AS FA,
	   PRODUCAO.ITEM_FICHA_AVALIACAO AS IFA
WHERE  INSP.CD_MATRICULA_INSPETOR = FA.CD_MATRICULA_INSPETOR
	   AND FA.DT_FICHA_AVALIACAO BETWEEN '20221201' AND '20221216' 
	   AND FA.CD_FICHA_AVALIACAO = IFA.CD_FICHA_AVALIACAO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--3.Quais os tipos de defeito mais recorrentes no período de 01/12/2022 à 22/12/2022?
SELECT IFA.SG_AVALIACAO AS "Defeitos", COUNT(*) AS "Quantidade"
FROM   PRODUCAO.AVALIACAO AS AV,
       PRODUCAO.FICHA_AVALIACAO AS FA,
	   PRODUCAO.ITEM_FICHA_AVALIACAO AS IFA
WHERE  IFA.SG_AVALIACAO = AV.SG_AVALIACAO
	   AND IFA.SG_AVALIACAO != 'OK'
	   AND FA.DT_FICHA_AVALIACAO BETWEEN '20221201' AND '20221222' 
	   AND FA.CD_FICHA_AVALIACAO = IFA.CD_FICHA_AVALIACAO
GROUP BY IFA.SG_AVALIACAO
ORDER BY COUNT(*) DESC
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Quais inspetores atestam mais produtos com avaliação TR, todo rejeitado.
SELECT INSP.NM_INSPETOR AS Inspetor, 
	   IFA.SG_AVALIACAO AS AValiação,
	   COUNT(*) AS "Quantidade"
FROM   PRODUCAO.AVALIACAO AS AV,
       PRODUCAO.FICHA_AVALIACAO AS FA,
	   PRODUCAO.ITEM_FICHA_AVALIACAO AS IFA,
	   PRODUCAO.INSPETOR AS INSP
WHERE  INSP.CD_MATRICULA_INSPETOR = FA.CD_MATRICULA_INSPETOR
       AND IFA.SG_AVALIACAO = AV.SG_AVALIACAO
	   AND AV.SG_AVALIACAO = 'TR'
	   AND FA.CD_FICHA_AVALIACAO = IFA.CD_FICHA_AVALIACAO
GROUP BY IFA.SG_AVALIACAO , INSP.NM_INSPETOR
ORDER BY Quantidade DESC
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--5. Quais PRODUTOs que só foram liberados depois da detecção de algum problema?
--(A lógica usada foi: Se o produto de código tal tiver mais de uma avaliação, significa que ele retornou pra inspeção antes de ser liberado. 
--Juntei as tabelas, fiz o join, contei quantas vezes esse PRODUTO passou pela avaliação e se foi maior que 1 ele teve a última avaliação como OK)."
SELECT PROD.CD_PRODUTO AS ID, 
       TIPOPROD.NM_PRODUTO AS PRODUTO, 
	   COUNT(IFA.CD_ITEM_FICHA_AVALIACAO) AS "Qte de AValiações"
FROM   PRODUCAO.ITEM_FICHA_AVALIACAO IFA
	   INNER JOIN PRODUCAO.PRODUTO PROD ON PROD.CD_PRODUTO = IFA.CD_PRODUTO
	   INNER JOIN PRODUCAO.TIPO_PRODUTO TIPOPROD ON TIPOPROD.CD_TIPO_PRODUTO = PROD.CD_TIPO_PRODUTO
	   INNER JOIN PRODUCAO.AVALIACAO AV ON AV.SG_AVALIACAO = IFA.SG_AVALIACAO
	   INNER JOIN PRODUCAO.FICHA_AVALIACAO FA ON FA.CD_FICHA_AVALIACAO = IFA.CD_FICHA_AVALIACAO 
GROUP BY PROD.CD_PRODUTO, TIPOPROD.NM_PRODUTO
HAVING COUNT(IFA.CD_ITEM_FICHA_AVALIACAO) > 1
