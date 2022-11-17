/* Modelo_BD_BRModelo: */

CREATE TABLE Vendedor (
    id INT PRIMARY KEY,
    doc varchar(100),
    email varchar(100),
    senha varchar(200),
    descricao varchar(200),
    status INT
)engine=InnoDB;

CREATE TABLE Produtos (
    id INT PRIMARY KEY,
    fk_Vendedor_id INT,
    nome varchar(100),
    descricao varchar(200),
    quant INT,
    status INT,
    fotos JSON,
    valor DOUBLE
)engine=InnoDB;

CREATE TABLE Cliente (
    id INT PRIMARY KEY,
    cpf varchar(20),
    email varchar(100),
    senha varchar(200),
    nome varchar(200),
    telefone varchar(100),
    data_nasc DATE,
    status INT
)engine=InnoDB;

CREATE TABLE Pedido (
    id INT PRIMARY KEY,
    fk_Cliente_id INT,
    fk_Vendedor_id INT,
    data_time datetime,
    valor DOUBLE,
    forma_pagamento INT,
    observacao varchar(200),
    status INT,
    fk_Endereco_id int
)engine=InnoDB;

CREATE TABLE Produto_em_Pedido (
    fk_Pedido_id INT,
    fk_Produtos_id INT,
    quant int,
    opcoes JSON
)engine=InnoDB;

CREATE TABLE Endereco (
    id int PRIMARY KEY,
    fk_Cliente_id INT,
    CEP INT
)engine=InnoDB;

CREATE TABLE Avaliacao (
    fk_Cliente_id INT,
    fk_Produtos_id INT,
    pontuacao INT,
    comentario varchar(200)
)engine=InnoDB;

USE ibundle;

CREATE TABLE Adicional; (
    fk_Produtos_id INT,
    descricao varchar(200),
    status TINYINT,
    opcoes JSON,
    PRIMARY KEY (fk_Produtos_id)
)engine=InnoDB;
 
 
ALTER TABLE Produtos ADD CONSTRAINT FK_Produtos_2
    FOREIGN KEY (fk_Vendedor_id)
    REFERENCES Vendedor (id);
 
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_1
    FOREIGN KEY (fk_Cliente_id)
    REFERENCES Cliente (id);
 
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_2
    FOREIGN KEY (fk_Vendedor_id)
    REFERENCES Vendedor (id);
 
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_4
    FOREIGN KEY (fk_Endereco_id)
    REFERENCES Endereco (id);
 
ALTER TABLE Produto_em_Pedido ADD CONSTRAINT FK_Produto_em_Pedido_1
    FOREIGN KEY (fk_Pedido_id)
    REFERENCES Pedido (id);
 
ALTER TABLE Produto_em_Pedido ADD CONSTRAINT FK_Produto_em_Pedido_2
    FOREIGN KEY (fk_Produtos_id)
    REFERENCES Produtos (id);
 
ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_2
    FOREIGN KEY (fk_Cliente_id)
    REFERENCES Cliente (id);
 
ALTER TABLE Avaliacao ADD CONSTRAINT FK_Avaliacao_1
    FOREIGN KEY (fk_Cliente_id)
    REFERENCES Cliente (id);
 
ALTER TABLE Avaliacao ADD CONSTRAINT FK_Avaliacao_2
    FOREIGN KEY (fk_Produtos_id)
    REFERENCES Produtos (id);
 
ALTER TABLE Adicional ADD CONSTRAINT FK_Adicional_1
    FOREIGN KEY (fk_Produtos_id)
    REFERENCES Produtos (id);