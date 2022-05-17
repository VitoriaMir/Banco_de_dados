create table CLIENTE (
email varchar(80) not null primary key, 
nome varchar(80) not null,
dt_nascimento date not null,
senha varchar(200) not null
);

select * from CLIENTE;

insert into CLIENTE(email, nome, dt_nascimento, senha) values ('ricogoni@gmail.com', 'Riquinho', '2001-11-15',md5('441122')  );
insert into CLIENTE(email, nome, dt_nascimento, senha) values ('mariazinha@gmail.com', 'Maria', '2000-09-25',md5('224411')  );
insert into CLIENTE(email, nome, dt_nascimento, senha) values ('rosabeijarosa@gmail.com', 'Rosa', '1997-11-19',md5('112244')  );
insert into CLIENTE(email, nome, dt_nascimento, senha) values ('dadonado@gmail.com', 'Danilo', '1984-10-18',sha1('142142')  );


select * from CLIENTE;

select curdate();
/* Selecionar a data de hoje, pode usar com "as" para dar nome para coluna*/


select now();
/*Seleciona a data e hora atual, pode usar com "as" para dar nome para coluna*/

select 4+4;
/*Seleciona o resultado da conta, pode usar com "as" para dar nome para coluna*/

select nome, date_format(dt_nascimento, '%d/%m/%Y') as data_nascimento
	from CLIENTE;
/*Seleciona o nome do cliente e a data de nascimento no formato dia-mes-ano*/

select nome, year(dt_nascimento) as ano_nascimento
		from CLIENTE order by ano_nascimento;
/*Seleciona o nome e o ano de nascimento*/

select nome, day(dt_nascimento) as dia_aniversario,
		month(dt_nascimento) as mes_aniversario
	from CLIENTE
    where month(dt_nascimento) = 4;
/*Seleciona o nome, o dia e mes do nascimento, apenas dos clientes que nasceram no mês 4*/    

select nome, dt_nascimento,
		timestampdiff(year, dt_nascimento, curdate()) as idade_opcao1,
        floor(datediff(curdate(), dt_nascimento)/ 365.25) as idade_opcao2
	from CLIENTE;
/*Seleciona o nome a data de nascimento e idade */    

select * from tb_produto
		where quantidade > 50
			and preco < 100;
 /*Clausulas do comando select*/
 /*selecionar todos os produtos com a quantidade seja superior a 50 e o preço seja menor que 100 reais*/
 
 insert into tb_produto (id_prod, nome, descricao, quantidade, preco, fk_cat)
 values
 ('951', 'bota', 'resistente',  100, 60, 5);
 /*inserindo um novo produto*/
 
 select * from tb_produto
	where fk_cat = 1 or fk_cat = 5;
 /*Selecione os produtos da categoria 1 ou 5*/
 
select * from tb_produto
	where fk_cat in (1,5);
/*in = dentro = substituir ou*/