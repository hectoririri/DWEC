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

-- Insertar 4 usuarios
INSERT INTO `usuario` (`id`, `email`, `password`, `borrado`, `rol`, `deleted_at`) VALUES
(1, 'juan@example.com', 'password123', 0, 'administrador', NULL),
(2, 'maria@example.com', 'pass456', 0, 'usuario', NULL),
(3, 'pedro@example.com', 'securepass', 0, 'administrador', NULL),
(4, 'laura@example.com', 'mypassword', 0, 'usuario', NULL);

-- Insertar 4 vehículos
INSERT INTO `vehiculos` (`id`, `fecha_entrada`, `fecha_salida`, `lugar`, `direccion`, `agente`, `matricula`, `marca`, `modelo`, `color`, `motivo`, `tipo_vehiculo`, `grua`, `estado`, `fecha`) VALUES
('VHCL0001', '2023-10-01 10:00:00', '2023-10-03 12:00:00', 'Plaza Mayor', 'Calle Real, 12', 'Agente01', '1234ABC', 'Toyota', 'Corolla', 'Rojo', 'Estacionamiento indebido', 'Turismo', 'Grua01', 'Retirado', '2023-10-01 10:00:00'),
('VHCL0002', '2023-10-02 11:30:00', '2023-10-04 14:30:00', 'Parque Central', 'Avenida Principal, 5', 'Agente02', '5678XYZ', 'Ford', 'Focus', 'Azul', 'Accidente', 'Turismo', 'Grua02', 'Retirado', '2023-10-02 11:30:00'),
('VHCL0003', '2023-10-03 09:15:00', NULL, 'Zona Industrial', 'Calle Industria, 7', 'Agente03', '9012DEF', 'Renault', 'Clio', 'Blanco', 'Abandono', 'Turismo', 'Grua03', 'En depósito', '2023-10-03 09:15:00'),
('VHCL0004', '2023-10-04 13:45:00', NULL, 'Centro Comercial', 'Calle Comercio, 10', 'Agente04', '3456GHI', 'Seat', 'Ibiza', 'Negro', 'Obstrucción de tráfico', 'Turismo', 'Grua04', 'En depósito', '2023-10-04 13:45:00');

-- Insertar 4 tarifas
INSERT INTO `tarifa` (`id`, `opcion_pago`, `importe_retirada`, `importe_deposito`, `horas_gratis`, `costo_por_hora`, `total`) VALUES
(1, 'Efectivo', 50.0, 20.0, 2, 10.0, 80.0),
(2, 'Tarjeta', 60.0, 25.0, 1, 12.0, 97.0),
(3, 'Transferencia', 70.0, 30.0, 0, 15.0, 115.0),
(4, 'Efectivo', 45.0, 15.0, 3, 8.0, 68.0);

-- Insertar 4 retiradas
INSERT INTO `retiradas` (`id`, `id_vehiculos`, `id_tarifa`, `nombre`, `nif`, `domicilio`, `poblacion`, `provincia`, `permiso`, `fecha`, `agente`) VALUES
(1, 'VHCL0001', 1, 'Juan Pérez', '12345678A', 'Calle Real, 12', 'Ciudad', 'Provincia', 'B1234567', '2023-10-03 12:00:00', 'Agente01'),
(2, 'VHCL0002', 2, 'María García', '87654321B', 'Avenida Principal, 5', 'Ciudad', 'Provincia', 'C7654321', '2023-10-04 14:30:00', 'Agente02'),
(3, 'VHCL0003', 3, 'Pedro Martínez', '19283746C', 'Calle Industria, 7', 'Ciudad', 'Provincia', 'D8765432', '2023-10-05 10:00:00', 'Agente03'),
(4, 'VHCL0004', 4, 'Laura López', '23456789D', 'Calle Comercio, 10', 'Ciudad', 'Provincia', 'E9876543', '2023-10-06 11:30:00', 'Agente04');

-- Insertar 4 registros de log
INSERT INTO `log` (`id`, `usuario_id`, `accion`, `descripcion`, `fecha`) VALUES
(1, 1, 'Inicio de sesión', 'El usuario Juan ha iniciado sesión', '2023-10-01 08:00:00'),
(2, 2, 'Edición de vehículo', 'El usuario María ha editado un vehículo', '2023-10-02 09:30:00'),
(3, 3, 'Eliminación de registro', 'El usuario Pedro ha eliminado un registro', '2023-10-03 11:00:00'),
(4, 4, 'Creación de retirada', 'El usuario Laura ha creado una nueva retirada', '2023-10-04 14:00:00');