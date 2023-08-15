/*seleciona os usuarios do mysql*/
select User from mysql.user;

select user();
/*seleciona o usuário que está logado no mysql*/

create user 'Visck'@'%' identified by 'vivi'; 

select User, host from mysql.user;
/*seleciona os usuarios e o servidor do mysql*/

create user 'aluno'@'localhost' identified by 'vivi'; 
/*Criar uma nova conta de usuário com o nome aluno para o localhost e a senha é vivi*/

drop user 'aluno'@'localhost';
/*Apagar o usuario do banco de dados */
-- -----------------------------------------------------------------------------------

create user 'aluno'@'localhost' identified by 'vivi'; 
/*Criar o usuario novamente*/

grant all privileges on *.* to 'aluno'@'localhost';
/*Dar privilegios total ao usuario*/

select * from information_schema.PROCESSLIST ORDER BY id;
/* OU */
show processlist;
/*Para mostrar quem estar acessando tem usuario.*/

grant all on db_geografia .tb_pais to 'aluno'@'localhost';


show grants for 'aluno'@'localhost';
/*Mostrar os privilegios do usuario*/

revoke delete, drop, update on db_geografia.tb_pais from  'aluno'@'localhost';
/*Revogar - retirar o privilegio*/
revoke delete, drop, update on *.* from  'aluno'@'localhost';

revoke all privileges, grant option from  'aluno'@'localhost';
/*retirar todos os privilegios em todos os bancos de dados para o usuário aluno*/

set password for 'aluno'@'localhost'= '';
