/*criar uma view - tabela virtual - feita a partir de um select */
drop view if exists vw_consulta;
create view vw_consulta as
select cl.nome, cl.cidade,
       a.cod_ag, a.nome as agencia, a.cidade as local_agencia,
       c.nro_conta, c.saldo
  from agencia as a 
  inner join conta as c
	on a.cod_ag = c.cod_ag
  inner join cliente as cl
    on c.cpf = cl.cpf
  order by cl.nome;
    
select nome, cidade, local_agencia, saldo from vw_consulta;

select * from agencia;

insert into cliente(cpf, nome, endereco, cidade, estado) values
 ('05551529282', 'Lis', 'Q 10 conjunto B', 'Sobradinho', 'DF');
 
call sp_abrir_conta('1588', 'A02', '05551529282'); 


select nome, cidade, local_agencia, saldo from vw_consulta;
