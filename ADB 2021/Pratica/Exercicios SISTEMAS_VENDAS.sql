Use sistema_vendas;

/*•	Selecionar todos os clientes da UF: SP; */
select * from cliente 
where uf = 'SP';
    
/*•	Selecionar todos os produtos que custam mais de 1 real ou sejam vendidos em metros; */   
select * from produto
where unidade = 'M' or preco >= 1.0;

/*•	Selecionar todos os vendedores que ganham mais de 1.000 e que sejam da faixa de comissão C;*/
select * from vendedor 
where salario > 1000
and faixa_comissao = 'C';

/*•	Selecionar todos os clientes que possuem IE e são da UF: DF ou que não possuem CEP, mostrando no resultado somente os campos nome e CNPJ;*/
select nome, cnpj from cliente 
where ie  is not null 
and (uf = 'DF' or cep is null); 

/*•	Selecione qual o produto mais caro e o mais barato*/
select descricao, preco from produto 
where preco = (select max(preco) from produto)  
or preco = (select min(preco) from produto); 

 /*Criar a coluna estoque na tabela Produto;*/
 /*Atualizar a coluna estoque com o valor 100 para todos os Produtos;*/
 select * from produto;
 /*adiciona uma nova coluna estoque do tipo inteiro com um valor padrão 100*/
 alter table produto add column estoque int default 100;
 insert into produto (cod_produto, unidade, descricao, preco) values
 (88, 'M', 'papelão', 0.75);
   insert into produto (cod_produto, unidade, descricao, preco, estoque) values
 (89, 'L', 'suco', 1.75, 99); 

/*•	Selecionar nome, endereço, cidade e cep de todo os clientes que compraram chocolate, */
select c.nome, c.endereco, c.cidade, c.cep, p.numero, pr.descricao
  from cliente as c , 
       pedido as p,
       item_pedido as i,
       produto as pr
  where c.cod_cliente = p.cod_cliente
    and p.numero = i.numero_pedido
    and i.cod_produto = pr.cod_produto
    and pr.descricao = 'Chocolate';

/*•	Selecionar nome e uf os clientes que compraram ouro ou vinho*/
select c.nome, c.endereco, c.cidade, c.cep, p.numero, pr.descricao
  from cliente as c , 
       pedido as p,
       item_pedido as i,
       produto as pr
  where c.cod_cliente = p.cod_cliente
    and p.numero = i.numero_pedido
    and i.cod_produto = pr.cod_produto
    and pr.descricao in ('vinho','ouro');

/*•	Selecionar todos os clientes que compraram chocolate, vinho ou queijo*/
select c.nome, c.endereco, c.cidade, c.cep, p.numero, pr.descricao
  from cliente as c , 
       pedido as p,
       item_pedido as i,
       produto as pr
  where c.cod_cliente = p.cod_cliente
    and p.numero = i.numero_pedido
    and i.cod_produto = pr.cod_produto
    and pr.descricao in ('chocolate','vinho', 'queijo');

/*•	Selecione a quantidade de clientes por estado */
select uf, count( cod_cliente) as Cliente from cliente    
group by uf;

/*•	Selecione a soma do item vendido agrupado por produto*/
select p.descricao, sum(i.quantidade) as total_quantidade
  from produto as p, 
       item_pedido as i
 where p.cod_produto = i.cod_produto 
 group by p.descricao
 order by p.descricao; 

/*Selecione o total de pedidos por cliente*/
select c.nome, count(p.numero) as total_pedido
  from cliente as c,
       pedido as p
  where c.cod_cliente = p.cod_cliente  
  group by c.nome
  order by 2 desc;

/*Selecione o nome do vendedor, nome do cliente e numero do pedido*/
select c.nome as nome_cliente,
       v.nome as nome_vendedor,
       p.numero as numero_pedido
  from cliente as c,
       pedido as p,
       vendedor as v
 where c.cod_cliente = p.cod_cliente
   and p.cod_vendedor = v.cod_vendedor
   order by 1 , 2, 3 ;

/*Selecione o nome do cliente em união com o nome do vendedor*/
select cod_cliente as codigo, nome, 'Cliente' as tipo from cliente
union
select cod_vendedor as codigo,nome, 'Vendedor' from vendedor;


/*•	Selecione o nome e o salário do vendedor que tem o maior salário*/
select nome, salario from vendedor    
where salario = (select max(salario) from vendedor);

/*•	Selecione o nome dos vendedores e salários dos vendedores que ganham acima da média salarial.*/
select nome, salario from vendedor    
where salario > (select avg(salario) from vendedor); 

/*•	Selecione o nome dos vendedores, salário de a faixa de comissão e exiba o percentual de comissão de acordo com a faixa:
•	Faixa A – 20% de comissão
•	Faixa B – 15% de comissão
•	Faixa C – 10% de comissão*/
select nome, salario, faixa_comissao,   
case      
when faixa_comissao = 'A' then '20%'
when faixa_comissao = 'B' then '15%'
else '10%'
end as 'Percentual_comissao'
from vendedor;

/*•	Calcule o total de vendas para cada vendedor*/
select v.nome, i.quantidade, pr.preco, pr.descricao, (i.quantidade * pr.preco) as total 
  from vendedor as v,
       pedido as p,
       item_pedido as i,
	   produto as pr
  where v.cod_vendedor = p.cod_vendedor
    and p.numero = i.numero_pedido
    and i.cod_produto = pr.cod_produto;
    
/*parte 2 do exercício*/
select v.nome, truncate(sum(i.quantidade * pr.preco), 2) as total 
  from vendedor as v,
       pedido as p,
       item_pedido as i,
	   produto as pr
  where v.cod_vendedor = p.cod_vendedor
    and p.numero = i.numero_pedido
    and i.cod_produto = pr.cod_produto
  group by v.nome; 

/*•	Calcule o percentual da comissão de acordo com o exercício acima exibindo o valor da comissão de cada vendedor
*/
select v.nome, v.salario, v.faixa_comissao,
  case 
     when v.faixa_comissao = 'A' then '20%'
     when v.faixa_comissao = 'B' then '15%'
     else '10%'
  end as percentual_comissao,
  truncate(sum(i.quantidade * pr.preco), 2) as total ,
  case 
     when v.faixa_comissao = 'A' then truncate(0.20 * sum(i.quantidade * pr.preco), 2)
     when v.faixa_comissao = 'B' then truncate(0.15 * sum(i.quantidade * pr.preco), 2)
     else truncate(0.10 * sum(i.quantidade * pr.preco), 2)
  end as valor_percentual_comissao
  from vendedor as v,
       pedido as p,
       item_pedido as i,
	   produto as pr
  where v.cod_vendedor = p.cod_vendedor
    and p.numero = i.numero_pedido
    and i.cod_produto = pr.cod_produto
  group by v.nome;
  

 