/*Script para criação do banco de dados e tabelas
Só é possível executar uma única vez, depois de criado não se
cria objetos com mesmo nome.
Se precisar criar novamente tem que apagar o anterior
Apagar Banco de Dados: DROP DATABASE sistema_vendas;
*/
/*Criando banco de dados sistema_vendas*/
CREATE DATABASE sistema_vendas;

USE sistema_vendas;

/*Criando tabela cliente no banco de dados sistema_vendas*/
CREATE TABLE IF NOT EXISTS `sistema_vendas`.`cliente` (
  `cod_cliente` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `endereco` VARCHAR(150) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `cep` DECIMAL NULL,
  `uf` CHAR(2) NOT NULL,
  `cnpj` VARCHAR(16) NOT NULL,
  `ie` INT NULL,
  PRIMARY KEY (`cod_cliente`))
ENGINE = InnoDB;

/*Criando tabela vendedor no banco de dados sistema_vendas*/
CREATE TABLE IF NOT EXISTS `sistema_vendas`.`vendedor` (
  `cod_vendedor` INT NOT NULL,
  `nome` VARCHAR(100) NULL,
  `salario` FLOAT NULL,
  `faixa_comissao` CHAR(1) NULL,
  PRIMARY KEY (`cod_vendedor`))
ENGINE = InnoDB;

/*Criando tabela produto no banco de dados sistema_vendas*/
CREATE TABLE IF NOT EXISTS `sistema_vendas`.`produto` (
  `cod_produto` INT NOT NULL,
  `unidade` VARCHAR(10) NULL,
  `descricao` VARCHAR(200) NULL,
  `preco` FLOAT NULL,
  PRIMARY KEY (`cod_produto`))
ENGINE = InnoDB;

/*Criando tabela pedido no banco de dados sistema_vendas*/
CREATE TABLE IF NOT EXISTS `sistema_vendas`.`pedido` (
  `numero` DECIMAL NOT NULL,
  `prazo_entrega` DECIMAL NULL,
  `cod_cliente` INT NOT NULL,
  `cod_vendedor` INT NOT NULL,
  PRIMARY KEY (`numero`),
    FOREIGN KEY (`cod_cliente`)
    REFERENCES `sistema_vendas`.`Cliente` (`cod_cliente`),
    FOREIGN KEY (`cod_vendedor`)
    REFERENCES `sistema_vendas`.`Vendedor` (`cod_vendedor`))
ENGINE = InnoDB;

/*Criando tabela item_pedido no banco de dados sistema_vendas*/
CREATE TABLE IF NOT EXISTS `sistema_vendas`.`item_pedido` (
  `numero_pedido` DECIMAL NOT NULL,
  `cod_produto` INT NOT NULL,
  `quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`numero_pedido`, `cod_produto`),
    FOREIGN KEY (`numero_pedido`)  REFERENCES `sistema_vendas`.`Pedido` (`numero`),
    FOREIGN KEY (`cod_produto`)    REFERENCES `sistema_vendas`.`Produto` (`cod_produto`)
);