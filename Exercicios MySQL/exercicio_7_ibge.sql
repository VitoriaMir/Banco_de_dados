select * from tb_municipios order by nome;

/*Fazer o select para contar quantos municipios tem cadastrado; */
select count(id) as total_municipios from tb_municipios;

/*Fazer o select para contar quantos estados tem cadastrado;*/
select count(id) as total_estado from tb_estados;

/*Fazer o select para exibir todos os municipios do estado de SP*/


/*Fazer o select para exibir todos os municipios do estado de DF */


/*Fazer o select para contar quantos municipios tem no AC */
select sigla, count(M.id) as total_municipios
from tb_municipios as M,
tb_estados as E
where M.id_estado = E.id
and E.sigla = 'AC';

/*Fazer o select para que exiba todos os municipios inicia com a palavra 'RIO'*/
select nome 
from tb_municipios
where nome like 'rio%';

/*ou*/

select M.nome, E.sigla
from tb_municipios as M,
tb_estados as E
where E.id = M.id_estado
and M.nome like 'rio%'
order by M.nome;

/*Fazer o select que exiba todos os municipios contenha a palavra 'MONTE' */
select nome 
from tb_municipios
where nome like '%MONTE%';

/*ou*/

select M.nome, E.nome 
from tb_municipios as M, tb_estados as E
where E.id = M.id_estado
	and M.nome like '%MONTE%';

/*Fazer o select que exiba os estados da região SUL*/
select E.nome as Estados, R.nome as Região
from tb_estados as E, tb_regioes as R
where E.id_regiao= R.id
	and R.nome = 'SUL';

/*Fazer o select que exiba os estados da região SUL e NORDESTE*/
select E.nome as Estados, R.nome as Região
from tb_estados as E, tb_regioes as R
where E.id_regiao= R.id
	and R.nome  in ('SUL','NORDESTE') order by R.nome;

/*ou*/

select E.nome as Estados, R.nome as Região
from tb_estados as E, tb_regioes as R
where E.id_regiao= R.id
	and R.nome ='SUL'  or R.nome = 'NORDESTE' order by R.nome;
    
/*Fazer o select  que exiba o nome do municipio, sigla, estado e regiao dos estados DF, GO, AL, SP, RJ e MG*/
select M.nome as Municipios, E.nome as Estados, R.nome as Região, E.sigla
from tb_estados as E, tb_municipios as M, tb_regioes as R
where R.id = E.id_regiao
	and E.id = M.id_estado
	and E.sigla in ('DF', 'GO', 'AL', 'SP', 'RJ', 'MG');

/*Fazer o select para exibir quantos municipios tem a região SUL*/
select count(M.id) as total_municipios, R.nome
from tb_estados as E, tb_municipios as M, tb_regioes as R
where E.id_regiao = R.Id
	and E.id = M.id_estado
    and R.nome ='SUL';

/*Exibir o nome do municipio que começa com a letra N e seja do estado do Maranhão*/
select M.nome as Municipios, E.nome as Estados, E.sigla
from tb_estados as E, tb_municipios as M
where E.id = M.id_estado 
and E.nome in ('Maranhão')
and M.nome like 'N%';
 
/*Exibir a contagem de todos os municipios que tenham a palavra SANTA*/
select count(M.id) as Total_Municipios
from tb_municipios as M, tb_estados as E
where E.id = M.id_estado
and M.nome like '%SANTA%';
    
/*Exibir os municipios e o nome do estado, cujo o nome do municipio tem 4 letras*/
select M.nome as Municipios, E.nome as Estados
from tb_municipios as M, tb_estados as E
where E.id = M.id_estado
and M.nome like '____' order by M.nome;

/*Exibir a contagem de estados por regiao*/
select R.nome as Regioes, count(E.id) as Estados
from tb_regioes as R, tb_estados as E
where E.id_regiao = R.id
group by R.nome
order by E.nome;

/*Exibir a contagem de municipios por estados*/
select E.nome as Estados, count(M.id) as Municipios
from tb_municipios as M, tb_estados as E
where M.id_estado = E.id
group by E.nome
order by E.nome;

