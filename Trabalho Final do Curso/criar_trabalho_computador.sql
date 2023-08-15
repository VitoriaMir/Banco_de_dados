CREATE SCHEMA IF NOT EXISTS trabalho_computador;
USE trabalho_computador ;

CREATE TABLE IF NOT EXISTS cargo (
  cod_cargo INT NOT NULL,
  nome_cargo VARCHAR(100) NOT NULL,
  salario FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (cod_cargo));
  
INSERT INTO cargo (cod_cargo, nome_cargo, salario) VALUES
 ('400', 'Diretor financeiro', 6111.29),
 ('410', 'Analista contábil', 4358.79),
 ('420', 'Recepcionista', 1925.38),
 ('430', 'Analista de RH', 2875.51),
 ('450', 'Supervisor Geral', 8094.74), 
 ('460', 'Tecnico de informatica', 4684.60),
 ('470', 'Assistente de Tecnologia da Informação', 3120.49),
 ('480', 'Programador', 4508.50),
 ('490', 'Vendedor', 1868.21),
 ('412', 'Estagiario', 999.21),
 ('422', 'Auxiliar de limpeza', 1326.43),
 ('432', 'Tecnico Eletronico', 2677.43);
 select * from cargo;

CREATE TABLE IF NOT EXISTS categorias (
  cod_categoria INT NOT NULL,
  divisao_produto VARCHAR(45) NOT NULL,
  PRIMARY KEY (cod_categoria));
  
INSERT INTO categorias (cod_categoria, divisao_produto) VALUES 
('310', 'Computadores Desktop'),
('320', 'Memória e Armazenamento'),
('330', 'Dispositivos de Conexão em Rede'),
('340', 'Monitores'),
('350', 'Impressoras e Acessórios'),
('360', 'Peças e Componentes para Computador'),
('370', 'Acessórios para Computadores');  
select * from categorias;

CREATE TABLE IF NOT EXISTS estado (
  cod_estado INT NOT NULL AUTO_INCREMENT,
  nome_estado VARCHAR(60) NOT NULL,
  sigla VARCHAR(2) NOT NULL,
  PRIMARY KEY (cod_estado));

INSERT INTO estado (cod_estado, nome_estado, sigla) VALUES 
('1500', 'MINAS GERAIS', 'MG'),
('1510', 'SÃO PAULO', 'SP'),
('1520', 'RIO DE JANEIRO', 'RJ'),
('1530', 'DISTRITO FEDERAL', 'DF'),
('1540', 'ACRE', 'AC'),
('1550', 'BAHIA', 'BA');
select * from estado;

