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
          
          
explain select nome_do_produto, preco_de_lista
  from tabela_de_produtos
where   preco_de_lista = 
(select max(preco_de_lista) from tabela_de_produtos);  