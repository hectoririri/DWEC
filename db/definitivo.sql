-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla grua_municipal.liquidacion
CREATE TABLE IF NOT EXISTS `liquidacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_retirada` bigint(20) NOT NULL,
  `nombre` varchar(500) DEFAULT NULL,
  `nif` varchar(500) DEFAULT NULL,
  `domicilio` varchar(500) DEFAULT NULL,
  `poblacion` varchar(500) DEFAULT NULL,
  `provincia` varchar(500) DEFAULT NULL,
  `permiso` varchar(500) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `agente` varchar(500) DEFAULT NULL,
  `importe_retirada` decimal(20,2) DEFAULT NULL,
  `importe_deposito` decimal(20,2) DEFAULT NULL,
  `total` decimal(20,2) DEFAULT NULL,
  `opciones_pago` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_liquidacion_retiradas` (`id_retirada`),
  CONSTRAINT `FK_liquidacion_retiradas` FOREIGN KEY (`id_retirada`) REFERENCES `retiradas` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.liquidacion: ~0 rows (aproximadamente)
DELETE FROM `liquidacion`;

-- Volcando estructura para tabla grua_municipal.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint(20) NOT NULL,
  `accion` varchar(500) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `log_usuario_id_fk` (`usuario_id`),
  CONSTRAINT `log_usuario_id_fk` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.logs: ~0 rows (aproximadamente)
DELETE FROM `logs`;
INSERT INTO `logs` (`id`, `usuario_id`, `accion`, `descripcion`, `fecha`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-27 04:10:52', '2025-02-27 03:10:52', '2025-02-27 03:10:52');

-- Volcando estructura para tabla grua_municipal.precios
CREATE TABLE IF NOT EXISTS `precios` (
  `tipo_vehiculo` varchar(200) NOT NULL,
  `precio` decimal(20,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.precios: ~6 rows (aproximadamente)
DELETE FROM `precios`;
INSERT INTO `precios` (`tipo_vehiculo`, `precio`) VALUES
	('Motocicleta, aperos, motocarros y similares', 25.00),
	('Turismo hasta 12 cv ó Remolques hasta 750 kg', 100.00),
	('Turismos más de 12 cv ó Remolques más de 750 kg', 130.00),
	('Vehículos especiales', 150.00),
	('Vehículos de cortesía', 0.00),
	('Chatarra', 0.00);

-- Volcando estructura para tabla grua_municipal.retiradas
CREATE TABLE IF NOT EXISTS `retiradas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.retiradas: ~0 rows (aproximadamente)
DELETE FROM `retiradas`;

-- Volcando estructura para tabla grua_municipal.tarifas
CREATE TABLE IF NOT EXISTS `tarifas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `horas_gratis` float DEFAULT NULL,
  `costo_por_hora` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.tarifas: ~1 rows (aproximadamente)
DELETE FROM `tarifas`;
INSERT INTO `tarifas` (`id`, `horas_gratis`, `costo_por_hora`) VALUES
	(1, 24, 4);

-- Volcando estructura para tabla grua_municipal.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(500) DEFAULT NULL,
  `password` varchar(500) DEFAULT NULL,
  `rol` varchar(500) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.usuarios: ~4 rows (aproximadamente)
DELETE FROM `usuarios`;
INSERT INTO `usuarios` (`id`, `email`, `password`, `rol`, `deleted_at`) VALUES
	(1, 'admin', 'admin', 'administrador', NULL),
	(3, 'operario1@grua.com', 'Op123456', 'operario', NULL),
	(4, 'supervisor@grua.com', 'Sup123456', 'administrador', NULL),
	(12, 'operario2@grua.com', 'Op123456', 'operario', NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
