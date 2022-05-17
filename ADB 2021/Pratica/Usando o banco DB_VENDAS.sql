create database db_vendas;

use db_vendas;


select count(*) from notas_fiscais;
select count(*) from tabela_de_produtos;
select count(*) from tabela_de_clientes;
select count(*) from itens_notas_fiscais;
select count(*) from tabela_de_vendedores;

/*fazer a engenharia reversa*/
select * from tabela_de_produtos;

select p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
       i.QUANTIDADE, i.PRECO
  from tabela_de_produtos as p
  inner join itens_notas_fiscais as i
          on p.CODIGO_DO_PRODUTO = i.CODIGO_DO_PRODUTO;
          
select p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
       i.QUANTIDADE, i.PRECO,
       date_format(n.DATA_VENDA, '%d/%m/%Y' ) as dt_venda
  from tabela_de_produtos as p
  inner join itens_notas_fiscais as i
          on p.CODIGO_DO_PRODUTO = i.CODIGO_DO_PRODUTO
  inner join notas_fiscais as n
          on i.NUMERO = n.NUMERO;
          
explain  select * from tabela_de_produtos;         
explain  select p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
       i.QUANTIDADE, i.PRECO
  from tabela_de_produtos as p
  inner join itens_notas_fiscais as i
          on p.CODIGO_DO_PRODUTO = i.CODIGO_DO_PRODUTO;
          
explain   select p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
       i.QUANTIDADE, i.PRECO,
       date_format(n.DATA_VENDA, '%d/%m/%Y' ) as dt_venda
  from tabela_de_produtos as p
  inner join itens_notas_fiscais as i
          on p.CODIGO_DO_PRODUTO = i.CODIGO_DO_PRODUTO
  inner join notas_fiscais as n
          on i.NUMERO = n.NUMERO;          
          
/*explain - somente no select */          
explain select nome_do_produto, preco_de_lista
  from tabela_de_produtos
where   preco_de_lista = 
(select max(preco_de_lista) from tabela_de_produtos); 

/*Exibe os índices de uma tabela*/
SHOW INDEX FROM tabela_de_produtos;
SHOW INDEX FROM itens_notas_fiscais;
SHOW INDEX FROM notas_fiscais;
select * from tabela_de_produtos;
select * from itens_notas_fiscais;

select curdate();
select year(curdate());
select yearweek(curdate());
show index from notas_fiscais;
/*adicionar o indice na tabela notas_fiscais na coluna data_venda*/
alter table notas_fiscais add index (data_venda);

-- 381684.64
create view vw_resumo_total_vendido as 
select p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
       YEAR(n.DATA_VENDA) ANO,
       SUM(i.QUANTIDADE * i.PRECO) AS TOTAL_VENDIDO_ANO
  from tabela_de_produtos as p
  inner join itens_notas_fiscais as i
          on p.CODIGO_DO_PRODUTO = i.CODIGO_DO_PRODUTO
  inner join notas_fiscais as n
          on i.NUMERO = n.NUMERO
  where YEAR(n.DATA_VENDA) IN (2016, 2017)
  group by   p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
       YEAR(n.DATA_VENDA); 

insert into tabela_de_produtos (codigo_do_produto, nome_do_produto,
embalagem, tamanho, sabor, preco_de_lista) values
(250000, 'Picolé de frutas vermelhas', 'caixa', '12 un',
'frutas vermelhas', 12);

select p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
       i.QUANTIDADE, i.PRECO,
       i.QUANTIDADE * i.PRECO as Total,
       date_format(n.DATA_VENDA, '%d/%m/%Y' ) as dt_venda
  from tabela_de_produtos as p
  inner join itens_notas_fiscais as i
          on p.CODIGO_DO_PRODUTO = i.CODIGO_DO_PRODUTO
  inner join notas_fiscais as n
          on i.NUMERO = n.NUMERO; 

select p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
	year(n.data_venda) ANO,
    sum(i.QUANTIDADE * i.PRECO) AS TOTAL_VENDIDO_ANO
  from tabela_de_produtos as p
  inner join itens_notas_fiscais as i
          on p.CODIGO_DO_PRODUTO = i.CODIGO_DO_PRODUTO
  inner join notas_fiscais as n
          on i.NUMERO = n.NUMERO
  group by year(n.data_venda); 

select p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
	year(n.data_venda) ANO,
    sum(i.QUANTIDADE * i.PRECO) AS TOTAL_VENDIDO_ANO
  from tabela_de_produtos as p
  inner join itens_notas_fiscais as i
          on p.CODIGO_DO_PRODUTO = i.CODIGO_DO_PRODUTO
  inner join notas_fiscais as n
          on i.NUMERO = n.NUMERO
WHERE year(n.data_venda) in (2016, 2017)
group by p.CODIGO_DO_PRODUTO, p.NOME_DO_PRODUTO,
year(n.data_venda); 

 show index from notas_fiscais;      
 alter table notas_fiscais drop index data_venda;
 /*query cost 17845.20*/
 Select * From Notas_Fiscais Where Data_Venda = '20170101';
 
 alter table notas_fiscais add index (data_venda);
 /*query cost 88.80*/
 Select * From Notas_Fiscais Where Data_Venda = '20170101';

/*dropar o index*/
alter table notas_fiscais drop index data_venda;

alter table tabela_de_produtos add index (nome_do_produto); 
 
 
select * from vw_resumo_total_vendido;
show index from vw_resumo_total_vendido;