/*Exibir o estado que tem a maior quantidade de municipios*/
select E.nome as Estado, count(M.id) as Total_municipios
from tb_municipios as M, tb_estados as E
where E.id = M.id_estado
group by E.nome
having count(M.id) >= ALL (select count(M.id)
							from tb_estados as E,
								tb_municipios as M
                                where E.id = M.id_estado
                                group by E.nome);

/*Exibir o estado que tem a menor quantidade de municipios*/
select E.nome as Estado, count(M.id) as Total_municipios
from tb_municipios as M, tb_estados as E
where E.id = M.id_estado
group by E.nome
having count(M.id) <= ALL (select count(M.id)
							from tb_estados as E,
								tb_municipios as M
                                where E.id = M.id_estado
                                group by E.nome);

/*Exibir quais estados tem mais de 500 municipios*/
select E.nome as Estados, count(M.id) as Municipios
from tb_municipios as M, tb_estados as E
where M.id_estado = E.id
group by E.nome
having count(M.id) > 500
order by 2 desc;

/*Exibir quais estados tem menos  de 100 municipios*/
select E.nome as Estados, count(M.id) as Municipios
from tb_municipios as M, tb_estados as E
where M.id_estado = E.id
group by E.nome
having count(M.id) < 100
order by 2 desc;

/*Exibir quais estados tem entre 100 e 500 municipios*/
select E.nome as Estados, count(M.id) as Municipios
from tb_municipios as M, tb_estados as E
where M.id_estado = E.id
group by E.nome
having count(M.id) between 100 and 500
order by 2 desc;

#-------------------------------- PARTE 2 --------------------------------------------------------

CREATE DATABASE db_ibge;
USE db_ibge;
/*Criar a tabela tb_regioes*/
CREATE TABLE tb_regioes 
(  
  	id INT NOT NULL PRIMARY KEY,  
	nome VARCHAR(40) NOT NULL,  
	sigla VARCHAR(2) NOT NULL
) ;
insert into tb_regioes (id,nome,sigla) 
Values
(1, 'Norte', 'N'),
(2, 'Nordeste', 'NE'),
(3, 'Sudeste', 'SE'),
(4, 'Sul', 'S'),
(5, 'Centro-Oeste', 'CO');

CREATE TABLE tb_estados (
  id INT NOT NULL PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  sigla VARCHAR(2) NOT NULL,
  id_regiao INT DEFAULT NULL,
  FOREIGN KEY (id_regiao) REFERENCES tb_regioes (id)
);

insert into tb_estados (id,nome,sigla,id_regiao) Values
(11, 'Rondônia', 'RO', 1),
(12, 'Acre', 'AC', 1),
(13, 'Amazonas', 'AM', 1),
(14, 'Roraima', 'RR', 1),
(15, 'Pará', 'PA', 1),
(16, 'Amapá', 'AP', 1),
(17, 'Tocantins', 'TO', 1);


insert into tb_estados (id,nome,sigla,id_regiao) values 
(21, 'Maranhão', 'MA', 2),
(22, 'Piauí', 'PI', 2),
(23, 'Ceará', 'CE', 2),
(24, 'Rio Grande do Norte', 'RN', 2),
(25, 'Paraíba', 'PB', 2),
(26, 'Pernambuco', 'PE', 2),
(27, 'Alagoas', 'AL', 2),
(28, 'Sergipe', 'SE', 2),
(29, 'Bahia', 'BA', 2);

insert into tb_estados (id,nome,sigla,id_regiao) values
(31, 'Minas Gerais', 'MG', 3),
(32, 'Espírito Santo', 'ES', 3),
(33, 'Rio de Janeiro', 'RJ', 3),
(35, 'São Paulo', 'SP', 3);

insert into tb_estados (id,nome,sigla,id_regiao) values
(41, 'Paraná', 'PR', 4),
(42, 'Santa Catarina', 'SC', 4),
(43, 'Rio Grande do Sul', 'RS', 4);

insert into tb_estados (id,nome,sigla,id_regiao) values
(50, 'Mato Grosso do Sul', 'MS', 5),
(51, 'Mato Grosso', 'MT', 5),
(52, 'Goiás', 'GO', 5),
(53, 'Distrito Federal', 'DF', 5);

select * from tb_estados;

/*1 – Selecione todos os dados da tabela tb_regiões*/
select * from tb_regioes;

