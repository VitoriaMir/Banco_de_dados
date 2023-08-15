/* Criar uma trigger para controlar a quantidade de produtos em estoque
Nome da trigger tr_controle_estoque será disparada ao fazer o insert na tabela item
A trigger deverá verificar se tem quantidade em estoque para efetuar a venda em caso positivo, 
então reduzir a quantidade em estoque referente a quantidade de item que está sendo vendida */

DELIMITER $
  drop TRIGGER if exists tr_controle_estoque $
CREATE TRIGGER tr_controle_estoque AFTER INSERT
ON item
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Quantidade_estoqe = Quantidade_estoqe - NEW.Quantidade
WHERE idPRODUTOS = NEW.idPRODUTOS;
END$
DELIMITER ;

insert into item values (1, '10', '1509.60', 1, 10, 200);

select * from item ;
select * from Produtos ;

/* Criar uma trigger tr_cancelar_compra que será disparada após o update na tabela compras
caso seja feita a alteração da cancelar_compra = 'sim'
então todos os itens da tabela item deverão ser devolvidos a quantidade em estoque da 
tabela produtos, para todos os itens daquela compra.  */

DELIMITER $
	drop TRIGGER if exists tr_cancelar_compra $
CREATE TRIGGER tr_cancelar_compra AFTER DELETE
ON item
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Quantidade_estoqe = Quantidade_estoqe + OLD.Quantidade
WHERE idPRODUTOS = OLD.idPRODUTOS;
END$
DELIMITER ;

DELETE FROM item WHERE idITEM = 1 AND idPRODUTOS = 200;

select * from Produtos;

/* Cria uma procedure para fazer o insert na tabela cliente
nome da procedure: sp_insert_cliente e deverá receber como parâmetros os 
campos da tabela: id, nome, email e um telefone e fazer o insert na tabela telefone também  */

delimiter $$
  drop procedure if exists sp_insert_cliente $$
  create procedure sp_insert_cliente
  (  
     id int,
     nome varchar(45),
     cpf varchar(16),
     email varchar(200),
     tel_cliente int(12)
   )
  begin
     insert into cliente (idCLIENTE, nome, cpf, email, idTELEFONE) values
       (id, nome, cpf, email, tel_cliente);
  end $$
delimiter ;  
call sp_insert_cliente (99, 'Rayane Santos','291.388.710-41', 'rayanesant0s@gmail.com', 5564);
select * from cliente; 


/* Criar uma view que exiba todas as compras, item, servicos e respectivos defeitos dos clientes.
Inserir na view os campos que forem mais importantes   */

CREATE VIEW vwCompras_item_servico_defeitos AS
SELECT i.idCOMPRAS AS Código_Compra,
		i.idservico as Código_Servico,
        s.Atividades_prestadas,
        s.idCLIENTE as Código_cliente,
        c.nome    
FROM item as i, servico as s, cliente as c
where i.idservico = s.idservico
and c.idCLIENTE = s.idCLIENTE;

SELECT * FROM vwCompras_item_servico_defeitos;
DROP VIEW vwCompras_item_servico_defeitos;

/* Criar uma função que retorne o total soma das (quantidades * precos) de uma compra ou servico
a função receberá como parâmetro o idServico e idCompra.
Caso não tenha o valor do idServico passar o valor 0 como parâmetro
Caso não tenha o valor do idCompra passar o valor 0 como parâmetro  */

delimiter $$
  drop function if exists fn_soma $$
  create function fn_soma(idServico int, idCompra int) returns int 
  begin
    declare soma float;
    select sum(quantidade * preco_final) into soma
      from item as i
      inner join compras as c	on i.idCOMPRAS = c.idCOMPRAS
      inner join servico as s	on s.idservico = i.idservico;
    return soma;    
  end $$
delimiter ; 

SELECT * FROM compras;
SELECT * FROM rl_pagar;
SELECT * FROM servico;
SELECT * FROM item;
SELECT * FROM funcionarios;
SELECT * FROM cargo;

select fn_soma (10,10);