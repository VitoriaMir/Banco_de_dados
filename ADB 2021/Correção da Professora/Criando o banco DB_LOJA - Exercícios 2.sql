use db_loja;
/*control + enter - executa o comando*/
select * from tb_produto;

insert into tb_produto 
  (id_prod, nome, descricao, quantidade, preco, fk_cat) values 
  ('369', 'TV', '50 polegadas', 50, 2400.00, 1);


create table tb_cliente 
(
	email varchar(80) not null primary key,
    nome  varchar(80) not null,
    dt_nascimento date not null,
    senha varchar(200) not null
);

insert into tb_cliente 
  (email, nome, dt_nascimento, senha) values
  ('arthur@gmail.com', 'Arthur', '2000-10-10', md5('1010')),
  ('sarah@gmail.com', 'Sarah', '1998-02-16', md5('1602'));

select * from tb_cliente;  
insert into tb_cliente 
  (email, nome, dt_nascimento, senha) values
  ('daniela@gmail.com', 'Daniela', '2000-04-14', md5('1404')),
  ('ricardo@gmail.com', 'Ricardo', '2000-04-15', md5('1504'));

insert into tb_cliente 
  (email, nome, dt_nascimento, senha) values
  ('lucas@gmail.com', 'Lucas', '1995-02-14', sha1('1404'));  
/*Seleciona a data de hoje*/  
select curdate() as data_hoje;
/*Seleciona a data e hora de atual*/
select now() as agora;
/*Seleciona o resultado da conta - apelido para coluna*/
select 2+3 as resultado;
/*Selecionar o nome do cliente e data de nascimento no formato 
   dia-mês-ano*/
select nome, date_format(dt_nascimento, '%d/%m/%Y') as data_nascimento 
  from tb_cliente;
/*Seleciona o nome e o ano da data de nascimento*/  
select nome, year(dt_nascimento) as ano_nascimento 
  from tb_cliente order by ano_nascimento;
/*Seleciona o nome, o dia e mes do nascimento, apenas dos clientes que 
  nasceram no mês 4*/  
select nome, day(dt_nascimento) as dia_aniversario, 
       month(dt_nascimento) as mes_aniversario
  from tb_cliente 
  where month(dt_nascimento) = 4;  
insert into tb_cliente 
  (email, nome, dt_nascimento, senha) values
  ('gabriel@gmail.com', 'Gabriel', '2000-04-13', sha1('1404'));    
  /*Selecionar o nome a data de nascimento e idade */
  select nome, dt_nascimento,
         timestampdiff(year, dt_nascimento, curdate()) as idade_opcao1,
         floor(datediff(curdate(), dt_nascimento) /365.25) as idade_opcao2
    from tb_cliente;     
  
/*Clausulas do comando select */
/*Selecionar todos os produtos com a 
  quantidade seja superior a 50 
  e o preco seja menor que 100 reais*/
select * from tb_produto
  where quantidade > 50
    or preco < 100; 
/*inserindo um novo produto*/    
insert into tb_produto (id_prod, nome, descricao, quantidade,
                        preco, fk_cat) values
  ('951', 'Bola','bola de futebol de campo', 100, 60, 5);                      
/*Selecione os produto da categoria 1 ou 5*/
select * from tb_produto
   where fk_cat = 1 or fk_cat = 5;    
/*in = dentro = substituir ou */
select * from tb_produto
   where fk_cat in (1,5);  
  
  
  
  
  
  
  
  
  
  
  
  