CREATE TABLE IF NOT EXISTS cidade (
  cod_cidade INT NOT NULL AUTO_INCREMENT,
  nome_cidade VARCHAR(60) NOT NULL,
  cod_estado INT NULL,
  PRIMARY KEY (cod_cidade),
  UNIQUE INDEX cod_estado_UNIQUE (cod_estado ASC) VISIBLE,
    FOREIGN KEY (cod_estado)
    REFERENCES estado (cod_estado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
INSERT INTO cidade (cod_cidade, nome_cidade, cod_estado) VALUES 
('1401', 'Belo Horizonte', '1500'),
('1402', 'São Paulo', '1510'),
('1403', 'Rio de Janeiro', '1520'),
('1404', 'Brasilia', '1530'),
('1405', 'Rio Branco', '1540'),
('1406', 'Salvador', '1550');  
select * from cidade;  

CREATE TABLE IF NOT EXISTS telefone (
  cod_telefone INT NOT NULL,
  DDD VARCHAR(2) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  PRIMARY KEY (cod_telefone));

INSERT INTO telefone (cod_telefone, DDD, numero) VALUES 
(5555, '31', '992168551'),
(5556, '11', '985526558'),
(5557, '21', '993756720'),
(5558, '61', '975069176'),
(5559, '68', '997237070'),
(5560, '71', '9340910141'),
(5561, '21', '9307800444'),
(5562, '71', '9728867750'),
(5563, '61', '9834449860'),
(5564, '31', '9726384170'); 

CREATE TABLE IF NOT EXISTS cliente (
  cod_cliente INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(200) NOT NULL,
  cpf VARCHAR(14) NOT NULL,
  email VARCHAR(90) NULL,
  cod_telefone INT NULL,
  PRIMARY KEY (cod_cliente),
  INDEX fk_cliente_telefone1_idx (cod_telefone ASC) VISIBLE,
  CONSTRAINT fk_cliente_telefone1
    FOREIGN KEY (cod_telefone)
    REFERENCES telefone (cod_telefone)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO cliente (cod_cliente, nome, cpf, email, cod_telefone) VALUES 
('111', 'Ana Paula','868.835.270-44', 'aninhapaula@icloud.com', 5564),
('112', 'Gabriel Nunes','563.375.230-91', 'gabrielnunes324@gmail.com', 5563),
('113', 'Daniel Alves','753.918.430-22', 'danielallves23@yahoo.com', 5562),
('114', 'Paulo Augusto','258.317.850-41', 'pauloaugusto00@gmail.com', 5561),
('115', 'Anastacia Viena','874.995.130-09', 'anastaciavienaa1@gmail.com', 5560),
('116', 'Caroline Miranda','648.179.980-59', 'carolinemirand44@outlook.com', 5559),
('117', 'Davi Andrade','810.194.510-50', 'daviandradde45@outlook.com', 5558),
('118', 'Joao Pedro','613.600.170-54', 'joaaopedrinho12@gmail.com', 5557),
('119', 'Matheus Gabriel','635.300.940-21', 'matheuzingabir33@yahoo.com', 5556),
('120', 'Debora Secco','819.128.200-30', 'deboraseccinho45@gmail.com', 5555);
select * from cliente;

CREATE TABLE IF NOT EXISTS endereco (
  cod_endereco INT NOT NULL AUTO_INCREMENT,
  rua VARCHAR(60) NOT NULL,
  numero_casa INT NOT NULL,
  complemento VARCHAR(60) NULL,
  referencia VARCHAR(45) NULL DEFAULT 'Sem referência',
  CEP VARCHAR(20) NOT NULL,
  cod_cliente INT NULL ,
  cod_cidade INT NULL,
  PRIMARY KEY (cod_endereco),
  UNIQUE INDEX cod_cliente_UNIQUE (cod_cliente ASC) VISIBLE,
  UNIQUE INDEX cod_cidade_UNIQUE (cod_cidade ASC) VISIBLE,
  UNIQUE INDEX cod_endereco_UNIQUE (cod_endereco ASC) VISIBLE,
  CONSTRAINT cod_cidade
    FOREIGN KEY (cod_cidade)
    REFERENCES cidade (cod_cidade)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT cod_cliente
    FOREIGN KEY (cod_cliente)
    REFERENCES cliente (cod_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

INSERT INTO endereco (rua, numero_casa, referencia, CEP, cod_cliente, cod_cidade) VALUES 
('Rua Araranguá', '723', 'A casa com grafite', '86035-720', '111', '1401'),
('Rua Brusque', '35', null, '55291-808', '112', '1402'),
('Av. Visconde de Guarapuava', '89', 'No final da rua, porta verde', '79620-322', '113', '1403'),
('R. Souza Naves', '716', null, '23036-392', '114', '1404'),
('Rua Ermelino de Leão', '378', 'A maior casa da rua', '76820-218', '115', '1405'),
('R. Aleixo Alves de Souza', '98', null, '24813-351', '116', '1406'),
('Rua Pandiá Calógeras', '997', 'Casa azul', '58101-545', '117', null),
('Rua Vereador Basílio Sautchuk', '14', null,'68904-044', '118', null),
('R. Pref. Faria Lima', '67', 'Com uma cruz na frente', '69906-119', '119', null),
('Rua Natingui', '24', null, '65093-300', '120', null);
select * from endereco;
  
CREATE TABLE IF NOT EXISTS pecas (
  cod_pecas INT NOT NULL AUTO_INCREMENT,
  nome_pecas VARCHAR(20) NOT NULL,
  valor float NOT NULL,
  PRIMARY KEY (cod_pecas))
;

INSERT INTO pecas (cod_pecas, nome_pecas, valor) VALUES 
(880, 'Bateria.', 88.00),
(881, 'Fio de Cobre', 564.22),
(882, 'fonte de som', 222.45),
(889, 'Fios', 154.21);
select * from pecas; 

CREATE TABLE IF NOT EXISTS estoque (
  cod_estoque INT NOT NULL AUTO_INCREMENT,
  qtd_estoque INT NULL DEFAULT NULL,
  data_estoque DATE NULL DEFAULT NULL,
  cod_pecas INT NULL DEFAULT NULL,
  PRIMARY KEY (cod_estoque),
  INDEX cod_pecas_idx (cod_pecas ASC) VISIBLE,
    FOREIGN KEY (cod_pecas)
    REFERENCES pecas (cod_pecas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO estoque (cod_estoque, qtd_estoque, data_estoque, cod_pecas) VALUES 
(60, '100', '2020-11-09', '880'),
(61, '100', '2020-10-15','881'),
(62, '100', '2020-01-19','882'),
(63, '100', '2020-08-29','889');
select * from estoque; 

CREATE TABLE IF NOT EXISTS funcionarios (
  cod_funcionarios INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(90) NOT NULL,
  rg VARCHAR(10) NOT NULL,
  cpf VARCHAR(15) NOT NULL,
  dt_nascimento DATE NOT NULL,
  comissao DECIMAL NULL,
  cod_cargo INT NULL,
  cod_endereco INT NULL,
  cod_cliente INT NULL,
  cod_telefone INT NULL,
  PRIMARY KEY (cod_funcionarios),
  INDEX cod_cargo_idx (cod_cargo ASC) VISIBLE,
  INDEX cod_endereco_idx (cod_endereco ASC) VISIBLE,
  INDEX cod_cliente_idx (cod_cliente ASC) VISIBLE,
  INDEX cod_telefone_idx (cod_telefone ASC) VISIBLE,
    FOREIGN KEY (cod_cargo)
    REFERENCES cargo (cod_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_endereco)
    REFERENCES endereco (cod_endereco)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_cliente)
    REFERENCES cliente (cod_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_telefone)
    REFERENCES telefone (cod_telefone)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO funcionarios (cod_funcionarios, nome, RG, CPF, dt_nascimento, cod_cargo, cod_endereco,cod_cliente, cod_telefone) VALUES 
(1236, 'Aaron Darquin', 112233, '78945612301', '2021-05-01', 400, 1, 111, 5555),
(6541, 'Abner Gastin', 223311, '98765432101', '2020-08-06', 410, 2, 112, 5556),
(6780, 'Daenil Buston', 211233, '12345678998', '2021-01-06', 420, 3, 113, 5557),
(9876, 'Gabrilla Moraes', 313212, '14725836901', '2019-02-08', 430, 4, 114, 5558),
(2468, 'Vitória Pentelho', 445566, '95126347800', '2021-01-09', 450, 5, 115, 5559),
(8642, 'Lydia Mavis', 456546, '24681379012', '2018-06-10', 460, 6, 116, 5560),
(1357, 'Nadia Santos', 665544, '9685321472', '2021-01-11', 470, 7, 117, 5561),
(9753, 'Dereck Restin', 554646, '87954621308', '2020-05-12', 480, 8, 118, 5562),
(9632, 'Scoot Mccal', 778899, '25566481378', '2021-07-13', 490, 9, 119, 5563),
(7425, 'Alisson Argent', 998877, '21325554487', '2021-11-14', 412, 10, 120, 5564),
(1123, 'Leon Silva', 887799, '75568955624', '2021-10-15', 422, null, null, null),
(3321, 'Brunno Davi', 987789, '76958425654', '2021-01-16', 432, null, null, null);
select * from funcionarios;

CREATE TABLE IF NOT EXISTS produto (
  cod_produto INT NOT NULL AUTO_INCREMENT,
  nome_produto VARCHAR(100) NULL,
  status_prod CHAR(45) NOT NULL DEFAULT 'A',
  descricao VARCHAR(500) NULL DEFAULT NULL,
  estoque_minimo INT NULL,
  estoque_maximo INT NULL,
  PRIMARY KEY (cod_produto))
ENGINE = InnoDB;

INSERT INTO produto (cod_produto, nome_produto, status_prod, descricao, estoque_minimo, estoque_maximo) VALUES 
(200, 'Dispositivos de armazenamento', 'Em falta', 'Um dispositivo de armazenamento também é conhecido como meio de armazenamento ou mídia de armazenamento', '0', '0'),
(210, 'Placa de Vídeo Geforce', 'Disponivel', 'As placas de vídeo e notebooks com GeForce RTX™ Série 20 contam com a tecnologia da arquitetura NVIDIA Turing™', '10', '100'),
(220, 'Computador Gamer', 'Em falta', 'Computador Gamer NTC Vulcano II AMD Ryzen 3 3200G, 8GB, SSD 240GB, Windows 10 Pro - VULCANO II 7102', '0', '0'),
(230, 'Notebook Lenovo', 'Disponivel', 'Ele tem tela LED antirreflexo de 15,6\\\" com resolução HD, conta processador Intel Core i5 1035G1 de 10a geração', '10', '100'),
(240, 'Monitor Lg 22 led', 'Disponivel', 'O monitor para PC 22MK400H-B da LG conta conta com uma tela LED de 21,5', '10', '100'),
(250, 'Scanner Epson WorkForce', 'Disponivel', 'Um scanner documental compacto com a velocidade, a potência e a flexibilidade para prosperar nos ambientes mais exigentes e de ritmo acelerado', '10', '100'),
(260, 'Teclado e Mouse sem fio', 'Em falta', 'Praticidade e conforto Elimine os fios da sua mesa e digite com mais conforto', '0', '0'),
(270, 'WebCam 16mp', 'Disponivel', 'Webcam 16MP Goldentec GT824 USB com Microfone e 6 LEDs - Preta Características Principais: - Microfone USB', '10', '100'),
(280, 'Roteador Wireless Archer MIMO TP-Link', 'Disponivel', 'O Archer C80 oferece Wi-Fi doméstico de alto desempenho e preço acessível, com velocidades totais de até 1900 Mbps', '10', '100'),
(290, 'Apple iPad 8ª Geração', 'Em falta', 'Este produto combina a potência e a capacidade de um computador com a versatilidade e facilidade de uso que somente um iPad pode oferecer', '0', '0'),
(300, 'Placa De Som Usb 7.1', 'Disponivel', 'A placa de som usb externa 7.1 canais é compatível com USB 2.0 Full Speed (12Mb/s), Plug-and-Play, amplia seu alto-falante ou fone de ouvido estéreo com 7.1 canais.', '10', '100'),
(310, 'PC Intel Core i5, 8GB RAM DDR', 'Disponivel', 'Processador Intel Core i5 1155, Memória DDR3 8GB, Armazenamento: HD 500GB', '10', '100'),
(320, 'Impressora HP Laser', 'Em falta', 'Obtenha um desempenho de impressão produtivo a um preço acessível e produza facilmente resultados de alta qualidade', '0', '0'),
(330, 'Refil de Tinta Epson 544 Ecotank 4 Cores', 'Disponivel', 'kit Refil Tinta com 4 Cores Original Epson T664 664 P/ L380 L200 L210 L355 L365 L395 L455 L396 K M Y C 40Ml', '10', '100'),
(340, 'Cartao de Memoria', 'Em falta', 'Cartão Memória Micro SDHC 32GB 80MBs Sandisk e ADAPT USB Velocidade leitura / transferência: até 80mb/s (320x) Classe 10', '0', '0'),
(350, 'Disco Rígido Externo Portátil de 1 TB para PC', 'Em falta', 'Este produto transfere dados através de uma porta USB 3.0, o que o torna num dispositivo extremamente rápido', '0', '0'),
(360, 'Cartucho HP 662XL Colorido', 'Disponivel', 'O cartucho de tinta 662 XL Tricolor, é compatível com as impressoras HP Deskjet Ink Advantage 2515 e HP Deskjet Ink Advantage 3515', '10', '100');
select * from produto;

CREATE TABLE IF NOT EXISTS entrada_produto (
  cod_entrada_prod INT NOT NULL AUTO_INCREMENT,
  qtde INT NULL DEFAULT NULL,
  valor_unitario DECIMAL NULL DEFAULT '0.00',
  data_entrada DATE NULL DEFAULT NULL,
  cod_produto INT NOT NULL ,
  PRIMARY KEY (cod_entrada_prod, cod_produto),
  INDEX cod_produto_idx (cod_produto ASC) VISIBLE,
    FOREIGN KEY (cod_produto)
    REFERENCES produto (cod_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO entrada_produto (cod_entrada_prod, qtde, valor_unitario, data_entrada, cod_produto) VALUES 
(1, '1', '1110.00', '2020-04-23', '210'),
(2, '2', '2568.45', '2020-05-14', '230'),
(3, '3', '6587.40', '2020-04-12', '240'),
(4, '1', '1245.11', '2020-11-29', '250'),
(5, '2', '2356.11', '2020-10-05', '270'),
(6, '3', '5468.22', '2020-03-12', '280');
select * from entrada_produto;

CREATE TABLE IF NOT EXISTS compra (
  nota_fiscal INT NOT NULL AUTO_INCREMENT,
  quantidade INT NOT NULL,
  valor_unitario DECIMAL NOT NULL,
  valor_total DECIMAL NOT NULL,
  data_compra DATE NOT NULL,
  cancelar_compras ENUM('SIM', 'NÃO') NOT NULL,
  cod_funcionarios INT NOT NULL,
  cod_pecas INT NULL,
  cod_estoque INT NULL,
  cod_produto INT NULL,
  PRIMARY KEY (nota_fiscal),
  UNIQUE INDEX cod_pecas_UNIQUE (cod_pecas ASC) VISIBLE,
  UNIQUE INDEX cod_funcionarios_UNIQUE (cod_funcionarios ASC) VISIBLE,
  INDEX fk_compra_estoque1_idx (cod_estoque ASC) VISIBLE,
  INDEX fk_compra_produto1_idx (cod_produto ASC) VISIBLE,
    FOREIGN KEY (cod_pecas)
    REFERENCES pecas (cod_pecas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_funcionarios)
    REFERENCES funcionarios (cod_funcionarios)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_estoque)
    REFERENCES estoque (cod_estoque)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_produto)
    REFERENCES produto (cod_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO compra (nota_fiscal, quantidade, valor_unitario, valor_total, data_compra, cancelar_compras, cod_funcionarios,cod_pecas, cod_estoque, cod_produto) VALUES 
(1, '1', '849.90', '849.90', '2020-01-02', 'SIM', '6541', NULL, NULL, '210'),
(2, '2', '539.55', '1079.10', '2020-02-04', 'SIM', '6780', NULL, NULL, '230'),
(3, '2', '1282.02', '2564.05', '2020-03-05', 'NÃO', '9876', NULL, NULL, '240'),
(4, '1', '143.91', '143.91', '2020-04-02', 'NÃO', '2468', NULL, NULL, '250'),
(5, '2', '1124.55', '2249.10', '2020-05-14', 'SIM', '8642', NULL, '60', '260'),
(6, '1', '1599.00', '1599.00', '2020-06-13', 'NÃO', '1357', NULL, '61', '270'),
(7, '1', '199.05', '199.05', '2020-07-02', 'NÃO', '1236', NULL, '62', '280'),
(8, '1', '129.00', '129.00', '2020-08-11', 'NÃO', '9753', '889', '63', '300'),
(9, '2', '498.27', '996.55', '2020-09-18', 'NÃO', '9632', '880', NULL, '310'),
(10, '3', '1487.69', '4463.07', '2020-10-19', 'NÃO', '7425', '881', NULL, '330'),
(11, '2', '95.26', '190.53', '2020-11-20', 'SIM', '1123', '882', NULL, '360');
select * from compra;

CREATE TABLE IF NOT EXISTS saida_produto (
  cod_exit_prod INT NOT NULL AUTO_INCREMENT,
  qtde INT NULL DEFAULT NULL,
  valor_unitario DECIMAL NULL DEFAULT '0.00',
  data_entrada DATE NULL DEFAULT NULL,
  cod_produto INT NOT NULL,
  PRIMARY KEY (cod_exit_prod, cod_produto),
  INDEX cod_produto_idx (cod_produto ASC) VISIBLE,
    FOREIGN KEY (cod_produto)
    REFERENCES produto (cod_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO saida_produto (cod_exit_prod, qtde, valor_unitario, data_entrada, cod_produto) VALUES 
(010, '1', '1110.00', '2020-04-23', '210'),
(020, '2', '2568.45', '2020-05-14', '230'),
(030, '3', '6587.40', '2020-04-12', '240'),
(040, '1', '1245.11', '2020-11-29', '250'),
(050, '2', '2356.11', '2020-10-05', '270'),
(060, '3', '5468.22', '2020-03-12', '280');
select * from saida_produto;

CREATE TABLE IF NOT EXISTS forma_pagamento (
  cod_forma_pagamento INT NOT NULL AUTO_INCREMENT,
  modo_Pagamento VARCHAR(45) NOT NULL,
  PRIMARY KEY (cod_forma_pagamento))
;

INSERT INTO forma_pagamento (cod_forma_pagamento, modo_Pagamento) VALUES 
('888', 'Credito'),
('999', 'Debito'),
('777', 'Pix'),
('666', 'Boleto'),
('555', 'Dinheiro');

CREATE TABLE IF NOT EXISTS RL_pagar_compra (
  nota_fiscal INT NOT NULL,
  cod_forma_pagamento INT NOT NULL,
  Valor_final DECIMAL NOT NULL,
  PRIMARY KEY (nota_fiscal, cod_forma_pagamento),
  INDEX fk_compra_has_forma_pagamento_forma_pagamento1_idx (cod_forma_pagamento ASC) VISIBLE,
  INDEX fk_compra_has_forma_pagamento_compra1_idx (nota_fiscal ASC) VISIBLE,
    FOREIGN KEY (nota_fiscal)
    REFERENCES compra (nota_fiscal)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_forma_pagamento)
    REFERENCES forma_pagamento (cod_forma_pagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

select * from RL_pagar_compra;
INSERT INTO RL_pagar_compra (nota_fiscal, cod_forma_pagamento, Valor_final) VALUES 
('1', '999', '1110.00'),
('2', '888', '2568.45'),
('3', '777', '6587.40'),
('4', '666', '1245.11'),
('5', '777', '2356.11'),
('6', '666', '5468.22');

CREATE TABLE IF NOT EXISTS servico (
  cod_servico INT NOT NULL AUTO_INCREMENT,
  Atividades_prestadas TEXT NOT NULL,
  tempo_gasto TIME NULL DEFAULT NULL,
  data_entrega DATETIME NOT NULL,
  cod_funcionarios INT NOT NULL,
  cod_cliente INT NOT NULL,
  cod_pecas INT NULL,
  PRIMARY KEY (cod_servico),
  INDEX fk_servico_funcionarios1_idx (cod_funcionarios ASC) VISIBLE,
  INDEX fk_servico_cliente1_idx (cod_cliente ASC) VISIBLE,
  INDEX fk_servico_pecas1_idx (cod_pecas ASC) VISIBLE,
    FOREIGN KEY (cod_funcionarios)
    REFERENCES funcionarios (cod_funcionarios)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_cliente)
    REFERENCES cliente (cod_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_pecas)
    REFERENCES pecas (cod_pecas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

select * from servico;
INSERT INTO servico (cod_servico, Atividades_prestadas, tempo_gasto, data_entrega, cod_funcionarios, cod_cliente, cod_pecas) VALUES 
('40', 'Consertando a rede de wifi', '02:00:00', '2021-02-10', '1236', '111', '880'),
('41', 'Conserto de som', '05:00:00', '2021-02-15', '6541', '112', NULL),
('42', 'Montagem de acessorios em celular', '00:30:00', '2021-02-12', '6780', '113', '881'),
('43', 'Montagem do roteador', '01:00:00', '2021-02-20', '9876', '114', '882'),
('44', 'Conserto de placa mae', '04:00:00', '2021-02-22', '2468', '115', NULL),
('45', 'Montagem de computador', '06:00:00', '2021-02-27', '8642', '116', '889');

CREATE TABLE IF NOT EXISTS RL_categorias_produto (
  cod_categoria INT NOT NULL,
  cod_produto INT NOT NULL,
  PRIMARY KEY (cod_categoria, cod_produto),
  INDEX fk_categoria_has_produto_produto1_idx (cod_produto ASC) VISIBLE,
  INDEX fk_categoria_has_produto_categorias1_idx (cod_categoria ASC) VISIBLE,
    FOREIGN KEY (cod_categoria)
    REFERENCES categorias (cod_categoria)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_produto)
    REFERENCES produto (cod_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

INSERT INTO RL_categorias_produto (cod_categoria, cod_produto) VALUES 
('310', '200'),
('320', '210'),
('330', '220'),
('340', '230'),
('350', '240'),
('360', '250'),
('370', '260'),
('310', '270'),
('320', '280'),
('330', '290'),
('340', '300'),
('350', '310'),
('360', '320'),
('370', '330'),
('310', '340'),
('320', '350'),
('340', '360');
select * from RL_categorias_produto;

CREATE TABLE IF NOT EXISTS RL_pagar_servico (
  cod_servico INT NOT NULL,
  cod_forma_pagamento INT NOT NULL,
  PRIMARY KEY (cod_servico, cod_forma_pagamento),
  INDEX fk_servico_has_forma_pagamento_forma_pagamento1_idx (cod_forma_pagamento ASC) VISIBLE,
  INDEX fk_servico_has_forma_pagamento_servico1_idx (cod_servico ASC) VISIBLE,
    FOREIGN KEY (cod_servico)
    REFERENCES servico (cod_servico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_forma_pagamento)
    REFERENCES forma_pagamento (cod_forma_pagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO RL_pagar_servico (cod_servico, cod_forma_pagamento) VALUES 
(40, 888),
(41, 999),
(42, 777),
(43, 666),
(44, 555),
(45, 888);
select * from RL_pagar_servico;

CREATE TABLE IF NOT EXISTS defeito (
  cod_defeito INT NOT NULL,
  descricao VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (cod_defeito));

INSERT INTO defeito (cod_defeito, descricao) VALUES 
('12', 'O cabo de rede do wifi não estava funcionando e precisava ser trocado e configurado'),
('22', 'O sistema de audio estava queimado'),
('32', NULL),
('42', NULL),
('52', 'Placa mãe estava queimada'),
('62', NULL);
select * from defeito;

CREATE TABLE IF NOT EXISTS RL_servico_defeito (
  cod_servico INT NOT NULL,
  cod_defeito INT NOT NULL,
  PRIMARY KEY (cod_servico, cod_defeito),
  INDEX fk_servico_has_defeito_defeito1_idx (cod_defeito ASC) VISIBLE,
  INDEX fk_servico_has_defeito_servico1_idx (cod_servico ASC) VISIBLE,
    FOREIGN KEY (cod_servico)
    REFERENCES servico (cod_servico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (cod_defeito)
    REFERENCES defeito (cod_defeito)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO RL_servico_defeito (cod_defeito, cod_servico) VALUES 
('12', '45'),
('22', '40'),
('32', '41'),
('42', '42'),
('52', '43'),
('62', '44');
select * from RL_servico_defeito;