/*2 – Selecione apenas o nome das regiões */
select nome from tb_regioes;

/*3 – Selecione todos os dados da tabela tb_estados*/
select * from tb_estados;

/*4 – Selecione apenas o nome do estado e a sigla dos estados*/
select nome,sigla from tb_estados;

/*5 – Selecione o id_região da tabela estados de forma distinta;*/
select distinct id_regiao from tb_estados;

/*6 – Selecione todos os dados da tabela tb_regiões quando o nome da região 
      for igual a Sul*/
select * from tb_regioes where nome = 'Sul';

/*7 – Selecione apenas o nome das regiões quando  
      o id for maior ou igual a 3*/
select nome from tb_regioes where id >=3;

/*8 – Selecione todos os dados da tabela tb_estados que o 
      id da região for igual a 3*/
select * from tb_estados where id_regiao >=3; 

/*9 – Selecione apenas o nome do estado e a sigla dos estados 
      quando o id do estado for menor que 24*/
select nome,sigla from tb_estados where id < 24; 

/*10 – Selecione todos os dados da tabela tb_estados quando id da região 
       for igual a 4 ou 5*/
select * from tb_estados where  id_regiao = 4 or id_regiao = 5;
/*outra solução*/
select * from tb_estados where  id_regiao in (4,5);

/*11– Selecione apenas o nome dos estados quando o id região for igual a 2 e a 
      sigla do estado for igual a AL*/
select nome from tb_estados where id_regiao = 2 and sigla = 'AL';

/*12 – Selecione apenas o nome dos estados quando o id região for igual a 2 e a 
       sigla do estado for igual a AL ou CE ou PB*/
select nome from tb_estados where id_regiao = 2 and sigla in ('AL', 'CE', 'PB');
/*outra solução*/
select nome from tb_estados where id_regiao = 2 and (sigla='CE' or sigla='AL' or sigla='PB'); 

/*13 – Selecione apenas o nome dos estados quando o id região for diferente de 2 e a 
       sigla do estado for igual a DF*/
select nome from tb_estados where id_regiao <> 2 and sigla = 'DF';
      
/*14 – Selecione o nome dos estados por ordem alfabética de nome de forma ascendente;*/
select nome from tb_estados order by nome asc;

/*15 – Selecione o nome dos estados por ordem alfabética de nome de forma descente;*/
select nome from tb_estados order by nome desc;

/*16 - Selecione o nome dos estados e a sigla por ordem crescente de id_região e 
       depois por ordem alfabética de nome estado;*/
select nome, sigla, id_regiao from tb_estados order by  id_regiao , nome;

/*17 – Selecione o nome dos estados cujo o nome tem a palavra “rio”*/
select nome from tb_estados where nome  like '%rio%';

/*18 – Selecione o nome dos estados que inicia com a letra A e em ordem alfabética;*/
select nome from tb_estados where nome like 'a%' order by nome;

/*19 - Selecione o nome dos estados e a sigla, que o nome do estado termina com a letra A;*/
select nome, sigla from tb_estados where nome like '%a';

/*20 - Selecione o nome dos estados e a sigla, que o nome do estado tenha 4 caracteres;*/
select nome,sigla from tb_estados where nome like '____';

/*21 – Selecione o nome dos estados cuja a sigla seja DF, TO, AC, AL, PB, PA, PR;*/
select nome,sigla from tb_estados where sigla in ('DF', 'TO', 'AC', 'AL', 'PA', 'PR');

/*22 – Selecione o nome dos estados que inicia com a letra A e a sigla seja diferente de AL;*/
select nome from tb_estados where nome like 'a%' and sigla <> 'AL';

/*23 - Selecione o nome dos estados e a sigla, que o id da região não seja 2 e 4;*/
select nome, sigla from tb_estados where id_regiao not in (2,4);

/*24 – Selecione o nome dos estados cuja id_região esteja entre os valores 2 e 4*/
select nome, id_regiao from tb_estados where id_regiao between 2 and 4;



create table aluno
 (mat int auto_increment primary key,
  nome varchar(80) );

insert into aluno ( nome) values ('ana'), ('maria'), ('pedro'), 
('carlos'), ('lucas');
select * from aluno;




