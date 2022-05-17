CREATE DATABASE TEMPLATE;

use template;

create table tb_Categorias (
	codigo_cat int not null primary key,
    descricao_cat varchar (100) not null
    );
    
insert into tb_Categorias (codigo_cat, descricao_cat) 
values 
(1, 'Confecção'),
(2,'Calçados'),
(3,'Bolas'),
(4,'Natação'),
(5,'Tênis'),
(6,'Tênis de Mesa');  

create table tb_Marcas (
	codigo_mar int not null primary key,
    nome_mar varchar (80) not null );
    
insert into tb_Marcas (codigo_mar, nome_mar)
values
(1,'Nike'),
(2,'Adidas'),
(3,'Reebok'),
(4,'Wilson'),
(5,'Speedy'),
(6,'Butterfly');

create table tab_Unidades (
	codigo_uni int not null primary key,
	descricao_uni varchar (80) not null ); 
    
insert into tab_Unidades (codigo_uni, descricao_uni)
values
(1,'Peça'),
(2,'Par'),
(3,'Gramas'),
(4,'Litro'),
(5,'Caixa'),
(6,'Cartela');   

/*9 - Selecionar todos os registros da tabela de Marcas */    
select * from tb_Marcas;    
    
/*10 - Selecionar todos os registros da tabela de Categorias ordenando pela descrição. */    
select descricao_cat, codigo_cat from tb_Categorias;    
    
/*11 – alterar a descrição_uni para ‘kilogramas’ do registro código_uni = 3 da tabela tabUnidades.*/    
select * from tab_Unidades;
update tab_Unidades
	set descricao_uni = 'kilogramas'
    where codigo_uni = 3;   
 
/*12 – selecionar todos os nomes de descrição_uni que começa com a letra C */
select descricao_uni from tab_Unidades where descricao_uni like 'C%';

/*13  – selecionar todos os nomes de descrição_uni que termina com a letra A*/
select descricao_uni from tab_Unidades where descricao_uni like '%A';


/*14 - Crie a instrução SQL para alterar o nome da Marca de código igual a 5 para Speed. */
select * from tb_Marcas;
update tb_Marcas
	set nome_mar = 'Speed'
    where codigo_mar = 5; 


create table tab_Produtos (
		codigo_pro int primary key auto_increment,
        descricao_pro varchar(100) not null,
        preco_custo_pro decimal(6, 2) not null,
        preco_venda_pro decimal(6, 2),
        qtde_estoque_pro int not null,
        qtde_minima_pro int not null,
        codigo_cat int not null,
        codigo_mar int not null,
        codigo_uni int not null,
        foreign key (codigo_cat) references tb_Categorias (codigo_cat),
        foreign key (codigo_mar) references tb_Marcas (codigo_mar),
        foreign key (codigo_uni) references tab_Unidades (codigo_uni)
	);
    
 /* 1) Crie a instrução SQL para alterar a descrição da Unidade de código igual a 3 para Kilos. */
update tab_Unidades
	set descricao_uni = 'Kilos'
    where codigo_uni = 3;

/* 2) Crie a instrução SQL para alterar o nome da Marca de código igual a 5 para Speed. */
update tb_Marcas
	set nome_mar = 'Speed'
    where codigo_mar = 5;

/* 3) Crie a instrução SQL para alterar o nome da descrição do Produto de código igual a 7 para “Camisa Lazer de Poliéster”.  */
update tab_Produtos
	set descricao_pro = 'Camisa Lazer de Poliéster'
    where codigo_pro = 7;

/* 4) Crie a instrução SQL para alterar o preço de venda do Produto de código igual a 8 para R$ 155,00. */
update tab_Produtos
	set preco_venda_pro = 155.00
    where codigo_pro = 8;

/* 5) Crie a instrução SQL para somar mais 6 itens no Produto de código igual a 9. */
update tab_Produtos
	set qtde_estoque_pro = qtde_estoque_pro + 6
    where codigo_pro = 9;

/* 6) Crie a instrução SQL para atualizar os dados abaixo do Produto de código igual a 11. 
	  Descrição = Maio de Natação Sublime Especial 
	  Valor de Custo = R$ 64,00 
	  Valor de Venda = R$ 115,00 
	  Quantidade em Estoque = 9 
	  Quantidade Mínima = 6 */
update tab_Produtos
	set 
		descricao_pro = 'Maiô de Natação Sublime Especial',
        preco_custo_pro = 64.00,
        preco_venda_pro = 115.00,
        qtde_estoque_pro = 9,
        qtde_minima_pro = 6
	where
		codigo_pro = 11;

/* 7) Crie a instrução SQL para excluir a Unidade de código igual a 4. */
delete from tab_Unidades where codigo_uni = 4;

/* 8) Crie a instrução SQL para excluir o Produto de código igual a 7. */
delete from tab_Produtos where codigo_pro = 7;

/* 9) Selecionar todos os registros da tabela de Marcas. */
select * from tb_Marcas;

/* 10) Selecionar todos os registros da tabela de Categorias ordenando pela descrição. */
select * from tb_Categorias
	order by descricao_cat;

/* 11) Selecionar todos os registros da tabela de Unidades ordenando pelo código da unidade de forma descendente. */
select * from tab_Unidades
	order by codigo_uni desc;

/* 12) Selecionar todas as descrições da tabela de Unidades ordenando pela descrição da unidade. */
select * from tab_Unidades 
	order by descricao_uni;

select * from tab_Produtos;


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