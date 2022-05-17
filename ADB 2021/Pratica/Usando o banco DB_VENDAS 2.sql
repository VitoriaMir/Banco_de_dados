
desc tab_Produtos;

/* 16 - Crie as instruções SQL para inserir os dados abaixo na tabela de Produtos. */
insert into tab_Produtos (codigo_pro, descricao_pro, preco_custo_pro,
						preco_venda_pro, qtde_estoque_pro, qtde_minima_pro,
						codigo_cat, codigo_mar, codigo_uni)
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
        
select * from tab_Produtos;   

/*Slide - 19*/
/*Crie a instrução SQL para alterar a descrição da 
Unidade de código igual a 3 para Kilos. */
update tab_Unidades
   set descricao_uni = 'Kilos'
   where codigo_uni = 3;
   
select * from tab_Unidades;

/*Crie a instrução SQL para alterar o nome da descrição do 
Produto de código igual a 7 para “Camisa Lazer de Poliéster”. 
*/
select * from tab_Produtos;
update tab_Produtos
  set  descricao_pro = 'Camisa lazer de Poliéster'
  where codigo_pro = 7;
  
/*4) Crie a instrução SQL para alterar o preço de venda do Produto de 
código igual a 8 para R$ 155,00. 
*/  
select * from tab_Produtos;
update tab_Produtos
  set  preco_venda_pro = 155.00
 where codigo_pro = 8; 
 
 
/*
     http://dontpad.com/sql20
*/

/*5) Crie a instrução SQL para somar mais 6 itens no Produto de 
  código igual a 9. 
*/
select * from tab_Produtos;
update tab_Produtos
   set qtde_estoque_pro = qtde_estoque_pro + 6
   where codigo_pro = 9;
 
/*6) Crie a instrução SQL para atualizar os dados abaixo do 
Produto de código igual a 11. 
Descrição = Maio de Natação Sublime Especial 
Valor de Custo = R$ 64,00 
Valor de Venda = R$ 115,00 
Quantidade em Estoque = 9 
Quantidade Mínima = 6 
*/ 
select * from tab_Produtos;
update tab_Produtos
   set descricao_pro = 'Maio de Natação Sublime Especial',
       preco_custo_pro = 64,
       preco_venda_pro = 115,
       qtde_estoque_pro = 9,
       qtde_minima_pro = 6
   where codigo_pro = 11;  
   
/*exercício extra - calculando 10% desconto preco venda*/
update tab_Produtos
  set  preco_venda_pro = preco_venda_pro - (preco_venda_pro * 0.1)
  where codigo_pro = 1;
  
 /*ou outra solução*/ 
 update tab_Produtos
  set  preco_venda_pro = preco_venda_pro - (preco_venda_pro * (10/100))
  where codigo_pro = 1;
 
  /*ou outra solução*/
 update tab_Produtos
  set  preco_venda_pro = preco_venda_pro * 0.9
 where codigo_pro = 1;
 
 select * from tab_Produtos;
  
/*Crie a instrução SQL para excluir a Unidade de código igual a 4. 
*/ 
delete from tab_Unidades where codigo_uni = 4;
select * from tab_Unidades;

/*crie a instrução SQL para excluir o Produto de código 
igual a 7. 
*/
delete from tab_Produtos where codigo_pro = 7;
select * from tab_Produtos;

select * from tab_Produtos;
/*FUNÇÕES AGREGADORAS - SÃO USADAS NO SELECT
  SUM = SOMAR
  COUNT = CONTAR
  MAX = MAIOR VALOR
  MIN = MENOR VALOR
  AVG = MÉDIA ARITMÉTICA*/
/*Contar quantos produtos tem cadastrados*/  
select count(codigo_pro) as contagem_produto from tab_Produtos; 
select count(*) from tab_Produtos; 
/*Somar as quantidades em estoque*/
select sum(qtde_estoque_pro) as total_quant_estoque from tab_Produtos;
select * from tab_Produtos;
/*Selecionar o preco de venda do produto mais barato*/
select min(preco_venda_pro) as preco_mais_barato
 from tab_Produtos;
/*Selecionar o preco de venda do produto mais caro*/
select max(preco_venda_pro) as preco_mais_caro
from tab_Produtos;
/*Exibir tudo junto mais caro e tambem o mais barato*/
select min(preco_venda_pro) as preco_mais_barato,
       max(preco_venda_pro) as preco_mais_caro
from tab_Produtos;
/*DESAFIO: Valendo um chocolate na próxima aula
Selecionar o nome do produto mais caro e nome do produto mais barato*/
select * from tab_Produtos;
select descricao_pro , preco_venda_pro
  from tab_Produtos
where  preco_venda_pro = (select min(preco_venda_pro) from tab_Produtos)
  or   preco_venda_pro = (select max(preco_venda_pro) from tab_Produtos);
  
insert into tab_Produtos (codigo_pro, descricao_pro, preco_custo_pro,
						preco_venda_pro, qtde_estoque_pro, qtde_minima_pro,
						codigo_cat, codigo_mar, codigo_uni)
	values
		(12, 'bola de basquete autografada', 3000.00, 3600.00, 1, 1, 3, 4, 1);  

/*SUB QUERY ou SUB SELECT*/
select descricao_pro , preco_venda_pro
  from tab_Produtos
where  preco_venda_pro = (select min(preco_venda_pro) from tab_Produtos)
  or   preco_venda_pro = (select max(preco_venda_pro) from tab_Produtos);
  
/*Exibir todos os produtos em que a quantidade de estoque está abaixo
  da média da quantidade em estoque dos produtos cadastrados*/
select descricao_pro, qtde_estoque_pro
   from tab_Produtos
   where qtde_estoque_pro < (select avg(qtde_estoque_pro) from tab_Produtos)
   order by qtde_estoque_pro;
   
/*Exibir a descrição dos produtos, preco_venda_pro, qtde_estoque_pro
  e fazer a multiplicação das coluna preco_venda pela quantidade em estoque*/
select descricao_pro, preco_venda_pro, qtde_estoque_pro,
       preco_venda_pro * qtde_estoque_pro as total
  from tab_Produtos;
   