create database db_teste 
go

use db_teste 
go

create table tb_cargo (
	id_cargo int not null primary key,
	nome varchar(80) not null,
	salario decimal(10,2)) 
	go

insert into tb_cargo (id_cargo, nome, salario) values 
(1, 'Advogado' , 9200.00),
(2, 'Administrador', 6500.00),
(3, 'Contador', 5600.00),
(4, 'Estagiário', 980.00),
(5, 'Gerente de Projeto', 8300.00),
(6, 'Programador', 7500.00),
(7, 'Administrador de Banco de Dados', 5990.00),
(8, 'Cientista de Dados', 8700.00),
(9, 'Secretária', 2200.00)
go

insert into tb_cargo values (10, 'Vendedor', 1200.00)
go

select * from tb_cargo
go

create table  tb_departamento ( 
  id_departamento INT not null identity primary key,  
  nm_departamento VARCHAR(40) not null
)
go

insert into tb_departamento values
('RH'),
('TI'),
('Administrativo'),
('Financeiro'),
('Contábil')
go

select * from tb_departamento
go

create table tb_empregado (  
matricula INT not null primary key,  
nome VARCHAR(80) not null,  
dt_nascimento DATE not null,  
sexo char(1) not null CHECK(sexo in ('M', 'F')),  
dt_admissao DATE not null,  
fk_cargo INT not null,  
fk_departamento INT not null,  
FOREIGN KEY (fk_cargo) REFERENCES tb_cargo (id_cargo),  
FOREIGN KEY (fk_departamento) REFERENCES tb_departamento (id_departamento))
go

INSERT INTO tb_empregado(matricula, nome, dt_nascimento, sexo, 
dt_admissao, fk_cargo, fk_departamento) VALUES
(123, 'Vânia Alves', '1967-07-02', 'F', '2010-12-08', 2, 1),
(124, 'Florisbela Silva', '1999-10-02', 'F', '2019-10-01', 1, 2),
(125, 'Walter Amaral', '1998-02-02', 'M', '2018-05-25', 7, 4),
(126, 'Ana Cristina Peixoto', '1980-03-02', 'F', '2018-10-02', 4, 2),
(127, 'Clara Rodrigues', '1998-07-05', 'F', '2020-10-02', 4, 4),
(128, 'Flávio Luiz Silva', '1990-09-05', 'M', '2016-02-15', 6, 4),
(129, 'Roberto Oliveira', '1981-03-10', 'M', '2012-12-10', 8, 4),
(130, 'Cristina Moura', '1980-12-20', 'F', '2020-10-02', 9, 1),
(131, 'Gabriel Silva Costa', '1985-10-2', 'M', '2017-01-02', 3,3)
go

select * from tb_empregado
go

select getdate()
go

select format(getdate(), 'dd,MM,yyyy')
go

select matricula, nome,
	format(dt_nascimento, 'dd,MM,yyyy') as dt_nascimento_empregado,
	DATEDIFF(year, dt_nascimento, getdate()) as idade
	from tb_empregado
	go

/* INNER JOIN*/
select e.nome, c.nome as cargo, c.salario, d.nm_departamento as departamento
	from tb_empregado as e
inner join tb_cargo as c	on e.fk_cargo = c.id_cargo
inner join tb_departamento as d	on e.fk_departamento = d.id_departamento
go

/* LEFT JOIN*/
select e.nome, c.nome as cargo, c.salario, d.nm_departamento as departamento
	from tb_cargo as c
left join tb_empregado as e	on e.fk_cargo = c.id_cargo
left join tb_departamento as d	on e.fk_departamento = d.id_departamento
go

/* RIGHT JOIN*/
select e.nome, c.nome as cargo, c.salario, d.nm_departamento as departamento
	from tb_empregado as e
right join tb_cargo as c	on e.fk_cargo = c.id_cargo
right join tb_departamento as d	on e.fk_departamento = d.id_departamento
go

/* FULL JOIN*/
select e.nome, c.nome as cargo, c.salario, d.nm_departamento as departamento
	from tb_empregado as e
full join tb_cargo as c	on e.fk_cargo = c.id_cargo
full join tb_departamento as d	on e.fk_departamento = d.id_departamento
go

select * from tb_cargo
select * from tb_empregado
select * from tb_departamento
go


/*Criar uma view vw_dados com os dados do empregado, cargo e departamento*/
drop view if exists vw_dados
go
create view vw_dados as 
	select e.matricula, e.nome,
	format(dt_nascimento, 'dd,MM,yyyy') as Dt_nasc,
	c.nome as cargo, c.salario,
	d.nm_departamento as departamento
	from tb_empregado as e 
inner join tb_cargo as c			on e.fk_cargo = c.id_cargo
inner join tb_departamento as d		on e.fk_departamento = d.id_departamento
go


create procedure sp_consulta_tudo
as 
select * from tb_empregado
go

/*Executando a procedure*/
exec sp_consulta_tudo
go

/*Criar a procedure com parâmetro*/
create procedure sp_consulta @mat int
as
select * from tb_empregado where matricula= @mat
go

exec sp_consulta 123
go