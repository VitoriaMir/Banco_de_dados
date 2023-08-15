CREATE SCHEMA IF NOT EXISTS trabalho;
USE trabalho;

-- -----------------------------------------------------
-- Table cargo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cargo (
  idCARGO INT NOT NULL,
  nome_cargo VARCHAR(100) NOT NULL,
  salario FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (idCARGO));

-- -----------------------------------------------------
-- Table categorias
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS categorias (
  idCATEGORIAS INT NOT NULL,
  divisão_produto VARCHAR(45) NOT NULL,
  PRIMARY KEY (idCATEGORIAS));

-- -----------------------------------------------------
-- Table estado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS estado (
  idESTADO INT NOT NULL,
  nome_estado VARCHAR(60) NOT NULL,
  sigla VARCHAR(2) NOT NULL,
  PRIMARY KEY (idESTADO));

-- -----------------------------------------------------
-- Table cidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cidade (
  idCIDADE INT NOT NULL,
  nome_cidade VARCHAR(60) NOT NULL,
  idESTADO INT NOT NULL,
  PRIMARY KEY (idCIDADE),
  INDEX fk_CIDADE_ESTADO1_idx (idESTADO ASC) ,
  CONSTRAINT idESTADO
    FOREIGN KEY (idESTADO)
    REFERENCES estado (idESTADO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS telefone (
  idTELEFONE INT NOT NULL,
  DDD VARCHAR(2) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  PRIMARY KEY (idTELEFONE));

-- -----------------------------------------------------
-- Table cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente (
  idCLIENTE INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(200) NOT NULL,
  cpf VARCHAR(14) NOT NULL,
  email VARCHAR(90) NULL,
  idTELEFONE INT NULL,
  PRIMARY KEY (idCLIENTE),
  INDEX fk_cliente_telefone1_idx (idTELEFONE ASC) ,
  CONSTRAINT fk_cliente_telefone1
    FOREIGN KEY (idTELEFONE)
    REFERENCES telefone (idTELEFONE)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table compras
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS compras (
  idCOMPRAS INT NOT NULL,
  cancelar_compras ENUM('SIM', 'NÃO') NOT NULL,
  idCLIENTE INT NOT NULL,
  PRIMARY KEY (idCOMPRAS),
  INDEX fk_COMPRAS_CLIENTE1_idx (idCLIENTE ASC) ,
  CONSTRAINT idCLIENTE
    FOREIGN KEY (idCLIENTE)
    REFERENCES cliente (idCLIENTE)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS servico (
  idservico INT NOT NULL,
  Atividades_prestadas TEXT NOT NULL,
  responsavel_conserto VARCHAR(45) NOT NULL,
  tempo_gasto TIME NULL DEFAULT NULL,
  data_entrega DATE NOT NULL,
  idCLIENTE INT NOT NULL,
  PRIMARY KEY (idservico),
  INDEX fk_servico_CLIENTE_idx (idCLIENTE ASC) ,
    FOREIGN KEY (idCLIENTE)
    REFERENCES cliente (idCLIENTE)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table defeito
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS defeito (
  idDEFEITO INT NOT NULL,
  descricao_defeito VARCHAR(200) NULL DEFAULT NULL,
  idservico INT NOT NULL,
  PRIMARY KEY (idDEFEITO, idservico),
  INDEX fk_DEFEITO_servico1_idx (idservico ASC) ,
    FOREIGN KEY (idservico)
    REFERENCES servico (idservico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table produtos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS produtos (
  idPRODUTOS INT NOT NULL,
  nome_produto VARCHAR(60) NOT NULL,
  Quantidade_estoqe INT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (idPRODUTOS));

-- -----------------------------------------------------
-- Table detalhes_produtos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS detalhes_produtos (
  idDETALHES_PRODUTOS INT NOT NULL,
  descricao_detalhes VARCHAR(400) NOT NULL,
  idPRODUTOS INT NOT NULL,
  PRIMARY KEY (idDETALHES_PRODUTOS),
  INDEX fk_DETALHES_PRODUTOS_PRODUTOS1_idx (idPRODUTOS ASC) ,
    FOREIGN KEY (idPRODUTOS)
    REFERENCES produtos (idPRODUTOS)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table endereco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS endereco (
  idendereco INT NOT NULL,
  rua VARCHAR(60) NOT NULL,
  numero_casa INT NOT NULL,
  complemento VARCHAR(45) NULL DEFAULT NULL,
  referencia VARCHAR(45) NULL DEFAULT NULL,
  idCLIENTE INT NOT NULL,
  idCIDADE INT NOT NULL,
  CEP VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (idendereco, idCLIENTE),
  INDEX fk_endereco_CLIENTE1_idx (idCLIENTE ASC) ,
  INDEX fk_endereco_CIDADE1_idx (idCIDADE ASC) ,
  INDEX fk_endereco_LOJA_COMPUTADOR1_idx (CEP ASC) ,
    FOREIGN KEY (idCIDADE)
    REFERENCES cidade (idCIDADE)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idCLIENTE)
    REFERENCES cliente (idCLIENTE)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table forma_pagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS forma_pagamento (
  idFORMA_PAGAMENTO INT NOT NULL,
  modo_Pagamento VARCHAR(50) NOT NULL,
  PRIMARY KEY (idFORMA_PAGAMENTO));

-- -----------------------------------------------------
-- Table funcionarios
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS funcionarios (
  Matricula INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  RG INT NOT NULL,
  CPF VARCHAR(16) NOT NULL,
  Data_nascimento DATE NOT NULL,
  idCARGO INT NULL DEFAULT NULL,
  idendereco INT NULL DEFAULT NULL,
  idCLIENTE INT NULL DEFAULT NULL,
  PRIMARY KEY (Matricula),
  INDEX fk_FUNCIONARIOS_CARGO1_idx (idCARGO ASC) ,
  INDEX fk_FUNCIONARIOS_endereco1_idx (idendereco ASC, idCLIENTE ASC) ,
  INDEX idCLIENTE_idx (idCLIENTE ASC) ,
    FOREIGN KEY (idCARGO)
    REFERENCES cargo (idCARGO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idendereco)
    REFERENCES endereco (idendereco)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idCLIENTE)
    REFERENCES cliente (idCLIENTE)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table item
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS item (
  idITEM INT NOT NULL,
  quantidade INT NOT NULL,
  preco_final DECIMAL(65,2) NOT NULL,
  idCOMPRAS INT NOT NULL,
  idservico INT NOT NULL,
  idPRODUTOS INT NOT NULL,
  PRIMARY KEY (idITEM),
  INDEX fk_ITEM_COMPRAS1_idx (idCOMPRAS ASC) ,
  INDEX fk_ITEM_servico1_idx (idservico ASC) ,
  INDEX fk_ITEM_PRODUTOS1_idx (idPRODUTOS ASC) ,
    FOREIGN KEY (idPRODUTOS)
    REFERENCES produtos (idPRODUTOS),
    FOREIGN KEY (idservico)
    REFERENCES servico (idservico),
    FOREIGN KEY (idCOMPRAS)
    REFERENCES compras (idCOMPRAS)); 

-- -----------------------------------------------------
-- Table nota_fiscal
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS nota_fiscal (
  idNOTA_FISCAL INT NOT NULL,
  Data_emissao DATETIME NOT NULL,
  idservico INT NOT NULL,
  idCOMPRAS INT NOT NULL,
  PRIMARY KEY (idNOTA_FISCAL),
  INDEX fk_NOTA_FISCAL_servico1_idx (idservico ASC) ,
  INDEX fk_NOTA_FISCAL_COMPRAS1_idx (idCOMPRAS ASC) ,
    FOREIGN KEY (idservico)
    REFERENCES servico (idservico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idCOMPRAS)
    REFERENCES compras (idCOMPRAS)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table pecas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pecas (
  idPecas INT NOT NULL,
  nome_peca VARCHAR(60) NOT NULL,
  PRIMARY KEY (idPecas));

-- -----------------------------------------------------
-- Table relaçao_pagar
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rl_pagar (
  idrl_pagar INT NOT NULL,
  Valor_final DECIMAL(65,2) NOT NULL,
  idFORMA_PAGAMENTO INT NOT NULL,
  idCOMPRAS INT NOT NULL,
  idservico INT NOT NULL,
  PRIMARY KEY (idrl_pagar, idFORMA_PAGAMENTO, idCOMPRAS, idservico),
  INDEX fk_RELAÇAO_PAGAR_FORMA_PAGAMENTO1_idx (idFORMA_PAGAMENTO ASC) ,
  INDEX fk_RELAÇAO_PAGAR_COMPRAS1_idx (idCOMPRAS ASC) ,
  INDEX fk_RELAÇAO_PAGAR_servico1_idx (idservico ASC) ,
    FOREIGN KEY (idCOMPRAS)
    REFERENCES compras (idCOMPRAS)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idFORMA_PAGAMENTO)
    REFERENCES forma_pagamento (idFORMA_PAGAMENTO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idservico)
    REFERENCES servico (idservico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table rl_categ
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rl_categ (
  idPRODUTOS INT NOT NULL,
  idCATEGORIAS INT NOT NULL,
  PRIMARY KEY (idPRODUTOS, idCATEGORIAS),
  INDEX fk_rl_categ_CATEGORIAS1_idx (idCATEGORIAS ASC) ,
    FOREIGN KEY (idPRODUTOS)
    REFERENCES produtos (idPRODUTOS)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idCATEGORIAS)
    REFERENCES categorias (idCATEGORIAS)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table rl_defeito_conserto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rl_defeito_conserto (
  idrl_defeito_conserto INT NOT NULL,
  idDEFEITO INT NOT NULL,
  idservico INT NOT NULL,
  idPecas INT NULL DEFAULT NULL,
  PRIMARY KEY (idrl_defeito_conserto),
  INDEX fk_rl_defeito_conserto_DEFEITO1_idx (idDEFEITO ASC, idservico ASC) ,
  INDEX fk_rl_defeito_conserto_Pecas1_idx (idPecas ASC) ,
  INDEX idservico_idx (idservico ASC) ,
    FOREIGN KEY (idDEFEITO)
    REFERENCES defeito (idDEFEITO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idservico)
    REFERENCES servico (idservico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idPecas)
    REFERENCES pecas (idPecas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


INSERT INTO cargo (idCARGO, nome_cargo, salario) VALUES
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

INSERT INTO categorias (idCATEGORIAS, divisão_produto) VALUES 
('310', 'Computadores Desktop'),
('320', 'Memória e Armazenamento'),
('330', 'Dispositivos de Conexão em Rede'),
('340', 'Monitores'),
('350', 'Impressoras e Acessórios'),
('360', 'Peças e Componentes para Computador'),
('370', 'Acessórios para Computadores');


INSERT INTO telefone (idTELEFONE, DDD, numero) VALUES 
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

INSERT INTO cliente (idCLIENTE, nome, cpf, email, idTELEFONE) VALUES 
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

INSERT INTO compras (idCOMPRAS, cancelar_compras, idCLIENTE) VALUES 
('1', 'SIM', 111),
('2', 'NÃO', 112),
('3', 'SIM', 113),
('4', 'SIM', 114),
('5', 'SIM', 115),
('6', 'NÃO', 116),
('7', 'SIM', 117),
('8', 'NÃO', 118),
('9', 'SIM', 119),
('10', 'NÃO', 120);

INSERT INTO servico (idservico, Atividades_prestadas, responsavel_conserto, tempo_gasto, data_entrega, idCLIENTE) VALUES 
(10, 'Consertando a rede de wifi', 'Gabriel', '02:00:00', '2020-08-02', 111),
(11, 'Conserto de som', 'Rafael', '05:00:00', '2021-04-03', 112),
(21, 'Montagem de acessorios em celular', 'Rafael', '00:30:00', '2020-05-04', 113),
(31, 'Montagem do roteador', 'Monica', '01:00:00', '2019-04-05', 114),
(41, 'Conserto de placa mae', 'Gabriel', '04:00:00', '2021-02-06', 115),
(51, 'Montagem de computador', 'Paulo Andre', '06:00:00', '2020-10-07', 116);

INSERT INTO defeito (idDEFEITO, descricao_defeito, idservico) VALUES 
('12', 'O cabo de rede do wifi não estava funcionando e precisava ser trocado e configurado', '10'),
('22', 'O sistema de audio estava queimado', '11'),
('32', NULL, '21'),
('42', NULL, '31'),
('52', 'Placa mãe estava queimada', '41'),
('62', NULL, '51');

INSERT INTO estado (idESTADO, nome_estado, sigla) VALUES ('1500', 'MINAS GERAIS', 'MG'),
('1510', 'SÃO PAULO', 'SP'),
('1520', 'RIO DE JANEIRO', 'RJ'),
('1530', 'DISTRITO FEDERAL', 'DF'),
('1540', 'ACRE', 'AC'),
('1550', 'BAHIA', 'BA');

INSERT INTO CIDADE (idCIDADE, nome_cidade, idESTADO) VALUES 
('1401', 'Belo Horizonte', '1500'),
('1402', 'São Paulo', '1510'),
('1403', 'Rio de Janeiro', '1520'),
('1404', 'Brasilia', '1530'),
('1405', 'Rio Branco', '1540'),
('1406', 'Salvador', '1550');

INSERT INTO forma_pagamento (idFORMA_PAGAMENTO, modo_Pagamento) VALUES 
('888', 'Credito'),
('999', 'Debito'),
('777', 'Pix'),
('666', 'Boleto');

INSERT INTO endereco (idendereco, rua, numero_casa, complemento, referencia, idCLIENTE, idCIDADE, CEP) VALUES 
(503, 'Rua Araranguá', 24, null, null, 111, 1401, 7310307300),
(513, 'Rua Brusque', 75, null, null, 112, 1402, 8627432966),
(523, 'Av. Visconde de Guarapuava', 32, null, 'No final da rua, porta verde', 113, 1403, 0767887974),
(533, 'R. Souza Naves', 15, null, 'A maior casa da rua', 114, 1404, 6436732634),
(543, 'Rua Ermelino de Leão', 16, null, null, 115, 1405, 9629819233),
(553, 'R. Aleixo Alves de Souza', 96, null, 'Com uma cruz na frente', 116, 1406, 1314061943),
(563, 'Rua Pandiá Calógeras', 112, null, 'Casa azul', 117, 1403, 1462671180),
(573, 'Rua Vereador Basílio Sautchuk', 255, null, null, 118, 1406, 1795343364),
(583, 'R. Pref. Faria Lima', 1414, null, 'A casa com grafite', 119, 1404, 9702262063),
(593, 'Rua Natingui', 3333, null, null, 120, 1401, 3028868584);

INSERT INTO funcionarios (Matricula, nome, RG, CPF, Data_nascimento, idCARGO, idendereco,idCLIENTE) VALUES 
(123456, 'Aaron Darquin', 112233, '78945612301', '2021-05-01', 400, 503, 111),
(654321, 'Abner Gastin', 223311, '98765432101', '2020-08-06',410,513,112),
(67890, 'Daenil Buston', 211233, '12345678998', '2021-01-06',420,523,113),
(9876, 'Gabrilla Moraes', 313212, '14725836901', '2019-02-08', 430, 533, 114),
(2468, 'Vitória Pentelho', 445566, '95126347800', '2021-01-09', 450, 543, 115),
(86420, 'Lydia Mavis', 456546, '24681379012', '2018-06-10', 460, 553, 116),
(13579, 'Nadia Santos', 665544, '9685321472', '2021-01-11', 470, 563, 117),
(97531, 'Dereck Restin', 554646, '87954621308', '2020-05-12', 480, 573, 118),
(96325, 'Scoot Mccal', 778899, '25566481378', '2021-07-13', 490, 583, 119),
(74125, 'Alisson Argent', 998877, '21325554487', '2021-11-14', 412, 593, 120),
(11223, 'Leon Silva', 887799, '75568955624', '2021-10-15', 422, null, null),
(33221, 'Brunno Davi', 987789, '76958425654', '2021-01-16', 432, null, null);

INSERT INTO nota_fiscal (idNOTA_FISCAL, Data_emissao, idservico, idCOMPRAS) VALUES 
(7774, '2020-05-02', 10, 1),
(7775, '2021-04-03', 11, 2),
(7776, '2020-05-04', 21, 3),
(7778, '2019-04-05', 31, 4),
(7779, '2021-02-06', 41, 5),
(7780, '2020-10-07', 51, 6);

INSERT INTO pecas (idPecas, nome_peca) VALUES 
(880, 'Bateria.'),
(881, 'Fio de Cobre'),
(882, 'fonte de som'),
(889, 'Fios');

INSERT INTO produtos (idPRODUTOS, nome_produto, Quantidade_estoqe, preco) VALUES 
(200, 'Dispositivos de armazenamento ', '100', '150.96'),
(210, 'Placa de Vídeo Geforce ', '100', '2588.22'),
(220, 'Computador Gamer', '100', '7099.00'),
(230, 'Notebook Lenovo', '100', '2469.08'),
(240, 'Monitor Lg 22 led', '100', '1449.00'),
(250, 'Scanner Epson WorkForce', '100', '1256.02'),
(260, 'Teclado e Mouse sem fio', '100', '256.98'),
(270, 'WebCam 16mp', '100', '350.53'),
(280, 'Roteador Wireless Archer MIMO TP-Link', '100', '390.03'),
(290, 'Apple iPad 8ª Geração 10.2', '100', '2888.99'),
(201, 'Placa De Som Usb 7.1 ', '100', '21.9'),
(211, 'PC Intel Core i5, 8GB RAM DDR', '100', '1715.10'),
(221, 'Impressora HP Laser ', '100', '999'),
(231, 'Refil de Tinta Epson 544 Ecotank 4 Cores', '100', '169'),
(241, 'Cartao de Memoria ', '100', '79.9'),
(251, 'Disco Rígido Externo Portátil de 1 TB para PC', '100', '334.99'),
(261, 'Cartucho HP 662XL Colorido', '100', '105.9');

INSERT INTO detalhes_produtos (idDETALHES_PRODUTOS, descricao_detalhes, idPRODUTOS) VALUES 
(2001, 'Um dispositivo de armazenamento também é conhecido como meio de armazenamento ou mídia de armazenamento.', 200),
(2101, 'As placas de vídeo e notebooks com GeForce RTX™ Série 20 contam com a tecnologia da arquitetura NVIDIA Turing™.', 210),
(2201, 'Computador Gamer NTC Vulcano II AMD Ryzen 3 3200G, 8GB, SSD 240GB, Windows 10 Pro - VULCANO II 7102', 220),
(2301, 'Ele tem tela LED antirreflexo de 15,6\" com resolução HD, conta processador Intel Core i5 1035G1 de 10a geração.', 230),
(2401, 'O monitor para PC 22MK400H-B da LG conta conta com uma tela LED de 21,5\". ', 240),
(2501, 'Um scanner documental compacto com a velocidade, a potência e a flexibilidade para prosperar nos ambientes mais exigentes e de ritmo acelerado.', 250),
(2601, 'Praticidade e conforto Elimine os fios da sua mesa e digite com mais conforto.', 260),
(2701, 'Webcam 16MP Goldentec GT824 USB com Microfone e 6 LEDs - Preta Características Principais: - Microfone USB;', 270),
(2801, 'O Archer C80 oferece Wi-Fi doméstico de alto desempenho e preço acessível, com velocidades totais de até 1900 Mbps. ', 280),
(2901, 'Este produto combina a potência e a capacidade de um computador com a versatilidade e facilidade de uso que somente um iPad pode oferecer. ', 290),
(2011, 'A placa de som usb externa 7.1 canais é compatível com USB 2.0 Full Speed (12Mb/s), Plug-and-Play, amplia seu alto-falante ou fone de ouvido estéreo com 7.1 canais.', 201),
(2111, 'Processador Intel Core i5 1155, Memória DDR3 8GB, Armazenamento: HD 500GB', 211),
(2211, 'Obtenha um desempenho de impressão produtivo a um preço acessível e produza facilmente resultados de alta qualidade.', 221),
(2311, 'kit Refil Tinta com 4 Cores Original Epson T664 664 P/ L380 L200 L210 L355 L365 L395 L455 L396 K M Y C 40Ml', 231),
(2411, 'Cartão Memória Micro SDHC 32GB 80MBs Sandisk e ADAPT USB Velocidade leitura / transferência: até 80mb/s (320x) Classe 10 .', 241),
(2511, 'Este produto transfere dados através de uma porta USB 3.0, o que o torna num dispositivo extremamente rápido.', 251),
(2611, 'O cartucho de tinta 662 XL Tricolor, é compatível com as impressoras HP Deskjet Ink Advantage 2515 e HP Deskjet Ink Advantage 3515.', 261);

INSERT INTO item (idITEM, quantidade, preco_final, idCOMPRAS, idservico, idPRODUTOS) VALUES 
(700, '10', '1509.6', 1, 10, 200),
(705, '5', '1294.11', 2, 11, 210),
(710, '4', '2839.6', 3, 21, 220),
(715, '1', '2469.08', 4, 31, 230),
(720, '8', '1159.2', 5, 41, 240),
(725, '7', '8792.14', 6, 51, 250);

select * from forma_pagamento;
INSERT INTO rl_pagar (idrl_pagar, Valor_final, idFORMA_PAGAMENTO, idCOMPRAS, idservico) VALUES 
(900, '1509.6', 888, 1, 10),
(901, '1294.11', 999, 2, 11),
(903, '2839.6', 777, 3, 21),
(904, '2469.08', 666, 4, 31),
(905, '1159.2', 777, 5, 41),
(906, '8792.14', 888, 6, 51);

INSERT INTO rl_categ (idPRODUTOS, idCATEGORIAS) VALUES 
('200', '320'),
('210', '370'),
('220', '310'),
('230', '310'),
('240', '340'),
('250', '350'),
('260', '370'),
('270', '370'),
('280', '330'),
('290', '310'),
('201', '370'),
('211', '310'),
('221', '350'),
('231', '350'),
('241', '320'),
('251', '320'),
('261', '350');

INSERT INTO rl_defeito_conserto (idrl_defeito_conserto, idDEFEITO, idservico, idPecas) VALUES 
(4444, 12, 10, 881),
(4440, 22, 11, 882),
(4441, 32, 21, null),
(4442, 42, 31, 881),
(4443, 52, 41, 880),
(4445, 62, 51, null);