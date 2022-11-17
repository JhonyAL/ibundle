-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 02-Set-2022 às 14:40
-- Versão do servidor: 8.0.27
-- versão do PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `teste`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `avaliacao`
--

DROP TABLE IF EXISTS `avaliacao`;
CREATE TABLE IF NOT EXISTS `avaliacao` (
  `fk_Cliente_id` int DEFAULT NULL,
  `fk_Produtos_id` int DEFAULT NULL,
  `pontuacao` int DEFAULT NULL,
  `comentario` varchar(200) DEFAULT NULL,
  KEY `FK_Avaliacao_1` (`fk_Cliente_id`),
  KEY `FK_Avaliacao_2` (`fk_Produtos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int NOT NULL,
  `cpf` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `senha` varchar(200) DEFAULT NULL,
  `nome` varchar(200) DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `endereco`
--

DROP TABLE IF EXISTS `endereco`;
CREATE TABLE IF NOT EXISTS `endereco` (
  `id` int NOT NULL,
  `fk_Cliente_id` int DEFAULT NULL,
  `CEP` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Endereco_2` (`fk_Cliente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE IF NOT EXISTS `pedido` (
  `id` int NOT NULL,
  `fk_Cliente_id` int DEFAULT NULL,
  `fk_Vendedor_id` int DEFAULT NULL,
  `data_time` datetime DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `forma_pagamento` int DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `fk_Endereco_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Pedido_1` (`fk_Cliente_id`),
  KEY `FK_Pedido_2` (`fk_Vendedor_id`),
  KEY `FK_Pedido_4` (`fk_Endereco_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

DROP TABLE IF EXISTS `produtos`;
CREATE TABLE IF NOT EXISTS `produtos` (
  `id` int NOT NULL,
  `fk_Vendedor_id` int DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `quant` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `fotos` json DEFAULT NULL,
  `valor` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Produtos_2` (`fk_Vendedor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto_em_pedido`
--

DROP TABLE IF EXISTS `produto_em_pedido`;
CREATE TABLE IF NOT EXISTS `produto_em_pedido` (
  `fk_Pedido_id` int DEFAULT NULL,
  `fk_Produtos_id` int DEFAULT NULL,
  `quant` int DEFAULT NULL,
  KEY `FK_Produto_em_Pedido_1` (`fk_Pedido_id`),
  KEY `FK_Produto_em_Pedido_2` (`fk_Produtos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
CREATE TABLE IF NOT EXISTS `vendedor` (
  `id` int NOT NULL,
  `doc` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `senha` varchar(200) DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD CONSTRAINT `FK_Avaliacao_1` FOREIGN KEY (`fk_Cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `FK_Avaliacao_2` FOREIGN KEY (`fk_Produtos_id`) REFERENCES `produtos` (`id`);

--
-- Limitadores para a tabela `endereco`
--
ALTER TABLE `endereco`
  ADD CONSTRAINT `FK_Endereco_2` FOREIGN KEY (`fk_Cliente_id`) REFERENCES `cliente` (`id`);

--
-- Limitadores para a tabela `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `FK_Pedido_1` FOREIGN KEY (`fk_Cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `FK_Pedido_2` FOREIGN KEY (`fk_Vendedor_id`) REFERENCES `vendedor` (`id`),
  ADD CONSTRAINT `FK_Pedido_4` FOREIGN KEY (`fk_Endereco_id`) REFERENCES `endereco` (`id`);

--
-- Limitadores para a tabela `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `FK_Produtos_2` FOREIGN KEY (`fk_Vendedor_id`) REFERENCES `vendedor` (`id`);

--
-- Limitadores para a tabela `produto_em_pedido`
--
ALTER TABLE `produto_em_pedido`
  ADD CONSTRAINT `FK_Produto_em_Pedido_1` FOREIGN KEY (`fk_Pedido_id`) REFERENCES `pedido` (`id`),
  ADD CONSTRAINT `FK_Produto_em_Pedido_2` FOREIGN KEY (`fk_Produtos_id`) REFERENCES `produtos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
