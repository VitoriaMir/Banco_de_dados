select * from cargo;
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

select * from categorias;
INSERT INTO categorias (cod_categorias, divisao_produto) VALUES 
('310', 'Computadores Desktop'),
('320', 'Memória e Armazenamento'),
('330', 'Dispositivos de Conexão em Rede'),
('340', 'Monitores'),
('350', 'Impressoras e Acessórios'),
('360', 'Peças e Componentes para Computador'),
('370', 'Acessórios para Computadores');

select * from telefone;
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

select * from cliente;
INSERT INTO cliente (cod_cliente, nome, cpf, email, cod_telefone) VALUES 
('111', 'Ana Paula', '1', '@', '5555'),
('112', 'Gabriel', '2', '@', '5556'),
('113', 'Daniel', '3', '@', '5557'),
('114', 'Anastacia', '4', '@', '5558'),
('115', 'Paulo', '5', '@', '5559'),
('116', 'Caroline', '6', '@', '5560'),
('117', 'Davi', '7', '@', '5561'),
('118', 'Joao Pedro', '8', '@', '5562'),
('119', 'Matheus', '9', '@', '5563'),
('120', 'Debora', '10', '@', '5564');

select * from produto;
INSERT INTO produto (status_prod, descricao, estoque_minimo, estoque_maximo) VALUES 
('Disponivel', '\'Dispositivos de armazenamento \'', '1', '100'),
('Em falta', 'Placa de Vídeo Geforce', '1', '100'),
('Disponivel', 'Computador Gamer', '1', '100'),
('Disponivel', 'Notebook Lenovo', '1', '100'),
('Disponivel', 'Monitor Lg 22 led', '1', '100'),
('Em falta', 'Scanner Epson WorkForce', '1', '100'),
('Disponivel', 'Teclado e Mouse sem fio', '1', '100'),
('Disponivel', 'WebCam 16mp', '1', '100'),
('Disponivel', 'Roteador Wireless Archer MIMO TP-Link', '1', '100'),
('Em falta', 'Apple iPad 8ª Geração', '1', '100'),
('Disponivel', 'Placa De Som', '1', '100'),
('Em falta', 'PC Intel Core i5', '1', '100'),
('Disponivel', 'Impressora HP Laser', '1', '100'),
('Disponivel', 'Refil de Tinta Epson', '1', '100'),
('Disponivel', 'Cartao de Memoria', '1', '100'),
('Em falta', 'Disco Rígido Externo', '1', '100'),
('Disponivel', 'Cartucho HP', '1', '100');

select * from pecas;
INSERT INTO pecas (cod_pecas, descricao, valor) VALUES 
('30', 'Bateria', '80.00'),
('31', 'Fio de Cobre', '127.09'),
('32', 'fonte de som', '398.25'),
('34', 'Fios', '548.00');


desc estoque;
select * from estoque;
INSERT INTO estoque (cod_estoque, qtd_estoque, data_estoque, cod_pecas) VALUES 
('20', '100', '2020-11-03', '30'),
('21', '100', '2020-11-03', '31'),
('22', '100', '2020-11-03', '32'),
('25', '20', '2020-11-03', '34');


INSERT INTO estado (cod_estado, nome_estado, sigla) VALUES ('1500', 'MINAS GERAIS', 'MG'),
('1510', 'SÃO PAULO', 'SP'),
('1520', 'RIO DE JANEIRO', 'RJ'),
('1530', 'DISTRITO FEDERAL', 'DF'),
('1540', 'ACRE', 'AC'),
('1550', 'BAHIA', 'BA');


INSERT INTO cidade (cod_cidade, nome_cidade, cod_estado) VALUES 
('1401', 'Belo Horizonte', '1500'),
('1402', 'São Paulo', '1510'),
('1403', 'Rio de Janeiro', '1520'),
('1404', 'Brasilia', '1530'),
('1405', 'Rio Branco', '1540'),
('1406', 'Salvador', '1550');

select * from endereco;
INSERT INTO endereco (cod_endereco, rua, numero_casa, complemento,referencia, CEP, cod_cliente, cod_cidade ) VALUES 
(503, 'Rua Araranguá', 24, null, null,7310307300, 111, 1401 ),
(513, 'Rua Brusque', 75, null, null,8627432966, 112, 1402 ),
(523, 'Av. Visconde de Guarapuava', 32, null, 'No final da rua, porta verde',0767887974, 113, 1403 ),
(533, 'R. Souza Naves', 15, null, 'A maior casa da rua',6436732634, 114, 1404 ),
(543, 'Rua Ermelino de Leão', 16, null, null,9629819233, 115, 1405 ),
(553, 'R. Aleixo Alves de Souza', 96, null, 'Com uma cruz na frente',1314061943, 116, 1406 ),
(563, 'Rua Pandiá Calógeras', 112, null, 'Casa azul',1462671180, 117, 1403),
(573, 'Rua Vereador Basílio Sautchuk', 255, null, null,1795343364, 118, 1406 ),
(583, 'R. Pref. Faria Lima', 1414, null, 'A casa com grafite',9702262063, 119, 1404 ),
(593, 'Rua Natingui', 3333, null, null,3028868584, 120, 1401 );

