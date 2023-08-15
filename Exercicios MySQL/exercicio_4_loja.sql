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
#--------------------------- SEGUNDA PARTE -------------------------------------

use db_loja;

  
Select   * from tb_produto;
/*or - OR (para testar 2 ou mais condições) conforme a tabela verdade*/


  select * from tb_produto 
  where fk_cat = 1 or preco < 5000;
/*Selecionar produto da categoria 1 OU custam menos que 5000 reais*/


  select * from tb_produto 
  where fk_cat = 1 and preco < 5000;  
/*Selecionar produto da categoria 1 E custam menos que 5000 reais*/

  
  select * from tb_produto
  where fk_cat in (1,5);
/*in - (DENTRO) usado para pesquisar onde a coluna tenha os valores presentes nos argumentos*/
 
  
  select * from tb_produto
  where fk_cat not in (1,5);
/*not in - (NÃO DENTRO) usado para pesquisar onde a coluna NÃO tenha nenhum dos valores presentes nos argumentos*/


insert into tb_produto values
('522', 'Pepsi cola', 'lata', 100, 6.80, 3);
INSERT INTO tb_produto 
  (id_prod, nome, descricao, quantidade, preco, fk_cat) values 
  ('123', 'coca cola', '2 litros', 100, 7.99, 3),
  ('456', 'computador', 'i7 com 16 Gb de RAM', 5, 4500.00, 1);
/*insert simplificado - não precisa escrever as colunas, mas as colunas devem estar na ordem correta da tabela*/
  

insert into tb_produto (id_prod, descricao, nome, preco, quantidade, fk_cat) values 
	('533','lata','Fanta laranja', 5.50, 150, 3);
/*insert NÃO SIMPLIFICADO*/    


select * from tb_produto
	where preco between 5 and 50
		or preco between 1000 and 3000;
/*Between - (ENTRE) usando para pesquisar intervalo de valores not between (NÃO ENTRE)*/        


select * from tb_produto
	where preco not between 5 and 50;
/*preco menor que 5 e maior que 50*/    


select * from tb_produto
	where nome like 'Bola%';
/*nome começa com a palavra bola*/    
    
select * from tb_produto
	where nome like '%cola';
/*nome termina com a palavra cola*/   

select * from tb_produto
	where nome like '%16 gb%';   
/*like - (COMO) usado pesquisar um padrão especificado em uma coluna por exemplo começar com um(ns) caractere(s), ou terminar om um(ns) caractere(s).*/  


select * from tb_produto where nome like 'c%';
/*seleciona todos os produtos que o nome inicia com a letra c*/


select * from tb_produto where nome like '_o%';
/*seleciona todos os produtos que o nome tenha a letra O no segundo caracter do nome*/

select * from tb_produto where nome like '____';
/*seleciona todos os produtos que o nome tenha 4 caracteres, apenas*/


select * from tb_produto where length(nome) > 5;
/*Seleciona todos os produtos que o  nome tenha o tamanho acima de 5 caracteres*/

delete from tb_produto where id_prod = '533';
select * from tb_produto
/*Excluir = deletar um registro (linha) da tabela*/


delete from tb_categoria where id_cat = 1;
delete from tb_produto where nome like '%cola%';
/*erro de integridade referencial = não pode apagar o registro pai e deixar os filhos na tabela produto orfão.*/

select * from tb_produto;
update tb_produto
	set preco = 3800
    where id_prod = '123';
/*UPDATE - alterar dados da tabela (linhas ou registros)
		   alter - alterar estrutura física da tabela*/


select * from tb_produto;
update tb_produto
	set nome = 'COCA COLA', quantidade = 99, preco = 9.99
    where id_prod = '123';

/*alterar o nome = 'Coca Cola', quantidade = 99, preco = 9.99 do produto id_prod = 123*/

#---------------------------TERCEIRA PARTE ---------------------------------------
/*Acessar o mysql via linha de comando*/
mysql -u root -p
enter password: senac

/*Criar o banco de dados*/
create database db_loja;

/*coloca o banco de dados em uso*/
use db_loja;

/*criar a tabela tb_categoria*/
create table tb_categoria
(
    id_cat int not null primary key,
    nome varchar(50) not null
);

/*exibe a descricao da tabela*/
desc tb_categoria;


/*inserir registros na tabela tb_categoria*/
insert into tb_categoria (id_cat, nome)
values
(1, 'Eletrônico'),
(2, 'Vestiário'),
(3, 'Bebidas'),
(4, 'Cosméticos'),
(5, 'Esporte');

/*seleciona todas as colunas da tabela tb_categoria*/
select * from tb_categoria;

/*cria a tabela tb_produto - com uma chave estrangeira*/
create table tb_produto
(
 id_prod varchar(5) not null primary key,
 nome   varchar(60) not null,  
 descricao varchar(100), 
 quantidade int not null , 
 preco decimal(8,2) not null,
 fk_cat int not null,
 foreign key (fk_cat) references tb_categoria (id_cat)
);

/*insere registros na tabela tb_produto*/
INSERT INTO tb_produto 
  (id_prod, nome, descricao, quantidade, preco, fk_cat)
values 
  ('123', 'coca cola', '2 litros', 100, 7.99, 3),
  ('456', 'computador', 'i7 com 16 Gb de RAM', 5, 4500.00, 1);

/*selecionar todas as colunas da tabela tb_produto ordernando pela fk_cat
   asc - ascendente
   desc - descendente*/
  select * from tb_produto order by fk_cat asc;
  
  select * from tb_produto order by preco desc;
  
/*insere registros na tabela tb_produto*/  
  INSERT INTO tb_produto 
  (id_prod, nome, descricao, quantidade, preco, fk_cat)
values 
  ('789', 'Iphone', 'Iphone X', 100, 9500.99, 1),
  ('321', 'Notebook', 'i7 com 16 Gb de RAM', 5, 5500.00, 1),
  ('987', 'Vinho', 'Rosé', 150, 55.00, 3),
  ('541', 'Vinho', 'Tinto', 50, 25.00, 3),
  ('741', 'Vinho', 'Branco',100, 48.00, 3);
  
/*selecionar apenas as colunas nome e preco da tabela tb_produto*/  
  select nome, preco from tb_produto;

/*seleciona todas as colunas da tabela tb_produto onde a coluna 
  fk_cat seja igual a 3 */  
  select * from tb_produto where fk_cat = 3;

  /*seleciona apenas as colunas nome e preco da tabela tb_produto 
  onde a coluna fk_cat seja igual a 3 */    
  select nome, preco from tb_produto where fk_cat = 3;
  
  /*
     = igual
	 > maior do que
	 >= maior ou igual
	 < menor do que
	 <= menor ou igual
	 <> diferente
  */
  /*Selecione todos os produtos que custam menos que 100 reais*/
    select * from tb_produto where preco < 100;
  
  /*Selecione todos os produtos que tem quantidade superior ou igual a 100*/
    select * from tb_produto where quantidade >= 100; 
  
  /*Selecione todos os produtos que o fk_cat seja diferente de 1*/
     select * from tb_produto where fk_cat <> 1 order by preco;
  

