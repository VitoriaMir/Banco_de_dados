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
  