select * from funcionarios;
INSERT INTO funcionarios (Matricula, nome, RG, CPF, Data_nascimento, idcargo, idendereco,idcliente) VALUES 
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

select * from compra;
INSERT INTO compras (idcompras, cancelar_compras, idcliente) VALUES 
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

select * from servico;
INSERT INTO servico (idservico, Atividades_prestadas, responsavel_conserto, tempo_gasto, data_entrega, idcliente) VALUES 
(10, 'Consertando a rede de wifi', 'Gabriel', '02:00:00', '2020-08-02', 111),
(11, 'Conserto de som', 'Rafael', '05:00:00', '2021-04-03', 112),
(21, 'Montagem de acessorios em celular', 'Rafael', '00:30:00', '2020-05-04', 113),
(31, 'Montagem do roteador', 'Monica', '01:00:00', '2019-04-05', 114),
(41, 'Conserto de placa mae', 'Gabriel', '04:00:00', '2021-02-06', 115),
(51, 'Montagem de computador', 'Paulo Andre', '06:00:00', '2020-10-07', 116);

select * from defeito;
INSERT INTO defeito (iddefeito, descricao_defeito, idservico) VALUES 
('12', 'O cabo de rede do wifi não estava funcionando e precisava ser trocado e configurado', '10'),
('22', 'O sistema de audio estava queimado', '11'),
('32', NULL, '21'),
('42', NULL, '31'),
('52', 'Placa mãe estava queimada', '41'),
('62', NULL, '51');



select * from detalhes_produtos;
INSERT INTO detalhes_produtos (iddetalhes_produtos, descricao_detalhes, idprodutos) VALUES 
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



INSERT INTO forma_pagamento (idforma_pagamento, modo_Pagamento) VALUES 
('888', 'Credito'),
('999', 'Debito'),
('777', 'Pix'),
('666', 'Boleto');




INSERT INTO item (iditem, quantidade, preco_final, idcompras, idservico, idprodutos) VALUES 
(700, '10', '1509.6', 1, 10, 200),
(705, '5', '1294.11', 2, 11, 210),
(710, '4', '2839.6', 3, 21, 220),
(715, '1', '2469.08', 4, 31, 230),
(720, '8', '1159.2', 5, 41, 240),
(725, '7', '8792.14', 6, 51, 250);

INSERT INTO nota_fiscal (idnota_fiscal, Data_emissao, idservico, idcompras) VALUES 
(7774, '2020-05-02', 10, 1),
(7775, '2021-04-03', 11, 2),
(7776, '2020-05-04', 21, 3),
(7778, '2019-04-05', 31, 4),
(7779, '2021-02-06', 41, 5),
(7780, '2020-10-07', 51, 6);


select * from rl_pagar;
INSERT INTO rl_pagar (idrl_pagar,Valor_final, idforma_pagamento, idcompras, idservico) VALUES 
(900, '1509.6', 888, 1, 10),
(901, '1294.11', 999, 2, 11),
(903, '2839.6', 777, 3, 21),
(904, '2469.08', 666, 4, 31),
(905, '1159.2', 777, 5, 41),
(906, '8792.14', 888, 6, 51);

INSERT INTO rl_categ (idprodutos, idcategorias) VALUES 
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

INSERT INTO rl_defeito_conserto (idrl_defeito_conserto, iddefeito, idservico, idPecas) VALUES 
(4444, 12, 10, 881),
(4440, 22, 11, 882),
(4441, 32, 21, null),
(4442, 42, 31, 881),
(4443, 52, 41, 880),
(4445, 62, 51, null);

INSERT INTO telefone (idtelefone, DDD, numero, idcliente) VALUES 
(5555, '31', '992168551', 111),
(5556, '11', '985526558', 112),
(5557, '21', '993756720', 113),
(5558, '61', '975069176', 114),
(5559, '68', '997237070', 115),
(5560, '71', '9340910141', 116),
(5561, '21', '9307800444', 117),
(5562, '71', '9728867750', 118),
(5563, '61', '9834449860', 119),
(5564, '31', '9726384170', 120);