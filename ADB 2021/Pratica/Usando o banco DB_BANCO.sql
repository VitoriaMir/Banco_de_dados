select * from agencia;
select * from cliente;
select * from conta;
select * from movimentacao;

/* 1 - Usar o banco de dados DB_BANCO; */
USE DB_BANCO;

/* 2 - Fazer a engenharia reversar do DB_BANCO; */

/* 3 - Criar uma procedure chamada sp_abrir_conta com os parâmetros: 
•	Numero da conta CHAR(4)
•	Código da agencia CHAR(3)
•	Cpf do cliente varchar(11)
A procedure deverá fazer o insert na tabela conta e o saldo inicial será 0 */
delimiter $$
  drop procedure if exists sp_abrir_conta $$
  create procedure sp_abrir_conta
  (  
	nm_conta CHAR(4),
    cod_agencia CHAR(3),
    CPF_CLIENTE varchar(11) 
    )
	begin
    insert into CONTA (COD_AG, CPF, NRO_CONTA, SALDO)
VALUES
  (	cod_agencia, CPF_CLIENTE, nm_conta ,0);
   end $$
delimiter ;  
call sp_abrir_conta ('5151', 'A04', '02765688001'  );
select * from CONTA; 
 
/* 4 – Criar a procedure sp_depositar com os parâmetros:  
•	Numero da conta CHAR(4)
•	Código da agencia CHAR(3)
•	Valor deposito decimal(10,2)
A procedure deverá fazer o insert na tabela movimentação a coluna tipo deverá receber o valor ‘C’ e a descrição deverá receber o valor ‘Depósito’   */
delimiter $$
  drop procedure if exists sp_sacar $$
  create procedure sp_sacar 
  (
      num_conta char(4),
      num_ag    char(3),
      saque     decimal(10,2)
  )
  begin 
     declare id int;
     declare saldo_atual decimal(10,2);
     select max(id_movimentacao) into id from movimentacao;
     set id = id + 1;
     select saldo into saldo_atual from conta where nro_conta = num_conta and cod_ag = num_ag;
     if ((saque <= saldo_atual) and (saque <= 2000)) then 
        insert into movimentacao (id_movimentacao, cod_ag, nro_conta, tipo, 
                                 descricao, valor, dt_movimentacao) values
								(id, num_ag, num_conta, 'D', 'Saque', saque, now());
     end if;
  end $$
delimiter ;  
select * from conta;
update conta set saldo = 1000 where nro_conta = '1901' and cod_ag = 'A01';     
call sp_sacar('1901', 'A01', 50);
  
/* 5 – Criar a procedure sp_sacar com os parâmetros:  
•	Numero da conta CHAR(4)
•	Código da agencia CHAR(3)
•	Valor saque decimal(10,2)
OBS.: Validar para não deixar o saldo negativo na conta e o valor do saque não pode ultrapassar o limite de 2000.
A procedure deverá fazer o insert na tabela movimentação a coluna tipo deverá receber o valor ‘D’ e a descrição deverá receber o valor ‘Saque’   */
delimiter $$
  drop procedure if exists sp_sacar $$
  create procedure sp_sacar
  (  
	Num_conta CHAR(4),
	Cod_agencia CHAR(3),
	Valor_saq decimal(10,2)
	)
	begin
    insert into movimentacao (id_movimentacao, cod_ag, nro_conta, tipo, descricao, valor, dt_movimentacao)
VALUES
  (	112, Cod_agencia, Num_conta,'D', 'Saque', Valor_saq < 2000, curdate() );
   end $$
delimiter ; 
call sp_sacar ('5151', 'A03', 2001 );
select * from movimentacao; 


/* 6 – Criar a procedure sp_transferencia com os parâmetros:  
•	Numero da conta de origem CHAR(4)
•	Código da agencia de origem CHAR(3)
•	Numero da conta de destino CHAR(4)
•	Código da agencia de destino CHAR(3)
•	Valor saque decimal(10,2)
OBS.: Validar para não deixar o saldo negativo na conta de origem e o valor da transferência não pode ultrapassar o limite de 1000
A procedure deverá fazer 2 inserts na tabela movimentação
•	O id movimentação é o mesmo no caso do 2 insert
•	insert na tabela movimentação a coluna tipo deverá receber o valor ‘C’ e a descrição deverá receber o valor ‘Crédito por Transferência’  na conta de destino
•	insert na tabela movimentação a coluna tipo deverá receber o valor ‘D’ e a descrição deverá receber o valor ‘Débito por Transferência’  na conta de origem */
delimiter $$
   drop procedure if exists sp_transferencia $$
   create procedure sp_transferencia
   (
      conta_origem    char(4),
      agencia_origem  char(3),
      conta_destino   char(4),
      agencia_destino char(3),
      transferencia   decimal(10,2) 
   )
   begin
      declare id int;
      declare saldo_atual decimal(10,2);
      select count(id_movimentacao) into id from movimentacao;
      set id = id + 1;
      select saldo into saldo_atual from conta where nro_conta = conta_origem and cod_ag = agencia_origem;
      if ( (transferencia <= saldo_atual ) and (transferencia <= 1000) ) then
         insert into movimentacao (id_movimentacao, cod_ag, nro_conta, tipo, 
                descricao, valor, dt_movimentacao) values
                (id, agencia_origem, conta_origem , 'D', 'Débito por Transferência', transferencia, now()),
                (id, agencia_destino,conta_destino ,'C', 'Crédito por Transferência', transferencia, now());
      end if;
   end $$
delimiter ;   
call sp_transferencia('1901', 'A01', '1902', 'A01', 350);
select * from movimentacao;



/* 7 – Criar uma trigger que a cada insert na tabela MOVIMENTACAO o saldo da conta será atualizado, seguindo as regras:
Em caso de deposito o saldo deverá ser somado
Em caso de saque o saldo deverá diminuir
Em caso de transferência o saldo da conta de origem deverá diminuir
Em caso de transferência o saldo da conta de destino deverá aumentar */
delimiter $$
   drop trigger if exists tr_atualiza_saldo $$
   create trigger tr_atualiza_saldo after insert on movimentacao 
   for each row
   begin 
      if (new.tipo = 'C') then
         update conta set saldo = saldo + new.valor 
         where cod_ag = new.cod_ag and nro_conta = new.nro_conta;
      else 
         update conta set saldo = saldo - new.valor 
         where cod_ag = new.cod_ag and nro_conta = new.nro_conta;
      end if;
   end $$
delimiter ;
select * from conta;   
call sp_depositar('1902', 'A01', 800);
select * from conta; 
select * from movimentacao;  
call sp_sacar('1902','A01', 150);
call sp_transferencia('1902','A01','1904','A01',300);