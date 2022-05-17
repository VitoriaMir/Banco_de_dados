/* 1 – Criar um banco de dados em MYSQL com o nome TEMPLATE */
create database TEMPLATE;

/* 2 – Usar o comando para colocar o banco de dados TEMPLATE em uso. */
use TEMPLATE;

/* 3 – Criar a tabela abaixo: */
create table tabCategorias
	(
		codigo_cat int primary key auto_increment,
		descricao_cat varchar(80) not null
	);

/* ALTERAR NOME DA TABELA CHAVE PRIMÁRIA OU NÃO */
alter table tabCategorias
	change descricao_cat descricao_cat varchar(80) not null;

alter table tabCategorias
	drop primary key;

alter table tabCategorias
	change codigo_cat codigo_cat int primary key auto_increment;

/* 4 - Inserir na tabCategorias os registros abaixo: */
insert into tabCategorias
	values
		(1, 'Confecção'),
        (2, 'Calçados'),
        (3, 'Bolas'),
        (4, 'Natação'),
        (5, 'Tênis'),
        (6, 'Tênis de Mesa');

/* 5 – Criar a tabela abaixo: */
create table tabMarcas
	(
		codigo_mar int primary key auto_increment,
        nome_mar varchar(80) not null
	);

/* 6 – inserir na tabMarcas os registros abaixo: */
insert into tabMarcas
	values
		(1, 'Nike'),
		(2, 'Adidas'),
		(3, 'Reebok'),
		(4, 'Wilson'),
		(5, 'Speedy'),
		(6, 'Butterfly');

/* 7 - Criar a tabela abaixo: */
create table tabUnidades
	(
		codigo_uni int primary key auto_increment,
        descricao_uni varchar(80) not null
	);

/* 8 – inserir na tabUnidades os registros abaixo: */
insert into tabUnidades
	values
		(1, 'Peça'),
		(2, 'Par'),
		(3, 'Grama'),
		(4, 'Litro'),
		(5, 'Caixa'),
		(6, 'Cartela');

/* 9 - Selecionar todos os registros da tabela de Marcas */
select * from tabMarcas;

/* 10 - Selecionar todos os registros da tabela de Categorias ordenando pela descrição.  */
select * from tabCategorias
	order by descricao_cat;

/* 11 – alterar a descrição_uni para ‘kilogramas’ do registro código_uni = 3 da tabela tabUnidades. */
update tabUnidades
	set descricao_uni = 'Kilogramas'
    where codigo_uni = 3;

/* 12 – selecionar todos os nomes de descrição_uni que começa com a letra C */
select descricao_uni from tabUnidades
	where descricao_uni like 'C%';

/* 13  – selecionar todos os nomes de descrição_uni que termina com a letra A */
select descricao_uni from tabUnidades
	where descricao_uni like '%A';

/* 14 - Crie a instrução SQL para alterar o nome da Marca de código igual a 5 para Speed. */
update tabMarcas
	set nome_mar = 'Speed'
    where codigo_mar = 5;

/* 15- Criar a tabela abaixo: */
create table tabProdutos 
	(
		codigo_pro int primary key auto_increment,
        descricao_pro varchar(100) not null,
        preco_custo_pro decimal(6, 2) not null,
        preco_venda_pro decimal(6, 2),
        qtde_estoque_pro int not null,
        qtde_minima_pro int not null,
        codigo_cat int not null,
        codigo_mar int not null,
        codigo_uni int not null,
        foreign key (codigo_cat) references tabCategorias (codigo_cat),
        foreign key (codigo_mar) references tabMarcas (codigo_mar),
        foreign key (codigo_uni) references tabUnidades (codigo_uni)
	);

