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


-- Volcando estructura de base de datos para grua_municipal
CREATE DATABASE IF NOT EXISTS `grua_municipal` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `grua_municipal`;

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.logs: ~16 rows (aproximadamente)
DELETE FROM `logs`;
INSERT INTO `logs` (`id`, `usuario_id`, `accion`, `descripcion`, `fecha`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:31:46', '2025-02-17 02:31:46', '2025-02-17 02:31:46'),
	(2, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:39:06', '2025-02-17 02:39:06', '2025-02-17 02:39:06'),
	(3, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:45:58', '2025-02-17 02:45:58', '2025-02-17 02:45:58'),
	(4, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:46:36', '2025-02-17 02:46:37', '2025-02-17 02:46:37'),
	(5, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:47:44', '2025-02-17 02:47:44', '2025-02-17 02:47:44'),
	(6, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:48:45', '2025-02-17 02:48:45', '2025-02-17 02:48:45'),
	(7, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:50:21', '2025-02-17 02:50:21', '2025-02-17 02:50:21'),
	(8, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:52:08', '2025-02-17 02:52:08', '2025-02-17 02:52:08'),
	(9, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 02:55:32', '2025-02-17 02:55:32', '2025-02-17 02:55:32'),
	(10, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 03:01:12', '2025-02-17 03:01:12', '2025-02-17 03:01:12'),
	(11, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 03:05:07', '2025-02-17 03:05:07', '2025-02-17 03:05:07'),
	(12, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 03:06:17', '2025-02-17 03:06:17', '2025-02-17 03:06:17'),
	(13, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 03:07:54', '2025-02-17 03:07:54', '2025-02-17 03:07:54'),
	(14, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 03:11:40', '2025-02-17 03:11:40', '2025-02-17 03:11:40'),
	(15, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 03:13:36', '2025-02-17 03:13:36', '2025-02-17 03:13:36'),
	(16, 1, 'Loggin', 'El usuario ha iniciado sesiÃ³n', '2025-02-17 03:15:13', '2025-02-17 03:15:13', '2025-02-17 03:15:13');

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
  CONSTRAINT `retiradas_id_tarifa_fk` FOREIGN KEY (`id_tarifa`) REFERENCES `tarifas` (`id`),
  CONSTRAINT `retiradas_idvehiculos_fk` FOREIGN KEY (`id_vehiculos`) REFERENCES `vehiculos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.retiradas: ~0 rows (aproximadamente)
DELETE FROM `retiradas`;

-- Volcando estructura para tabla grua_municipal.tarifas
CREATE TABLE IF NOT EXISTS `tarifas` (
  `id` bigint(20) NOT NULL,
  `opcion_pago` varchar(500) DEFAULT NULL,
  `importe_retirada` float DEFAULT NULL,
  `importe_deposito` float DEFAULT NULL,
  `horas_gratis` float DEFAULT NULL,
  `costo_por_hora` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.tarifas: ~0 rows (aproximadamente)
DELETE FROM `tarifas`;

-- Volcando estructura para tabla grua_municipal.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` bigint(20) NOT NULL,
  `email` varchar(500) DEFAULT NULL,
  `password` varchar(500) DEFAULT NULL,
  `borrado` tinyint(1) DEFAULT NULL,
  `rol` varchar(500) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.usuarios: ~4 rows (aproximadamente)
DELETE FROM `usuarios`;
INSERT INTO `usuarios` (`id`, `email`, `password`, `borrado`, `rol`, `deleted_at`) VALUES
	(1, 'admin', 'admin', 0, 'administrador', NULL),
	(2, 'maria@example.com', 'pass456', 0, 'usuario', NULL),
	(3, 'pedro@example.com', 'securepass', 0, 'administrador', NULL),
	(4, 'laura@example.com', 'mypassword', 0, 'usuario', NULL);

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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.vehiculos: ~4 rows (aproximadamente)
DELETE FROM `vehiculos`;
INSERT INTO `vehiculos` (`id`, `fecha_entrada`, `fecha_salida`, `lugar`, `direccion`, `agente`, `matricula`, `marca`, `modelo`, `color`, `motivo`, `tipo_vehiculo`, `grua`, `estado`, `fecha`, `deleted_at`) VALUES
	('VHCL0001', '2023-10-01 10:00:00', '2023-10-03 12:00:00', 'Plaza Mayor', 'Calle Real, 12', 'Agente01', '1234ABC', 'Toyota', 'Corolla', 'Rojo', 'Estacionamiento indebido', 'Turismo', 'Grua01', 'Retirado', '2023-10-01 10:00:00', NULL),
	('VHCL0002', '2023-10-02 11:30:00', '2023-10-04 14:30:00', 'Parque Central', 'Avenida Principal, 5', 'Agente02', '5678XYZ', 'Ford', 'Focus', 'Azul', 'Accidente', 'Turismo', 'Grua02', 'Retirado', '2023-10-02 11:30:00', NULL),
	('VHCL0003', '2023-10-03 09:15:00', NULL, 'Zona Industrial', 'Calle Industria, 7', 'Agente03', '9012DEF', 'Renault', 'Clio', 'Blanco', 'Abandono', 'Turismo', 'Grua03', 'En depósito', '2023-10-03 09:15:00', NULL),
	('VHCL0004', '2023-10-04 13:45:00', NULL, 'Centro Comercial', 'Calle Comercio, 10', 'Agente04', '3456GHI', 'Seat', 'Ibiza', 'Negro', 'Obstrucción de tráfico', 'Turismo', 'Grua04', 'En depósito', '2023-10-04 13:45:00', NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
