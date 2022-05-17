-- configura o autocommit para falso
select * from tb_cargo;
set autocommit = false;
-- iniciar a transação
start transaction;
   update tb_cargo set salario = salario * 0.1 + salario where id_cargo=1;
   update tb_cargo set salario = 10000 where id_cargo in (2,3);
   select * from tb_cargo;
   rollback; -- desfazer os comandos até o inicio da transação 
select * from tb_cargo;


start transaction;
   update tb_cargo set salario = salario * 0.1 + salario where id_cargo=1;
   update tb_cargo set salario = 10000 where id_cargo in (2,3);
   select * from tb_cargo;
   commit; -- gravar os comandos até o inicio da transação 
select * from tb_cargo;

/*o rollback somente funciona para comandos DML */
start transaction;
  drop table tb_empregado;
  show tables;
  rollback;
  
start transaction;
  create user 'teste'@'localhost' identified by '123456';  
  select user from mysql.user;
  rollback;
  
  
CREATE TABLE tb_empregado 
(  
matricula INT(11) NOT NULL PRIMARY KEY,  
nome VARCHAR(80) NOT NULL,  
dt_nascimento DATE NOT NULL,  
sexo ENUM('M', 'F') NOT NULL,  
dt_admissao DATE NOT NULL,  
fk_cargo INT NOT NULL,  
fk_departamento INT NOT NULL,  
FOREIGN KEY (fk_cargo) REFERENCES tb_cargo (id_cargo),  
FOREIGN KEY (fk_departamento) REFERENCES tb_departamento (id_departamento)
); 


INSERT INTO tb_empregado(matricula, nome, dt_nascimento, sexo, 
dt_admissao, fk_cargo, fk_departamento) VALUES
(123, 'Vânia Alves', '1967-07-02', 'F', '2010-12-08', 2, 100),
(124, 'Florisbela Silva', '1999-10-02', 'F', '2019-10-01', 1, 200),
(125, 'Walter Amaral', '1998-02-02', 'M', '2018-05-25', 7, 400),
(126, 'Ana Cristina Peixoto', '1980-03-02', 'F', '2018-10-02', 4, 200),
(127, 'Clara Rodrigues', '1998-07-05', 'F', '2020-10-02', 4, 400),
(128, 'Flávio Luiz Silva', '1990-09-05', 'M', '2016-02-15', 6, 400),
(129, 'Roberto Oliveira', '1981-03-10', 'M', '2012-12-10', 8, 400),
(130, 'Cristina Moura', '1980-12-20', 'F', '2020-10-02', 9, 100),
(131, 'Gabriel Silva Costa', '1985-10-2', 'M', '2017-01-02', 3,300);

select * from tb_cargo; 

Use db_company;

/*vitoria escrever uma transação 
usar o db_company 
  retirar 500 reais do salario do advogado e 
  somar mais 500 no salario do estagio*/
  
start transaction;
select * from tb_cargo;  
	update tb_cargo set salario = salario - 500 where id_cargo = 2;
	update tb_cargo set salario = salario + 500 where id_cargo = 4;
select * from tb_cargo;  
commit; 

/*atualiza os privilégios*/  
flush privileges;

