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
INSERT INTO `liquidacion` (`id`, `id_retirada`, `nombre`, `nif`, `domicilio`, `poblacion`, `provincia`, `permiso`, `fecha`, `agente`, `importe_retirada`, `importe_deposito`, `total`, `opciones_pago`) VALUES
	(1, 20250001, 'Juan Pérez García', '12345678A', 'Calle Luna 15', 'Almonte', 'Huelva', 'B-12345', '2025-02-27 16:30:00', 'Agente García Pérez', 100.00, 0.00, 100.00, 'Tarjeta'),
	(2, 20250002, 'María López Ruiz', '87654321B', 'Avenida Sol 28', 'Almonte', 'Huelva', 'A-54321', '2025-02-28 09:15:00', 'Agente Martínez López', 25.00, 16.00, 41.00, 'Metálico'),
	(3, 20250003, 'Carlos Sánchez Mora', '11223344C', 'Plaza España 3', 'Almonte', 'Huelva', 'B-98765', '2025-02-28 10:00:00', 'Agente Ruiz Santos', 130.00, 0.00, 130.00, 'Bizum');

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

-- Volcando datos para la tabla grua_municipal.logs: ~1 rows (aproximadamente)
DELETE FROM `logs`;
INSERT INTO `logs` (`id`, `usuario_id`, `accion`, `descripcion`, `fecha`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-27 04:10:52', '2025-02-27 03:10:52', '2025-02-27 03:10:52'),
	(2, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-27 04:35:55', '2025-02-27 03:35:55', '2025-02-27 03:35:55'),
	(3, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-27 04:36:22', '2025-02-27 03:36:22', '2025-02-27 03:36:22'),
	(4, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-27 04:37:54', '2025-02-27 03:37:54', '2025-02-27 03:37:54'),
	(5, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-27 04:38:01', '2025-02-27 03:38:01', '2025-02-27 03:38:01'),
	(6, 1, 'Modificación vehículo', 'El administrador ha modificado el vehículo 20250001', '2025-02-27 04:48:00', '2025-02-27 03:48:00', '2025-02-27 03:48:00'),
	(7, 1, 'Modificación vehículo', 'El administrador ha modificado el vehículo 20250002', '2025-02-27 04:48:14', '2025-02-27 03:48:14', '2025-02-27 03:48:14'),
	(8, 1, 'Modificación vehículo', 'El administrador ha modificado el vehículo 20250003', '2025-02-27 04:48:20', '2025-02-27 03:48:20', '2025-02-27 03:48:20');

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
INSERT INTO `retiradas` (`id`, `fecha_entrada`, `fecha_salida`, `lugar`, `direccion`, `agente`, `matricula`, `marca`, `modelo`, `color`, `motivo`, `tipo_vehiculo`, `grua`, `estado`, `deleted_at`) VALUES
	(20250001, '2025-02-26 10:00:00', NULL, 'Zona Centro', 'Calle Real 123', 'Agente García Pérez', '1234ABC', 'Volkswagen', 'Golf', 'Negro', 'Estacionamiento prohibido', 'Turismo hasta 12 cv o Remolques hasta 750 kg', 'Grua Norte', 'En depósito', NULL),
	(20250002, '2025-02-27 11:30:00', '2025-02-28 09:15:00', 'Zona Norte', 'Avenida Principal 45', 'Agente Martínez López', '5678DEF', 'Honda', 'CBR600', 'Rojo', 'Abandono', 'Motocicleta, aperos, motocarros y similares', 'Grua Norte', 'Retirado', NULL),
	(20250003, '2025-02-21 15:45:00', NULL, 'Zona Sur', 'Plaza Mayor 7', 'Agente Ruiz Santos', '9012GHI', 'Mercedes', 'Clase C', 'Blanco', 'Doble fila', 'Turismos más de 12 cv o Remolques más de 750 kg', 'Grua Ajandemol', 'En depósito', NULL);

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
