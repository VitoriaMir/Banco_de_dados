create database template;

use template;

create table tabCategorias (
   codigo_cat int not null primary key,
   descricao_cat varchar(50) not null
);

insert into tabCategorias (codigo_cat, descricao_cat) values
(1, 'Confecção'),   
(2, 'Calçados'),  
(3, 'Bolas'),  
(4, 'Natação'),  
(5, 'Tênis'),  
(6, 'Tênis de Mesa');

create table tabMarcas (
   codigo_mar int not null primary key,
   nome_mar varchar(50) not null
);

insert into tabMarcas (codigo_mar, nome_mar) values
(1, 'Nike'),   
(2, 'Adidas'),  
(3, 'Reebok'),  
(4, 'Wilson'),  
(5, 'Speed'),  
(6, 'Butterfly');

create table tabUnidades (
   codigo_uni int not null primary key,
   descricao_uni varchar(50) not null
);

insert into tabUnidades (codigo_uni, descricao_uni) values
(1, 'Peça'),   
(2, 'Par'),  
(3, 'Gramas'),  
(4, 'Litro'),  
(5, 'Caixa'),  
(6, 'Cartela');
