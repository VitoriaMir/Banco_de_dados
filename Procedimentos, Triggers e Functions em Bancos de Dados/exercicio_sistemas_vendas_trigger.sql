use sistema_vendas;

select * from produto;


/*Cria uma trigger que ao fazer um insert na tabela item_pedido será atualizado o estoque na tabela produto*/
delimiter $$
	drop trigger if exists tr_atualiza_estoque $$
	create trigger tr_atualiza_estoque after insert on item_pedido
    for each row
    begin
		update produto set estoque = estoque - new.quantidade
        where cod_produto = new.cod_produto;
	end $$
delimiter ;
insert into item_pedido (numero_pedido, cod_produto, quantidade)
values
(91, 13, 4),
(91, 31, 10);
select * from item_pedido;
select * from produto;

/*Validar a quantidade - ou programa PHP, JAVA - PYTHON
  Validar a quantidade EM UMA PROCEDURE
  procedure para fazer o insert na tabela item_pedido - validação if
*/
delimiter $$
	drop trigger if exists sp_insert_item $$
	create procedure sp_insert_item(num decimal, cod_pro int, qtde int)
    begin
		declare quat_estoque int;
        select estoque into quat_estoque
			from produto where cod_produto = cod_pro;
		  if (quat_estoque >= qtde) then
			insert into item_pedido(numero_pedido, cod_produto, quantidade)
			values (num, cod_pro, qtde);
		else
			select 'Quantidadeinsuficiente em estoque' as mensagem;
		end if ;
        end $$
	delimiter ;
select * from produto;
select * from pedido;
desc produto;
call sp_insert_item(91, 22, 5); -- insert é feito com sucesso e a trigger é disparada
call sp_insert_item(98, 22, 100); -- insert NÃO é realizado e a trigger Não é disparada

-- criar a tabela produto_log
create table produto_log
(id_log int auto_increment primary key,
cod_produto int,
desc_produto varchar(100),
unidade varchar(30),
preco float,
estoque int,
ocorrencia varchar(20),
dt_ocorrencia datetime,
usuario varchar(40));

/*Criar 3 trigger

3.1 Uma trigger de insert para gravar todos os dados em produto_log será disparada após o insert na tabela produto. */
delimiter $$
	drop trigger if exists tr_insert_log $$
	create trigger tr_insert_log after insert on produto
    for each row
    begin
		insert into produto_log(cod_produto, desc_produto, unidade, preco, estoque, ocorrencia, dt_ocorrencia, usuario)
        values (new.cod_produto, new.descricao, new.unidade, new.preco, new.estoque, 'Insert',now(), user());
	end $$
delimiter ;
insert into produto (cod_produto, descricao, unidade, preco, estoque)
values
(123, 'Suco','L', 7.5, 100),
(125, 'Coca cola', 'L', 9.5, 100);

select * from produto;
select * from produto_log;

/* 3.2 Uma trigger de delete para gravar todos os dados que foram deletados da tabela produto na tabela produto_log. */
delimiter $$
	drop trigger if exists tr_delete_log $$
	create trigger tr_delete_log after delete on produto    
	for each row
	begin 
    insert into produto_log(cod_produto, desc_produto, unidade, preco, estoque, ocorrencia, dt_ocorrencia, usuario)
        values (old.cod_produto, old.descricao, old.unidade, old.preco, old.estoque, 'Delete',now(), user());   
	end $$
delimiter ;
delete from produto where cod_produto = 125;
select * from produto;
select * from produto_log;

/* 3.3 Uma trigger de update para gravar todos os dados antes e depois das alterações da tabela produto na tabela produto_log. */
delimiter $$
	drop trigger if exists tr_update_log $$
	create trigger tr_update_log after update on produto    
	for each row
	begin 
    -- insert dos dados antes de afetuar a alteração
        insert into produto_log(cod_produto, desc_produto, unidade, preco, estoque, ocorrencia, dt_ocorrencia, usuario)
        values (old.cod_produto, old.descricao, old.unidade, old.preco, old.estoque, 'Upadate Antes',now(), user());
    -- insert dos dados depois de afetuar a alteração    
		insert into produto_log(cod_produto, desc_produto, unidade, preco, estoque, ocorrencia, dt_ocorrencia, usuario)
        values (new.cod_produto, new.descricao, new.unidade, new.preco, new.estoque, 'Upadate Depois',now(), user());
	end $$
delimiter ;
select * from produto;
update produto set descricao = 'Ouro Branco', preco = 4.5
where cod_produto = 13;
select * from produto_log;
