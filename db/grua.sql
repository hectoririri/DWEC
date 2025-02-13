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
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `accion` varchar(500) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `log_usuario_id_fk` (`usuario_id`),
  CONSTRAINT `log_usuario_id_fk` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.log: ~0 rows (aproximadamente)
DELETE FROM `log`;

-- Volcando estructura para tabla grua_municipal.retiradas
CREATE TABLE IF NOT EXISTS `retiradas` (
  `id` int(11) NOT NULL,
  `id_vehiculos` varchar(500) NOT NULL,
  `id_tarifa` bigint(20) DEFAULT NULL,
  `nombre` varchar(500) DEFAULT NULL,
  `nif` varchar(500) DEFAULT NULL,
  `domicilio` varchar(500) DEFAULT NULL,
  `poblacion` varchar(500) DEFAULT NULL,
  `provincia` varchar(500) DEFAULT NULL,
  `permiso` varchar(500) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `agente` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retiradas_id_tarifa_fk` (`id_tarifa`),
  KEY `retiradas_idvehiculos_fk` (`id_vehiculos`),
  CONSTRAINT `retiradas_id_tarifa_fk` FOREIGN KEY (`id_tarifa`) REFERENCES `tarrifa` (`id`),
  CONSTRAINT `retiradas_idvehiculos_fk` FOREIGN KEY (`id_vehiculos`) REFERENCES `vehiculos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.retiradas: ~0 rows (aproximadamente)
DELETE FROM `retiradas`;

-- Volcando estructura para tabla grua_municipal.tarrifa
CREATE TABLE IF NOT EXISTS `tarrifa` (
  `id` bigint(20) NOT NULL,
  `opcion_pago` varchar(500) DEFAULT NULL,
  `importe_retirada` float DEFAULT NULL,
  `importe_deposito` float DEFAULT NULL,
  `horas_gratis` float DEFAULT NULL,
  `costo_por_hora` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.tarrifa: ~0 rows (aproximadamente)
DELETE FROM `tarrifa`;

-- Volcando estructura para tabla grua_municipal.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` bigint(20) NOT NULL,
  `email` varchar(500) DEFAULT NULL,
  `password` varchar(500) DEFAULT NULL,
  `borrado` tinyint(1) DEFAULT NULL,
  `rol` varchar(500) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.usuario: ~0 rows (aproximadamente)
DELETE FROM `usuario`;

-- Volcando estructura para tabla grua_municipal.vehiculos
CREATE TABLE IF NOT EXISTS `vehiculos` (
  `id` varchar(500) NOT NULL,
  `fecha_entrada` datetime DEFAULT NULL,
  `fecha_salida` datetime DEFAULT NULL,
  `lugar` varchar(500) DEFAULT NULL,
  `direccion` varchar(500) DEFAULT NULL,
  `agente` varchar(500) DEFAULT NULL,
  `matricula` varchar(500) DEFAULT NULL,
  `marca` varchar(500) DEFAULT NULL,
  `modelo` varchar(500) DEFAULT NULL,
  `color` varchar(500) DEFAULT NULL,
  `motivo` varchar(500) DEFAULT NULL,
  `tipo_vehiculo` varchar(500) DEFAULT NULL,
  `grua` varchar(500) DEFAULT NULL,
  `estado` varchar(500) DEFAULT 'En depósito',
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.vehiculos: ~0 rows (aproximadamente)
DELETE FROM `vehiculos`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
