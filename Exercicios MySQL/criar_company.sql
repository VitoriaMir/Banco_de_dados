 Create database db_company;

Use db_company;

CREATE TABLE tb_cargo 
(  
  id_cargo INT NOT NULL PRIMARY KEY,  
    nm_cargo VARCHAR(60) NOT NULL,  
    salario DECIMAL(9,2) NOT NULL
);

CREATE TABLE  tb_departamento 
( id_departamento INT NOT NULL PRIMARY KEY,  
  nm_departamento VARCHAR(40) NOT NULL
);

CREATE TABLE tb_empregado 
( matricula INT(11) NOT NULL PRIMARY KEY,  
  nome VARCHAR(80) NOT NULL,  
  dt_nascimento DATE NOT NULL,  
  sexo ENUM('M', 'F') NOT NULL,  
  dt_admissao DATE NOT NULL,  
  fk_cargo INT NOT NULL,  
  fk_departamento INT NOT NULL,  
FOREIGN KEY (fk_cargo) REFERENCES tb_cargo (id_cargo),  
FOREIGN KEY (fk_departamento) REFERENCES tb_departamento (id_departamento)
);

insert into tb_cargo (id_cargo, nm_cargo, salario) 
values 
(1, 'Advogado' , 9200.00),
(2, 'Administrador', 6500.00),
(3, 'Contador', 5600.00),
(4, 'Estagiário', 980.00),
(5, 'Gerente de Projeto', 8300.00),
(6, 'Programador', 7500.00),
(7, 'Administrador de Banco de Dados', 5990.00),
(8, 'Cientista de Dados', 8700.00),
(9, 'Secretária', 2200.00);

select * from tb_cargo;

INSERT INTO tb_departamento (id_departamento,nm_departamento)  
VALUES
(100, 'Admistrativo'),
(200, 'Jurídico'),
(300, 'Contábil'),
(400, 'Tecnologia da Informação'),
(500, 'Recursos Humanos'),
(600, 'Comercial'),
(700, 'Financeiro');

select * from tb_departamento;

INSERT INTO tb_empregado(matricula, nome, dt_nascimento, sexo, dt_admissao, fk_cargo, fk_departamento)
VALUES
(123, 'Vânia Alves', '1967-07-02', 'F', '2010-12-08', 2, 100),
(124, 'Florisbela Silva', '1999-10-02', 'F', '2019-10-01', 1, 200),
(125, 'Walter Amaral', '1998-02-02', 'M', '2018-05-25', 7, 400),
(126, 'Ana Cristina Peixoto', '1980-03-02', 'F', '2018-10-02', 4, 200),
(127, 'Clara Rodrigues', '1998-07-05', 'F', '2020-10-02', 4, 400),
(128, 'Flávio Luiz Silva', '1990-09-05', 'M', '2016-02-15', 6, 400),
(129, 'Roberto Oliveira', '1981-03-10', 'M', '2012-12-10', 8, 400),
(130, 'Cristina Moura', '1980-12-20', 'F', '2020-10-02', 9, 100),
(131, 'Gabriel Silva Costa', '1985-10-2', 'M', '2017-01-02', 3,300);