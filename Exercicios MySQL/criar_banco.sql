CREATE DATABASE DB_BANCO;

USE DB_BANCO;

CREATE TABLE agencia (
cod_ag CHAR(3) PRIMARY KEY,
nome VARCHAR(20) NOT NULL,
cidade VARCHAR(50));


CREATE TABLE cliente (
cpf varchar(11) NOT NULL PRIMARY KEY,
nome VARCHAR(80) NOT NULL,
endereco VARCHAR (120),
cidade VARCHAR(50),
estado VARCHAR(2));


CREATE TABLE conta (
nro_conta CHAR(4) NOT NULL,
cod_ag CHAR(3) not null,
cpf varchar(11)not null ,
saldo DECIMAL(10,2),
PRIMARY KEY (nro_conta, cod_ag),
FOREIGN KEY (cod_ag) REFERENCES agencia(cod_ag),
FOREIGN KEY (cpf) REFERENCES cliente(cpf));


CREATE TABLE movimentacao (
id_movimentacao int,
cod_ag CHAR(3) not null,
nro_conta CHAR(4) not null ,
tipo char(1),
descricao varchar(50) NOT NULL,
valor decimal(10,2) not null,
dt_movimentacao date not null,
PRIMARY KEY (id_movimentacao, cod_ag, nro_conta),
FOREIGN KEY (nro_conta) REFERENCES conta(nro_conta),
FOREIGN KEY (cod_ag) REFERENCES conta(cod_ag));




INSERT INTO AGENCIA (cod_ag, nome, cidade) VALUES
('A01', 'CNB', 'Conjunto Nacional'),
('A02', 'SCS', 'Setor Comercial Sul'),
('A03', 'PRI', 'Setor Bancário Sul'),
('A04', 'SHN', 'Setor Hoteleiro Norte');


INSERT INTO CLIENTE (CPF, NOME, ENDERECO, CIDADE)
VALUES
( '37949553073', 'JOAO PEREIRA','Quadra, 17 Conjunto B', 'Sobradinho'),
( '40427618010', 'ANTONIO CARLOS', 'QI 21, bloco A atpto 115', 'Guará II'),
( '49102730006', 'CARLOS SILVA',  'QE 30, apto 215', 'Guará'),
( '79457546008', 'ANDRE FERREIRA', 'QI, 7', 'Brasília'),
( '89998191084', 'MANOEL SANTOS', 'Q 20, casa 17', 'Sobradinho II'),
( '02765688001', 'JOSÉ ANDRADE',  'QI 5, cassa 17', 'Brasília');


INSERT INTO CONTA (COD_AG, CPF, NRO_CONTA, SALDO)
VALUES
('A01', '37949553073', '1901', 0),
('A01', '79457546008', '1902', 0),
('A02', '02765688001', '2903', 0),
('A01', '89998191084', '1904', 0),
('A03', '49102730006', '3905', 0),
('A04', '40427618010', '4906', 0);








