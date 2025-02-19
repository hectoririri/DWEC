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
