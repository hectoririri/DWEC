-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.9.0.6999
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para grua_municipal
CREATE DATABASE IF NOT EXISTS `grua_municipal` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `grua_municipal`;

-- Volcando estructura para tabla grua_municipal.log
CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` varchar(50) NOT NULL DEFAULT '',
  `descripcion` text NOT NULL,
  `fecha_accion` datetime NOT NULL,
  KEY `Índice 1` (`id`),
  KEY `FK_log_usuarios` (`usuario_id`),
  CONSTRAINT `FK_log_usuarios` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Logs de las acciones del usuario jandemorguennnn';

-- Volcando datos para la tabla grua_municipal.log: ~0 rows (aproximadamente)
DELETE FROM `log`;

-- Volcando estructura para tabla grua_municipal.precio_tipo
CREATE TABLE IF NOT EXISTS `precio_tipo` (
  `tipo` varchar(50) DEFAULT NULL,
  `coste` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.precio_tipo: ~0 rows (aproximadamente)
DELETE FROM `precio_tipo`;

-- Volcando estructura para tabla grua_municipal.retiradas
CREATE TABLE IF NOT EXISTS `retiradas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idvehiculos` varchar(10) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `nif` varchar(15) DEFAULT NULL,
  `domicilio` varchar(150) DEFAULT NULL,
  `poblacion` varchar(50) DEFAULT NULL,
  `provincia` varchar(50) DEFAULT NULL,
  `permiso` varchar(20) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `agente` varchar(20) DEFAULT NULL,
  `opcionespago` varchar(20) DEFAULT NULL,
  `id_tarifa` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_retiradas_vehiculos` (`idvehiculos`),
  KEY `FK_retiradas_tarifa` (`id_tarifa`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla grua_municipal.retiradas: 0 rows
DELETE FROM `retiradas`;
/*!40000 ALTER TABLE `retiradas` DISABLE KEYS */;
/*!40000 ALTER TABLE `retiradas` ENABLE KEYS */;

-- Volcando estructura para tabla grua_municipal.tarifa
CREATE TABLE IF NOT EXISTS `tarifa` (
  `id` int(11) DEFAULT NULL,
  `horas_gratis` float DEFAULT NULL,
  `importe_retirada` float DEFAULT NULL,
  `importe_deposito` float DEFAULT NULL,
  `costo_hora` float DEFAULT NULL,
  `total` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Tarifas aplicadas con los precios';

-- Volcando datos para la tabla grua_municipal.tarifa: ~0 rows (aproximadamente)
DELETE FROM `tarifa`;

-- Volcando estructura para tabla grua_municipal.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) DEFAULT NULL,
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `borrado` tinyint(4) NOT NULL,
  `rol` enum('A','U') DEFAULT NULL,
  KEY `Índice 1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Usuarios almacenados en la base de datos para autenticarse en la aplicación';

-- Volcando datos para la tabla grua_municipal.usuarios: ~0 rows (aproximadamente)
DELETE FROM `usuarios`;

-- Volcando estructura para tabla grua_municipal.vehiculos
CREATE TABLE IF NOT EXISTS `vehiculos` (
  `id` varchar(10) NOT NULL DEFAULT '',
  `fecha_entrada` datetime NOT NULL,
  `fecha_salida` datetime NOT NULL,
  `lugar` varchar(100) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `agente` varchar(20) NOT NULL,
  `matricula` varchar(10) NOT NULL,
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `color` varchar(50) DEFAULT NULL,
  `motivo` varchar(200) NOT NULL DEFAULT '',
  `tipo_vehiculo` varchar(100) NOT NULL DEFAULT '',
  `grua` varchar(50) NOT NULL,
  `estado` varchar(20) DEFAULT 'En depósito',
  `deleted_at` datetime DEFAULT NULL,
  KEY `Índice 1` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2025000 DEFAULT CHARSET=ucs2 COLLATE=ucs2_general_ci;

-- Volcando datos para la tabla grua_municipal.vehiculos: 0 rows
DELETE FROM `vehiculos`;
/*!40000 ALTER TABLE `vehiculos` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehiculos` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
