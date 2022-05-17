/*criar uma procedure chamada sp_backup()*/
/*para dropar e criar as tabelas tb_empregado_bak, tb_cargo_bak, 
  tb_departamento_bak e copiar todos os dados das tabelas
  tb_empregado, tb_cargo e tb_departamento, repectivamente,
  para as tabelas criadas. */

/*Duplica a tabela - SEM as restriçoes de chaves PK e FK*/  
CREATE TABLE  tb_empregado_bak SELECT * FROM tb_empregado;
select * from  tb_empregado_bak;
desc  tb_empregado_bak;

/*Duplica a tabela - COM as restriçoes de chaves PK*/
CREATE TABLE nova_tabela LIKE tb_empregado;
INSERT INTO nova_tabela SELECT * FROM tb_empregado;
desc nova_tabela;
select * from nova_tabela;


delimiter $$
   drop procedure if exists sp_backup $$
   create procedure sp_backup() 
   begin
      /*dropar as tabelas se existirem*/
      drop table if exists db_company.tb_cargo_bak;
      drop table if exists db_company.tb_departamento_bak;
	  drop table if exists db_company.tb_empregado_bak;	
	  /*criar as tabelas */
	  create table db_company.tb_cargo_bak LIKE db_company.tb_cargo;
      create table db_company.tb_departamento_bak LIKE db_company.tb_departamento;
      create table db_company.tb_empregado_bak LIKE db_company.tb_empregado;
      /*fazer os insert */
      insert into db_company.tb_cargo_bak select * from db_company.tb_cargo;
      insert into db_company.tb_departamento_bak select * from db_company.tb_departamento;
      insert into db_company.tb_empregado_bak select * from db_company.tb_empregado;
   end $$
delimiter ;   
call sp_backup();

/*FUNÇÕES
	Sempre irá retornar um valor
    é chamada pelo comando select
    Pode ter um  parametro ou não*/
    
delimiter $$
	drop function if exists fn_soma $$
    create function fn_soma(n1 int, n2 int) returns int
    begin
		declare soma int;
        set soma = n1 + n2;
        return soma;
	end $$
 delimiter fn_soma(10,5) as soma1, fn_soma(15, fn_soma(3,5)) as soma2;
    
    
delimiter $$
	drop function if exists fn_soma_intervalo $$
    create function fn_soma_intervalo(n1 int, n2 int) returns int
    begin    
		declare soma int;
        set soma = 0;
        while (n1 < n2) do
			set soma = soma + n1;
            set n1 = n1 +1 ;
		end while;
        return soma;
	end $$
delimiter ;
select fn_soma_intervalo (2,6) as resultado;
    
/*vERSÃO 2*/    
delimiter $$
	drop function if exists fn_soma_intervalo $$
    create function fn_soma_intervalo(n1 int, n2 int) returns int
    begin    
		declare soma int;
        DECLARE aux int;
        if (n1 > n2) then
			set aux = n1;
            set n1 = n2;
            set n2 = aux;
            end if ;
        set soma = 0;
        while (n1 < n2) do
			set soma = soma + n1;
            set n1 = n1 +1 ;
		end while;
        return soma;
	end $$
delimiter ;
select fn_soma_intervalo (5,0) as resultado;    
    
/* se n1  >  n2		aux
		6    2		  6
        2	 6		  6
Criar uma função fn_bonus que receba a data de admissão do empregado e o salario como parametro e o retorne o valor de bonus salarial seguindo as regras 
empregado com menos de 5 anos receberá 10% e com mais na empresa receberá 20% do salrio.       
        */    
 delimiter $$
	drop function if exists fn_bonus $$
    create function fn_bonus(dt_admissao date, sal decimal(9,2)) returns decimal(9,2)
    begin 
		declare tempo_trabalho int;
        declare bonus decimal(9,2);
        set tempo_trabalho = timestampdiff(year, dt_admissao, curdate());
			if (tempo_trabalho <= 5) then
				set bonus = sal*0.10;
            else
				set bonus = sal * 0.20;
            end if ;
            return bonus;
    end $$
delimiter ;
 
select nome, dt_admissao, salario, fn_bonus(dt_admissao, salario) + salario as bonus
	from tb_empregado as e inner join tb_cargo as c			
    on e.fk_cargo = c.id_cargo;
    
    

    



