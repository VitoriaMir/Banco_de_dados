/*usar o banco de dados sistema vendas e criar as procedures e funções a
seguir*/
alter table produto add column estoque int default 100;
use sistema_vendas;
/*criar uma procedure para gravar (inserir) um novo produto 
  nome da procedure sp_insert_produto e deverá receber com 
  parametros o codigo do produto, nome do produto (descricao)
  a unidade, o preço e a quantidade em estoque*/
desc produto;

delimiter $$
  drop procedure if exists sp_insert_produto $$
  create procedure sp_insert_produto
  (  
     cod int,
     uni varchar(10),
     des varchar(200),
     pre float,
     est int
  )
  begin
     insert into produto (cod_produto, unidade, descricao,
                           preco, estoque ) values
       (cod, uni, des, pre, est);
  end $$
delimiter ;  
call sp_insert_produto(99, 'caixa', 'ovos', 10.00, 100);
select * from produto; 
  
  
  
  

/*criar uma função chamada fn_total_pedido
 que receba o numero do pedido e retorne o total do pedido*/
 select numero_pedido, descricao, preco, quantidade,
        preco * quantidade
   from produto as p inner join item_pedido as i
     on p.cod_produto = i.cod_produto
	where numero_pedido = 101;
    
     select numero_pedido, sum(preco * quantidade)
   from produto as p inner join item_pedido as i
     on p.cod_produto = i.cod_produto
	where numero_pedido = 101;
 
 delimiter $$
   drop function if exists fn_total_pedido $$
   create function fn_total_pedido(num int) returns decimal(9,2)
   begin
      declare soma decimal(9,2);
      select sum(preco * quantidade) into soma
		from produto as p inner join item_pedido as i
          on p.cod_produto = i.cod_produto
	   where numero_pedido = num;
       return soma;
    end $$
 delimiter ;   
 select fn_total_pedido(101);
 
/*Criar uma nova função chamada fn_soma_pedidos que não
  tem parâmetros e retorne a soma de todos os pedidos
  (quantidade * preco ) */
/*select para somar a quantidade x preco de todos os itens de pedidos*/
select sum(quantidade * preco)
  from produto as p inner join item_pedido as i
          on p.cod_produto = i.cod_produto;
          
delimiter $$
  drop function if exists fn_soma_pedidos $$
  create function fn_soma_pedidos() returns float 
  begin
    declare soma float;
    select sum(quantidade * preco) into soma
      from produto as p inner join item_pedido as i
        on p.cod_produto = i.cod_produto;
    return soma;    
  end $$
delimiter ;  
/*Criar uma procedure sp_aumentar_preco, e que 
  aumente o preco de todos produtos em 5%*/
select * from produto;  
delimiter &&
	drop procedure if exists sp_aumentar_preco &&
    create procedure sp_aumentar_preco() 
    begin 
       update produto set preco = preco * 1.05 where cod_produto > 0;
    end &&
 delimiter ;
 call sp_aumentar_preco();
 
/*Criar uma procedure sp_promocao que receba o codigo
  do produto como parâmetro e o percentual de desconto
  e faça o update do preco do produto para que ele fique
  em promoção*/  
delimiter &&
	drop procedure if exists sp_promocao  &&
    create procedure sp_promocao(cod int, percent int)
    begin
		if (percent >0 and percent<100) then
			update produto set preco = preco - ((percent/100) * preco)
			where cod_produto = cod;
		end if;
    end &&
delimiter ;  
select * from produto;  
call sp_promocao(13, 25);
call sp_promocao(13, 200);  
  
/*criar uma procedure para criar uma nova conta de usuário
  sp_add_usuario e receba como parâmetro o nome do usuário
  e a senha*/
delimiter $$
	drop procedure if exists sp_add_usuario $$
    create procedure sp_add_usuario(usuario varchar(50), senha varchar(50))
    begin
		declare servidor varchar(50) default '@\'localhost\'';
        set servidor = concat('\'',usuario,'\'',servidor);
        set senha = concat('\'',senha,'\'');
        set @sql = concat('Create user ',servidor, 'identified by ', senha);
        prepare comando from @sql;
        execute comando;
        deallocate prepare comando;
    end $$
delimiter ;    
call sp_add_usuario('joseneuza', '123');
select user from mysql.user;  
  
select length('senac') as tamanho; 
grant all privileges on banco.* to usuario; 
show grants for 'leo'@'localhost';
 /*criar uma procedure que conceda todos os privilégios ao
  usuario passado como parâmetro, ao banco passado como
  parâmetro, em todas as tabelas do banco
  */
 delimiter $$
	drop procedure if exists sp_privilegios $$
    create procedure sp_privilegios(usuario varchar(80), banco varchar(80))
	begin
		set banco = concat(banco, '.*');
        set usuario = concat('\'',usuario,'\'','@\'localhost\'');
        set @sql = concat('grant all privileges on *.*', ' to ', usuario);
        select @sql;
        prepare comando from @sql;
        execute comando;
       
        deallocate prepare comando;
        flush privileges;
    end  $$
delimiter ; 
  
call sp_privilegios('leo', 'db_ibge');  
  
  
 


select pow(3,2);

set @sql = concat('grant all privileges on *.*', ' to ', '\'','aluno','\'','@\'localhost\'');
        select @sql;
        prepare comando from @sql;
        execute comando;
 
PREPARE comando FROM 'SELECT POW(?,?)  AS POTÊNCIA';
SET @a = 3;
SET @b = 2;
EXECUTE comando USING @a, @b;
DEALLOCATE PREPARE comando;


SET @table = 'produto';
SET @s = CONCAT('SELECT * FROM ', @table);

PREPARE stmt3 FROM @s;
EXECUTE stmt3;
DEALLOCATE PREPARE stmt3;


prepare comando from 'select * from produto where cod_produto = ? ';
set @cod = 13;
execute comando using @cod;
set @cod = 99;
execute comando using @cod;
/**/
deallocate prepare comando;

prepare comando from 'select pow(?, ?)' ;
set @n1 = 2;
set @n2 = 10;
execute comando using @n1, @n2;

select CONCAT('\'', 'root', '\'', '@' , '\'','localhost', '\'') as ex_concatenacao;

select user from mysql.user;
show grants for 'aluno'@'localhost';













