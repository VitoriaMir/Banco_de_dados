-- -----------------------------------------------------
-- Schema trabalho_computador
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS trabalho_computador;
USE trabalho_computador;

-- -----------------------------------------------------
-- Table .forma_pagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.forma_pagamento (
  idforma_pagamento INT NOT NULL,
  modo_Pagamento VARCHAR(45) NOT NULL,
  PRIMARY KEY (idforma_pagamento))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table trabalho_computador.cargo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.cargo (
  idcargo INT NOT NULL,
  nome_cargo VARCHAR(100) NOT NULL,
  salario FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (idcargo))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.categorias
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.categorias (
  idcategorias INT NOT NULL,
  divisao_produto VARCHAR(45) NOT NULL,
  PRIMARY KEY (idcategorias))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.estado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.estado (
  idestado INT NOT NULL,
  nome_estado VARCHAR(60) NOT NULL,
  sigla VARCHAR(2) NOT NULL,
  PRIMARY KEY (idestado))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.cidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.cidade (
  idcidade INT NOT NULL,
  nome_cidade VARCHAR(60) NOT NULL,
  idestado INT NOT NULL,
  PRIMARY KEY (idcidade),
  INDEX fk_cidade_estado1_idx (idestado ASC) ,
    FOREIGN KEY (idestado)
    REFERENCES trabalho_computador.estado (idestado))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.cliente (
  idcliente INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  email varchar(90) null,
  PRIMARY KEY (idcliente))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.compras
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.compras (
  idcompras INT NOT NULL,
  cancelar_compras ENUM('SIM', 'NÃO') NOT NULL,
  idcliente INT NOT NULL,
  PRIMARY KEY (idcompras), 
  INDEX fk_compras_cliente1_idx (idcliente asc),
    FOREIGN KEY (idcliente)
    REFERENCES trabalho_computador.cliente (idcliente))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.servico (
  idservico INT NOT NULL,
  Atividades_prestadas TEXT NOT NULL,
  responsavel_conserto VARCHAR(45) NOT NULL,
  tempo_gasto TIME NULL DEFAULT NULL,
  data_entrega DATE NOT NULL,
  idcliente INT NOT NULL,
  PRIMARY KEY (idservico),
  INDEX fk_servico_cliente_idx (idcliente ASC) ,
    FOREIGN KEY (idcliente)
    REFERENCES trabalho_computador.cliente (idcliente))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.defeito
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.defeito (
  iddefeito INT NOT NULL,
  descricao_defeito VARCHAR(200) NULL DEFAULT NULL,
  idservico INT NOT NULL,
  PRIMARY KEY (iddefeito, idservico),
  INDEX fk_defeito_servico1_idx (idservico ASC) ,
    FOREIGN KEY (idservico)
    REFERENCES trabalho_computador.servico (idservico))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.produtos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.produtos (
  idprodutos INT NOT NULL,
  nome_produto VARCHAR(60) NOT NULL,
  Quantidade_estoqe INT NOT NULL,
  preço DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (idprodutos))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.detalhes_produtos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.detalhes_produtos (
  iddetalhes_produtos INT NOT NULL,
  descricao_detalhes VARCHAR(400) NOT NULL,
  idprodutos INT NOT NULL,
  PRIMARY KEY (iddetalhes_produtos),
  INDEX fk_detalhes_produtos_produtos1_idx (idprodutos ASC) ,
    FOREIGN KEY (idprodutos)
    REFERENCES trabalho_computador.produtos (idprodutos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.endereco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.endereco (
  idendereco INT NOT NULL,
  rua VARCHAR(60) NOT NULL,
  numero_casa INT NOT NULL,
  complemento VARCHAR(45) NULL DEFAULT NULL,
  referencia VARCHAR(45) NULL DEFAULT NULL,
  idcliente INT NOT NULL,
  idcidade INT NOT NULL,
  CEP VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (idendereco, idcliente),
  INDEX fk_endereco_cliente1_idx (idcliente ASC) ,
  INDEX fk_endereco_cidade1_idx (idcidade ASC) ,
  INDEX fk_endereco_LOJA_COMPUTADOR1_idx (CEP ASC) ,
    FOREIGN KEY (idcliente)
    REFERENCES trabalho_computador.cliente (idcliente),
    FOREIGN KEY (idcidade)
    REFERENCES trabalho_computador.cidade (idcidade))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.funcionarios
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.funcionarios (
  Matricula INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  RG INT NOT NULL,
  CPF VARCHAR(16) NOT NULL,
  Data_nascimento DATE NOT NULL,
  idcargo INT NULL DEFAULT NULL,
  idendereco INT NULL DEFAULT NULL,
  idcliente INT NULL DEFAULT NULL,
  PRIMARY KEY (Matricula),
  INDEX fk_FUNCIONARIOS_cargo1_idx (idcargo ASC) ,
  INDEX fk_FUNCIONARIOS_endereco1_idx (idendereco ASC, idcliente ASC) ,
  INDEX idcliente_idx (idcliente ASC) ,
    FOREIGN KEY (idcliente)
    REFERENCES trabalho_computador.cliente (idcliente),
    FOREIGN KEY (idcargo)
    REFERENCES trabalho_computador.cargo (idcargo),
    FOREIGN KEY (idendereco)
    REFERENCES trabalho_computador.endereco (idendereco))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table trabalho_computador.item
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.item (
  idITEM INT NOT NULL,
  quantidade INT NOT NULL,
  preco_final DECIMAL(65,2) NOT NULL,
  idcompras INT NOT NULL,
  idservico INT NOT NULL,
  idprodutos INT NOT NULL,
  PRIMARY KEY (idITEM),
  INDEX fk_ITEM_compras1_idx (idcompras ASC) ,
  INDEX fk_ITEM_servico1_idx (idservico ASC) ,
  INDEX fk_ITEM_produtos1_idx (idprodutos ASC) ,
    FOREIGN KEY (idprodutos)
    REFERENCES trabalho_computador.produtos (idprodutos),
    FOREIGN KEY (idservico)
    REFERENCES trabalho_computador.servico (idservico),
    FOREIGN KEY (idcompras)
    REFERENCES trabalho_computador.compras (idcompras))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table trabalho_computador.nota_fiscal
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.nota_fiscal (
  idnota_fiscal INT NOT NULL,
  Data_emissao DATETIME NOT NULL,
  idservico INT NOT NULL,
  idcompras INT NOT NULL,
  PRIMARY KEY (idnota_fiscal),
  INDEX fk_nota_fiscal_servico1_idx (idservico ASC) ,
  INDEX fk_nota_fiscal_compras1_idx (idcompras ASC) ,
    FOREIGN KEY (idservico)
    REFERENCES trabalho_computador.servico (idservico),
    FOREIGN KEY (idcompras)
    REFERENCES trabalho_computador.compras (idcompras))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table trabalho_computador.pecas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.pecas (
  idPecas INT NOT NULL,
  nome_peca VARCHAR(60) NOT NULL,
  PRIMARY KEY (idPecas))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table trabalho_computador.rl_categ
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.rl_categ (
  idprodutos INT NOT NULL,
  idcategorias INT NOT NULL,
  PRIMARY KEY (idprodutos, idcategorias),
  INDEX fk_rl_categ_categorias1_idx (idcategorias ASC) ,
    FOREIGN KEY (idprodutos)
    REFERENCES trabalho_computador.produtos (idprodutos),
    FOREIGN KEY (idcategorias)
    REFERENCES trabalho_computador.categorias (idcategorias))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table trabalho_computador.rl_defeito_conserto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.rl_defeito_conserto (
  idrl_defeito_conserto INT NOT NULL,
  iddefeito INT NOT NULL,
  idservico INT NOT NULL,
  idPecas INT NULL DEFAULT NULL,
  PRIMARY KEY (idrl_defeito_conserto),
  INDEX fk_rl_defeito_conserto_defeito1_idx (iddefeito ASC, idservico ASC) ,
  INDEX fk_rl_defeito_conserto_Pecas1_idx (idPecas ASC) ,
  INDEX idservico_idx (idservico ASC) ,
    FOREIGN KEY (iddefeito)
    REFERENCES trabalho_computador.defeito (iddefeito),
    FOREIGN KEY (idservico)
    REFERENCES trabalho_computador.servico (idservico),
    FOREIGN KEY (idPecas)
    REFERENCES trabalho_computador.pecas (idPecas))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table trabalho_computador.rl_pagar
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.rl_pagar (
  idrl_pagar INT NOT NULL,
  Valor_final DECIMAL(65,2) NOT NULL,
  idforma_pagamento INT NOT NULL,
  idcompras INT NOT NULL,
  idservico INT NOT NULL,
  PRIMARY KEY (idrl_pagar, idcompras, idservico),
  INDEX fk_rl_pagar_forma_pagamento1_idx (idforma_pagamento ASC) ,
  INDEX fk_rl_pagar_compras1_idx (idcompras ASC) ,
  INDEX fk_rl_pagar_servico1_idx (idservico ASC) ,
    FOREIGN KEY (idforma_pagamento)
    REFERENCES trabalho_computador.forma_pagamento (idforma_pagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idcompras)
    REFERENCES trabalho_computador.compras (idcompras)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (idservico)
    REFERENCES trabalho_computador.servico (idservico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table trabalho_computador.telefone
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabalho_computador.telefone (
  idTELEFONE INT NOT NULL,
  DDD VARCHAR(2) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  idcliente INT NOT NULL,
  PRIMARY KEY (idTELEFONE),
  INDEX fk_TELEFONE_cliente1_idx (idcliente ASC) ,
    FOREIGN KEY (idcliente)
    REFERENCES trabalho_computador.cliente (idcliente))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
