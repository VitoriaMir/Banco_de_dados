/* 1 - Selecionar todos os registros da tabela de Funcionario */
select * from Funcionarios;

select * from cargo;

/* 2 - Selecione o nome do Funcionario, nome_cargo e salario. */
select F.nome, C.nome_cargo, C.salario
from funcionarios as F
inner join cargo as C			on F.idCARGO = C.idCARGO;

/* 3 - Selecione o nome do Funcionario com as iniciais "A" OU 'B', nome_cargo e salario */
select F.nome, C.nome_cargo, C.salario
from funcionarios as F
inner join cargo as C			on F.idCARGO = C.idCARGO
where F.nome like 'A%' or 'B%'
order by F.nome;

/* 4 - Selecione a contagem de Todos os funcionarios. */
select count(Matricula) as Total_Funcionarios
from funcionarios as F;

/* 5 - Selecione a contagem de Todos os clientes da loja*/
select count(idCLIENTE) as Total_Clientes
from cliente ;

/* 6 - Selecione o salario mais alto e o mais baixo entre os funcionarios*/
select F.nome, salario, nome_cargo
from funcionarios as F
inner join cargo as C			on F.idCARGO = C.idCARGO
where salario = (select max(salario) from cargo)
or salario = (select min(salario) from cargo);

/* 7 - Selecione o cliente e o produto comprado. */
select nome_produto, Cl.nome
from produtos as Pr
inner join item as I		on I.idPRODUTOS = Pr.idPRODUTOS
inner join compras as C		on C.idCOMPRAS = I.idCOMPRAS
inner join cliente as Cl	on Cl.idCLIENTE = C.idCLIENTE
order by nome_produto;

/* 8 - Selecione os produtos com defeito */
select nome_produto, descricao_defeito 
from produtos as P
inner join item as I		on I.idPRODUTOS = P.idPRODUTOS
inner join serviço as S		on S.idservico = I.idservico
inner join defeito as Df	on Df.idservico = S.idservico;

/* 9 - Selecione o endereco de todos os clientes  */
select Cl.nome, rua, numero_casa, cep 
from endereco as E
inner join cliente as Cl		on Cl.idCLIENTE = E.idCLIENTE
order by Cl.nome;

/* 10 - Selecione os produtos que não estão com defeito */
select S.idservico, Atividades_prestadas, descricao_defeito
from serviço as S
left join defeito as Df	on Df.idservico = S.idservico
where descricao_defeito is null
order by S.idservico ;

/* 11 - Selecionar Categoria por produto.*/
select nome_produto, divisão_produto aS Categoria
from produtos as P
inner join relação_categ as RC 		on RC.idPRODUTOS = P.idPRODUTOS
inner join 	categorias as C			on C.idCATEGORIAS = RC.idCATEGORIAS
group by nome_produto
order by nome_produto;

/* 12 - Selecione os produtos comprados, quantidade e preço frinal*/
select CL.nome, I.preço_final, nome_produto, I.quantidade 
from cliente as CL
inner join compras as C			on C.idCLIENTE = CL.idCLIENTE
inner join item as I			on I.idCOMPRAS = C.idCOMPRAS
inner join produtos as Pr 		on Pr.idPRODUTOS = I.idPRODUTOS;
