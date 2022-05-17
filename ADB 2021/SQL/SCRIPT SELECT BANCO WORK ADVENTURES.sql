use AdventureWorks2016
go
select * from Person.Person
go

select count(*) from Person.Person
go


select count(*) from Person.Address
go


/*Fazer a consulta e contar os produtos por categoria*/


select * from Production.Product
go
select * from Production.ProductCategory
go
select * from Production.ProductSubcategory



select count(*) from Production.Product
go
select count(*) from Production.ProductCategory
go
select count(*) from Production.ProductSubcategory
go

select p.name as nome_produto , sb.Name as sub_categoria ,
       pc.Name as nome_categoria
       from Production.Product as p 
  left join Production.ProductSubcategory as sb
         on p.ProductSubcategoryID = sb.ProductSubcategoryID
  left join Production.ProductCategory as pc
         on pc.ProductCategoryID = sb.ProductCategoryID
go
/* count e group by
  Contar quantos produtos tem por categoria*/

select count(p.productID) as Produtos, pc.Name
from Production.Product as p
	inner join Production.ProductSubcategory as sb
         on p.ProductSubcategoryID = sb.ProductSubcategoryID
	inner join Production.ProductCategory as pc
         on pc.ProductCategoryID = sb.ProductCategoryID
		 group by pc.Name
go

/*Contar quantos subcategorias tem por categoria*/
select count(ProductSubcategoryID) as SubCategorias, pc.Name 
from Production.ProductSubcategory as sb
	inner join Production.ProductCategory as pc
         on pc.ProductCategoryID = sb.ProductCategoryID
		 group by pc.Name
go

/*Contar quantos produtos tem por sub categoria*/
select count(productID) as Produtos, sb.Name
from Production.Product as p
	inner join Production.ProductSubcategory as sb
         on p.ProductSubcategoryID = sb.ProductSubcategoryID
		 group by sb.Name
go

/*Fazer a consulta e Person (pessoa) - AddressType - Address*/
select * from Person.Person
go
select * from Person.AddressType
go
select * from Person.Address
go

/*Fazer a consulta de empregado (emplooyer) e Departamento */
select * from HumanResources.Employee
go
select * from HumanResources.Department
go

/*Fazer a consulta de empregado (emplooyer) e Departamento Historico*/
select * from HumanResources.Employee
go
select * from HumanResources.EmployeeDepartmentHistory
go

/*Selecionar dados fazendo inner join com as tabelas abaixo
  loja (Store) - name
  Cliente (customer) - customerID
  VendasTerritorio - SalesTerritory - name - country region code 
  Vendas - SalesOrderHearder - data pedido - data entrega - numero pedido
  Itens do pedido - SalesOrderDetail - quantidade - preco unitario 
  Production Produto - Production - name (nome) produto*/


select * from Sales.store
go

/*Fazer a consulta e Person (pessoa) - AddressType - Address*/
/*Fazer a consulta de empregado (emplooyer) e Departamento */
/*Fazer a consulta de empregado (emplooyer) e Departamento Historico*/