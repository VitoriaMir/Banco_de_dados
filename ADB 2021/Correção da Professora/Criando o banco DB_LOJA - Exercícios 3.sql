use db_loja;

  
/*and - E (para testar 2 ou mais condições) conforme a tabela verdade
or - OR (para testar 2 ou mais condições) conforme a tabela verdade
in - (DENTRO) usado para pesquisar onde a coluna tenha os valores presentes nos argumentos
not in - (NÃO DENTRO) usado para pesquisar onde a coluna não tenha nenhum dos valores presentes nos argumentos
between - (ENTRE) usado para pesquisar intervalo de valores
not between (NÃO ENTRE) 
like - (COMO) usado pesquisar um padrão especificado em uma coluna por exemplo começar com um(ns) caractere(s), ou terminar om um(ns) caractere(s).*/  
  
Select   * from tb_produto;
/*or - OR (para testar 2 ou mais condições) conforme a tabela verdade
*/
/*Selecionar produto da categoria 1 OU custam menos
  que 5000 reais*/
  select * from tb_produto 
  where fk_cat = 1 or preco < 5000;
/*Selecionar produto da categoria 1 E custam menos
  que 5000 reais*/
  select * from tb_produto 
  where fk_cat = 1 and preco < 5000;  
/*in - (DENTRO) usado para pesquisar onde a coluna tenha os 
valores presentes nos argumentos*/
  select * from tb_produto
  where fk_cat in (1,5);
/*not in - (NÃO DENTRO) usado para pesquisar onde a 
coluna NÃO tenha nenhum dos valores presentes nos argumentos*/
  select * from tb_produto
  where fk_cat not in (1,5);
/*insert simplificado - não precisa escrever as colunas, mas as
   colunas devem estar na ordem correta da tabela*/  
insert into tb_produto values 
('522', 'Pepsi cola', 'lata', 100, 6.80, 3); 
/*insert NÃO SIMPLIFICADO*/
insert into tb_produto (id_prod, descricao, nome, preco, quantidade,
  fk_cat) values
  ('533', 'lata', 'Fanta Laranja', 5.50, 150, 3);
/*between - (ENTRE) usado para pesquisar intervalo de valores
not between (NÃO ENTRE)  */ 
select * from tb_produto
  where preco between 5 and 50
    or  preco between 1000 and 3000;
/*preco menor que 5 e maior que 50*/
select * from tb_produto
  where preco not between 5 and 50;

/*like - (COMO) usado pesquisar um padrão especificado em 
uma coluna por exemplo começar com um(ns) caractere(s), 
ou terminar om um(ns) caractere(s).*/ 
select * from tb_produto;
/*nome começa com a palavra vinho*/
select * from tb_produto
  where nome like 'vinho%';
/*nome que termina com a palavra cola*/  
select * from tb_produto
  where nome like '%cola';
/*seleciona todos os produtos que a descricao tenha a palavra 16 Gb*/   
select * from tb_produto
  where descricao like '%16 gb%'; 
/*seleciona todos os produtos que o nome inicia com a letra c*/  
select * from tb_produto where nome like 'c%';
/*seleciona todos os produtos que o nome inicia com a letra V*/ 
select * from tb_produto where nome like 'v%';
/*seleciona todos os produtos que o nome tenha a letra 'o' 
   no segundo caractere do nome */
select * from tb_produto where nome like '_o%';
/*seleciona todos os produtos que o nome tenha 4 caracteres, apenas*/
select * from tb_produto where nome like '____';
/*seleciona todos os produtos que o nome tenha o tamanho acima de 
  5 caracteres*/
select * from tb_produto where length(nome) > 5;
/*Excluir = deletar um registro (linha) da tabela*/
delete from tb_produto where id_prod = '533';
select * from tb_produto;
/*erro de integridade referencial = não pode apagar o registro
  pai e deixar os filhos na tabela produto orfão*/
delete  from tb_categoria where id_cat = 1;
delete from tb_produto where nome like '%cola%';
/*update - alterar dados da tabela (linhas ou registros)
  alter - alterar estrutura física da tabela*/
select * from tb_produto;
update tb_produto 
  set  preco = 3800
  where id_prod = '321';
/*alterar o nome='Coca Cola', quantidade=99 e preco=9.99 
do produto id_prod = 123*/  