/* 16 - Crie as instruções SQL para inserir os dados abaixo na tabela de Produtos. */
insert into tabProdutos
	values
		(1, 'Camisa Brasil I', 100.00, 160.00, 18, 6, 1, 1, 1),
        (2, 'Bola Adidas Copa 2010', 150.00, 240.00, 2, 3, 3, 2, 1),
        (3, 'Camisa França II', 110.00, 170.00, 1, 2, 1, 2, 1),
        (4, 'Bola de Tênis de Mesa Profissional c/ 6', 20.00, 32.00, 12, 6, 6, 6, 6),
        (5, 'Bola de Tênis c/ 3', 11.00, 18.00, 4, 6, 5, 4, 5),
        (6, 'Raquete Tênis Profissional', 280.00, 460.00, 2, 2, 5, 4, 1),
        (7, 'Camisa Esportiva', 20.00, 32.00, 12, 3, 1, 3, 1),
        (8, 'Chuteira de Campo de Couro', 90.00, 170.00, 8, 6, 2, 1, 2),
        (9, 'Chuteira de Futsal de Sintético', 40.00, 65.00, 12, 6, 2, 3, 2),
        (10, 'Óculos de Natação Expert', 35.00, 60.00, 3, 6, 4, 5, 1),
        (11, 'Maiô de Natação Sublime', 70.00, 125.00, 3, 3, 4, 5, 1);

/* 1) Crie a instrução SQL para alterar a descrição da Unidade de código igual a 3 para Kilos. */
update tabUnidades
	set descricao_uni = 'Kilos'
    where codigo_uni = 3;

/* 2) Crie a instrução SQL para alterar o nome da Marca de código igual a 5 para Speed. */
update tabMarcas
	set nome_mar = 'Speed'
    where codigo_mar = 5;

/* 3) Crie a instrução SQL para alterar o nome da descrição do Produto de código igual a 7 para “Camisa Lazer de Poliéster”.  */
update tabProdutos
	set descricao_pro = 'Camisa Lazer de Poliéster'
    where codigo_pro = 7;

/* 4) Crie a instrução SQL para alterar o preço de venda do Produto de código igual a 8 para R$ 155,00. */
update tabProdutos
	set preco_venda_pro = 155.00
    where codigo_pro = 8;

/* 5) Crie a instrução SQL para somar mais 6 itens no Produto de código igual a 9. */
update tabProdutos
	set qtde_estoque_pro = qtde_estoque_pro + 6
    where codigo_pro = 9;

/* 6) Crie a instrução SQL para atualizar os dados abaixo do Produto de código igual a 11. 
	  Descrição = Maio de Natação Sublime Especial 
	  Valor de Custo = R$ 64,00 
	  Valor de Venda = R$ 115,00 
	  Quantidade em Estoque = 9 
	  Quantidade Mínima = 6 */
update tabProdutos
	set 
		descricao_pro = 'Maiô de Natação Sublime Especial',
        preco_custo_pro = 64.00,
        preco_venda_pro = 115.00,
        qtde_estoque_pro = 9,
        qtde_minima_pro = 6
	where
		codigo_pro = 11;

/* 7) Crie a instrução SQL para excluir a Unidade de código igual a 4. */
delete from tabUnidades where codigo_pro = 4;

/* 8) Crie a instrução SQL para excluir o Produto de código igual a 7. */
delete from tabProdutos where codigo_pro = 7;

/* 9) Selecionar todos os registros da tabela de Marcas. */
select * from tabMarcas;

/* 10) Selecionar todos os registros da tabela de Categorias ordenando pela descrição. */
select * from tabCategorias
	order by descricao_cat;

/* 11) Selecionar todos os registros da tabela de Unidades ordenando pelo código da unidade de forma descendente. */
select * from tabUnidades
	order by codigo_uni desc;

/* 12) Selecionar todas as descrições da tabela de Unidades ordenando pela descrição da unidade. */
select * from tabUnidades 
	order by descricao_uni;

select * from tabProdutos;


/* Testando se o autoincrement funciona do jeito que eu to pensando: */
create table tabTeste
	(
		codigo_uni int primary key auto_increment,
        descricao_uni varchar(80) not null
	);

insert into tabTeste (descricao_uni)
	values 
		('Oi'),
        ('Tim'),
        ('Vivo'),
        ('Claro');

select * from tabTeste;

drop table tabTeste;
























