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










