Use db_company;

select * from tb_empregado;

select sum(salario) from tb_cargo;

/*Colocar apelido na coluna, coleque "as"*/
select sum(salario) as soma_salario  from tb_cargo;

/*1 - Selecione a soma do salario, a média salarial, o maior salario, o menor salário; */
select sum(salario) soma,
		avg(salario) media_salarial,
		min(salario) menor_salario,
		max(salario) maior_salario from tb_cargo;

/*2 - Selecione o total de departamentos cadastrados;*/
select count(id_departamento) as cont_departamento
from tb_departamento;

/*1 - Selecione o cargo que tem o maior salário e também o cargo que tem o menor salário.*/
select nm_cargo, salario
from tb_cargo
where  salario = (select min(salario) from tb_cargo)
 or  salario = (select max(salario) from tb_cargo);

/*2 - Selecione todos os cargos que ganham acima da média salarial.*/
select nm_cargo, salario
from tb_cargo
where  salario > (select avg(salario) from tb_cargo);

/*1 - Nome do empregado, matricula, nome do cargo e salario */
select matricula, nome,
	nm_cargo, salario
from tb_empregado, tb_cargo
where fk_cargo = id_cargo
order by nome;

/*2 - Nome do empregado, matricula e nome do departamento*/
select matricula, nome,
	nm_departamento
from tb_empregado, tb_departamento
where fk_departamento = id_departamento
order by nome;

/*3 - Nome do empregado, matricula, nome do cargo, salario e nome do departamento*/
select matricula, nome, nm_cargo, nm_departamento, salario
from tb_empregado, tb_departamento, tb_cargo
where fk_departamento = id_departamento 
and fk_cargo = id_cargo
order by nome;

# --------------------------------- PARTE 2 -----------------------------------------------
CREATE TABLE  db_company . tb_empregado_backuo  (
   matricula  INT(11) NOT NULL,
   nome  VARCHAR(80) NOT NULL,
   dt_nascimento  DATE NOT NULL,
   sexo  ENUM('f', 'm') NOT NULL,
   dt_admissao  DATE NOT NULL,
   dt_backup  DATETIME NULL,
  PRIMARY KEY ( matricula ));

Select * from tb_empregado;
Select * from tb_empregado_backuo;


insert into tb_empregado_backuo
Select matricula, nome, dt_nascimento, sexo, dt_admissao, now() from tb_empregado;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

				-- CRIANDO A STORE PROCEDURE
delimiter $$
	-- comando para criar uma procedure
    create procedure sp_hello()
    begin
		Select 'Hello World' as mensagem ;
    end $$
delimiter ;
-- Chamar a procedure
  call sp_hello ;

-- versão 2 da procedure - usando variaveis
delimiter $$
	drop procedure if exists sp_hello $$
    create procedure sp_hello()
    begin
		declare nome varchar(50);
        set nome = 'Vitória' ; 
        Select concat('Hello World, ', nome) as mensagem;
	end $$
delimiter ;
  call sp_hello ;

-- versão 3 procedure - passagem de parâmetros
delimiter $$
	drop procedure if exists sp_hello $$
    create procedure sp_hello(nome varchar(50))
    begin
        Select concat('Hello World, ', nome) as mensagem;
	end $$
delimiter ;
  call sp_hello('Vitória') ;
  call sp_hello('Leo') ;
  
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
/* 1 - Criar uma procedure que sp_teste1 que receberá como parâmetro uma mat(matricula do tipo inteiro)
fazer uma Select que exiba o nome e a idade do empregado, que tenha a matricula informada no parâmetro*/  
  
delimiter $$
    drop procedure if exists sp_teste1 $$
    create procedure sp_teste1(mat int)
    begin
	Select matricula, nome,
    timestampdiff(year, dt_nascimento, curdate()) as idade
    from tb_empregado
    where matricula = mat;
    end $$
delimiter ;
  call sp_teste1 (125); 
 -- -------------------------------------------------------------- 
Select table_name, COUNT(*) from information_schema.COLUMNS
where TABLE_SCHEMA = 'db_company'
group by table_name;  
-- ---------------------------------------------------------------  

/*Procedure chamado sp_teste2 que receba o parâmetro mat(matricula) do tipo inteiro e calcule a quantiadde anos que pessoa trabalha na empresa
Se o tempo_trabalho for maior ou igual a 10 anos exibir uma frase - Parabéns você é um veterano, caso contrario exibir a frase - trabalhe mais um pouco*/  
/*versao 1*/
delimiter $$
	drop procedure if exists sp_teste2 $$
	create procedure sp_teste2(mat int)
	begin
    declare tempo int;
    Select timestampdiff(year, dt_admissao, curdate()) into tempo
    from tb_empregado
    where matricula = mat;
    Select concat(tempo, ' ano(s) de trabalho') as tempo_trabalho;
    end $$
delimiter ;
  call sp_teste2 (123);

/*versao 1*/
delimiter $$
	drop procedure if exists sp_teste2 $$
	create procedure sp_teste2(mat int)
	begin
    declare tempo int;
    declare empregado varchar(80);
    Select nome into empregado from tb_empregado where matricula = mat;
    Select timestampdiff(year, dt_admissao, curdate()) into tempo
    from tb_empregado
    where matricula = mat;
    if(tempo >= 10) then
    Select concat('Parabéns!!',empregado, ' você é um veterano(a)') as mensagem;
    else
    Select concat(empregado,'trabalhe mais um pouco') as mensagem;
    end if;
    end $$
delimiter ;
  call sp_teste2 (123);

/*criar uma procedure chamada sp_backup()*/
/*para dropar e criar as tabelas tb_empregado_bak, tb_cargo_bak, 
  tb_departamento_bak e copiar todos os dados das tabelas
  tb_empregado, tb_cargo e tb_departamento, repectivamente,
  para as tabelas criadas. */
  
desc tb_empregado;  

Select table_name 
from INFORMATION_SCHEMA.tables   
where TABLE_SCHEMA = 'db_company' ;  

Select column_name, COLUMN_TYPE from INFORMATION_SCHEMA.Columns where table_name = 'TB_CARGO';

Select *
  from INFORMATION_SCHEMA.tables   
where TABLE_SCHEMA = 'db_company'; 
  
desc TB_CARGO;

# ------------------------------------ PARTE 3 -----------------------------------------------------
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
