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

-- Volcando estructura para tabla grua_municipal.liquidacion
CREATE TABLE IF NOT EXISTS `liquidacion` (
  `id` int(11) NOT NULL,
  `id_retirada` varchar(500) NOT NULL,
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
  KEY `FK_liquidacion_retiradas` (`id_retirada`),
  CONSTRAINT `FK_liquidacion_retiradas` FOREIGN KEY (`id_retirada`) REFERENCES `retiradas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `retiradas_id_tarifa_fk` FOREIGN KEY (`id_tarifa`) REFERENCES `tarifas` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.logs: ~175 rows (aproximadamente)
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
	(16, 1, 'Loggin', 'El usuario ha iniciado sesiÃ³n', '2025-02-17 03:15:13', '2025-02-17 03:15:13', '2025-02-17 03:15:13'),
	(17, 1, 'Loggin', 'El usuario ha iniciado sesiÃ³n', '2025-02-17 03:17:37', '2025-02-17 03:17:37', '2025-02-17 03:17:37'),
	(18, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 03:18:09', '2025-02-17 03:18:09', '2025-02-17 03:18:09'),
	(19, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 11:48:34', '2025-02-17 11:48:35', '2025-02-17 11:48:35'),
	(20, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 11:50:09', '2025-02-17 11:50:09', '2025-02-17 11:50:09'),
	(21, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 11:51:02', '2025-02-17 11:51:02', '2025-02-17 11:51:02'),
	(22, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 11:51:28', '2025-02-17 11:51:28', '2025-02-17 11:51:28'),
	(23, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 11:52:33', '2025-02-17 11:52:33', '2025-02-17 11:52:33'),
	(24, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 11:53:48', '2025-02-17 11:53:48', '2025-02-17 11:53:48'),
	(25, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 11:54:08', '2025-02-17 11:54:08', '2025-02-17 11:54:08'),
	(26, 1, 'Loggin', 'El usuario ha iniciado sesión', '2025-02-17 11:55:13', '2025-02-17 11:55:13', '2025-02-17 11:55:13'),
	(27, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 12:55:15', '2025-02-17 11:55:15', '2025-02-17 11:55:15'),
	(28, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 12:55:22', '2025-02-17 11:55:22', '2025-02-17 11:55:22'),
	(29, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 12:56:17', '2025-02-17 11:56:18', '2025-02-17 11:56:18'),
	(30, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:25:05', '2025-02-17 22:25:05', '2025-02-17 22:25:05'),
	(31, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:31:22', '2025-02-17 22:31:22', '2025-02-17 22:31:22'),
	(32, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:40:36', '2025-02-17 22:40:37', '2025-02-17 22:40:37'),
	(33, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:41:28', '2025-02-17 22:41:29', '2025-02-17 22:41:29'),
	(34, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:41:44', '2025-02-17 22:41:45', '2025-02-17 22:41:45'),
	(35, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:44:34', '2025-02-17 22:44:34', '2025-02-17 22:44:34'),
	(36, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:45:35', '2025-02-17 22:45:36', '2025-02-17 22:45:36'),
	(37, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:49:43', '2025-02-17 22:49:43', '2025-02-17 22:49:43'),
	(38, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:50:05', '2025-02-17 22:50:05', '2025-02-17 22:50:05'),
	(39, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:52:42', '2025-02-17 22:52:42', '2025-02-17 22:52:42'),
	(40, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:57:40', '2025-02-17 22:57:40', '2025-02-17 22:57:40'),
	(41, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-17 23:58:23', '2025-02-17 22:58:23', '2025-02-17 22:58:23'),
	(42, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:04:03', '2025-02-17 23:04:04', '2025-02-17 23:04:04'),
	(43, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:08:12', '2025-02-17 23:08:12', '2025-02-17 23:08:12'),
	(44, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:10:19', '2025-02-17 23:10:19', '2025-02-17 23:10:19'),
	(45, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:12:07', '2025-02-17 23:12:07', '2025-02-17 23:12:07'),
	(46, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:12:38', '2025-02-17 23:12:38', '2025-02-17 23:12:38'),
	(47, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:12:54', '2025-02-17 23:12:55', '2025-02-17 23:12:55'),
	(48, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:28:50', '2025-02-17 23:28:50', '2025-02-17 23:28:50'),
	(49, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:33:18', '2025-02-17 23:33:18', '2025-02-17 23:33:18'),
	(50, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:37:51', '2025-02-17 23:37:51', '2025-02-17 23:37:51'),
	(51, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:38:23', '2025-02-17 23:38:23', '2025-02-17 23:38:23'),
	(52, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:43:44', '2025-02-17 23:43:44', '2025-02-17 23:43:44'),
	(53, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:51:37', '2025-02-17 23:51:37', '2025-02-17 23:51:37'),
	(54, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:53:06', '2025-02-17 23:53:07', '2025-02-17 23:53:07'),
	(55, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:56:17', '2025-02-17 23:56:17', '2025-02-17 23:56:17'),
	(56, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:57:51', '2025-02-17 23:57:51', '2025-02-17 23:57:51'),
	(57, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 00:59:39', '2025-02-17 23:59:40', '2025-02-17 23:59:40'),
	(58, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 02:45:03', '2025-02-18 01:45:03', '2025-02-18 01:45:03'),
	(59, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 23:36:36', '2025-02-18 22:36:36', '2025-02-18 22:36:36'),
	(60, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 23:37:45', '2025-02-18 22:37:45', '2025-02-18 22:37:45'),
	(61, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-18 23:39:07', '2025-02-18 22:39:08', '2025-02-18 22:39:08'),
	(62, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:12:55', '2025-02-19 00:12:55', '2025-02-19 00:12:55'),
	(63, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:14:40', '2025-02-19 00:14:40', '2025-02-19 00:14:40'),
	(64, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:15:08', '2025-02-19 00:15:08', '2025-02-19 00:15:08'),
	(65, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:15:14', '2025-02-19 00:15:14', '2025-02-19 00:15:14'),
	(66, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:17:19', '2025-02-19 00:17:20', '2025-02-19 00:17:20'),
	(67, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:20:30', '2025-02-19 00:20:30', '2025-02-19 00:20:30'),
	(68, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:21:02', '2025-02-19 00:21:02', '2025-02-19 00:21:02'),
	(69, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:21:15', '2025-02-19 00:21:15', '2025-02-19 00:21:15'),
	(70, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:30:17', '2025-02-19 00:30:17', '2025-02-19 00:30:17'),
	(71, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:31:32', '2025-02-19 00:31:32', '2025-02-19 00:31:32'),
	(72, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:36:06', '2025-02-19 00:36:06', '2025-02-19 00:36:06'),
	(73, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:37:21', '2025-02-19 00:37:21', '2025-02-19 00:37:21'),
	(74, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:38:00', '2025-02-19 00:38:00', '2025-02-19 00:38:00'),
	(75, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:40:13', '2025-02-19 00:40:13', '2025-02-19 00:40:13'),
	(76, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:42:55', '2025-02-19 00:42:55', '2025-02-19 00:42:55'),
	(77, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:44:17', '2025-02-19 00:44:17', '2025-02-19 00:44:17'),
	(78, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 01:44:48', '2025-02-19 00:44:49', '2025-02-19 00:44:49'),
	(79, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 02:23:07', '2025-02-19 01:23:08', '2025-02-19 01:23:08'),
	(80, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 02:24:12', '2025-02-19 01:24:12', '2025-02-19 01:24:12'),
	(81, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 02:26:38', '2025-02-19 01:26:38', '2025-02-19 01:26:38'),
	(82, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 02:26:39', '2025-02-19 01:26:40', '2025-02-19 01:26:40'),
	(83, 1, 'Creacion usuario', 'El administrador ha creado un nuevo usuario', '2025-02-19 02:26:51', '2025-02-19 01:26:51', '2025-02-19 01:26:51'),
	(84, 1, 'Modificación usuario', 'El administrador ha modificado al usuario caca@gmail.com', '2025-02-19 02:27:09', '2025-02-19 01:27:09', '2025-02-19 01:27:09'),
	(85, 1, 'Eliminación usuario', 'El administrador ha eliminado al usuario caca@gmail.com', '2025-02-19 02:27:21', '2025-02-19 01:27:21', '2025-02-19 01:27:21'),
	(86, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 02:29:41', '2025-02-19 01:29:41', '2025-02-19 01:29:41'),
	(87, 1, 'Modificación usuario', 'El administrador ha modificado al usuario pedro@example.com', '2025-02-19 02:29:46', '2025-02-19 01:29:46', '2025-02-19 01:29:46'),
	(88, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 02:30:15', '2025-02-19 01:30:15', '2025-02-19 01:30:15'),
	(89, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:05:19', '2025-02-19 02:05:19', '2025-02-19 02:05:19'),
	(90, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:06:09', '2025-02-19 02:06:09', '2025-02-19 02:06:09'),
	(91, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:08:08', '2025-02-19 02:08:08', '2025-02-19 02:08:08'),
	(92, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:08:30', '2025-02-19 02:08:30', '2025-02-19 02:08:30'),
	(93, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:08:48', '2025-02-19 02:08:48', '2025-02-19 02:08:48'),
	(94, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:09:34', '2025-02-19 02:09:34', '2025-02-19 02:09:34'),
	(95, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:20:14', '2025-02-19 02:20:14', '2025-02-19 02:20:14'),
	(96, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:20:23', '2025-02-19 02:20:23', '2025-02-19 02:20:23'),
	(97, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:21:04', '2025-02-19 02:21:04', '2025-02-19 02:21:04'),
	(98, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:22:20', '2025-02-19 02:22:20', '2025-02-19 02:22:20'),
	(99, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:24:41', '2025-02-19 02:24:41', '2025-02-19 02:24:41'),
	(100, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:25:03', '2025-02-19 02:25:03', '2025-02-19 02:25:03'),
	(101, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:25:11', '2025-02-19 02:25:11', '2025-02-19 02:25:11'),
	(102, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:26:14', '2025-02-19 02:26:14', '2025-02-19 02:26:14'),
	(103, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:26:45', '2025-02-19 02:26:46', '2025-02-19 02:26:46'),
	(104, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:27:19', '2025-02-19 02:27:19', '2025-02-19 02:27:19'),
	(105, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:27:48', '2025-02-19 02:27:48', '2025-02-19 02:27:48'),
	(106, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:29:25', '2025-02-19 02:29:25', '2025-02-19 02:29:25'),
	(107, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:29:56', '2025-02-19 02:29:56', '2025-02-19 02:29:56'),
	(108, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:30:06', '2025-02-19 02:30:06', '2025-02-19 02:30:06'),
	(109, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:30:34', '2025-02-19 02:30:34', '2025-02-19 02:30:34'),
	(110, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:31:42', '2025-02-19 02:31:42', '2025-02-19 02:31:42'),
	(111, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:32:44', '2025-02-19 02:32:44', '2025-02-19 02:32:44'),
	(112, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:33:12', '2025-02-19 02:33:13', '2025-02-19 02:33:13'),
	(113, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:33:16', '2025-02-19 02:33:16', '2025-02-19 02:33:16'),
	(114, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:35:25', '2025-02-19 02:35:25', '2025-02-19 02:35:25'),
	(115, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:35:52', '2025-02-19 02:35:52', '2025-02-19 02:35:52'),
	(116, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:36:30', '2025-02-19 02:36:30', '2025-02-19 02:36:30'),
	(117, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:38:00', '2025-02-19 02:38:00', '2025-02-19 02:38:00'),
	(118, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:38:13', '2025-02-19 02:38:13', '2025-02-19 02:38:13'),
	(119, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:38:50', '2025-02-19 02:38:50', '2025-02-19 02:38:50'),
	(120, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:39:04', '2025-02-19 02:39:04', '2025-02-19 02:39:04'),
	(121, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:39:11', '2025-02-19 02:39:11', '2025-02-19 02:39:11'),
	(122, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:39:47', '2025-02-19 02:39:47', '2025-02-19 02:39:47'),
	(123, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 03:59:24', '2025-02-19 02:59:24', '2025-02-19 02:59:24'),
	(124, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:00:55', '2025-02-19 03:00:55', '2025-02-19 03:00:55'),
	(125, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:04:40', '2025-02-19 03:04:40', '2025-02-19 03:04:40'),
	(126, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:04:43', '2025-02-19 03:04:43', '2025-02-19 03:04:43'),
	(127, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:06:41', '2025-02-19 03:06:41', '2025-02-19 03:06:41'),
	(128, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:08:07', '2025-02-19 03:08:07', '2025-02-19 03:08:07'),
	(129, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:11:26', '2025-02-19 03:11:26', '2025-02-19 03:11:26'),
	(130, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:11:37', '2025-02-19 03:11:37', '2025-02-19 03:11:37'),
	(131, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:13:28', '2025-02-19 03:13:28', '2025-02-19 03:13:28'),
	(132, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:14:35', '2025-02-19 03:14:35', '2025-02-19 03:14:35'),
	(133, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:15:46', '2025-02-19 03:15:46', '2025-02-19 03:15:46'),
	(134, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:17:57', '2025-02-19 03:17:57', '2025-02-19 03:17:57'),
	(135, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:18:37', '2025-02-19 03:18:37', '2025-02-19 03:18:37'),
	(136, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:23:27', '2025-02-19 03:23:27', '2025-02-19 03:23:27'),
	(137, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:28:42', '2025-02-19 03:28:42', '2025-02-19 03:28:42'),
	(138, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:29:59', '2025-02-19 03:29:59', '2025-02-19 03:29:59'),
	(139, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:32:48', '2025-02-19 03:32:48', '2025-02-19 03:32:48'),
	(140, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:33:18', '2025-02-19 03:33:18', '2025-02-19 03:33:18'),
	(141, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:36:45', '2025-02-19 03:36:45', '2025-02-19 03:36:45'),
	(142, 1, 'Creación retirada', 'Se ha creado una nueva retirada', '2025-02-19 04:37:08', '2025-02-19 03:37:09', '2025-02-19 03:37:09'),
	(143, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:48:58', '2025-02-19 03:48:58', '2025-02-19 03:48:58'),
	(144, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:49:53', '2025-02-19 03:49:53', '2025-02-19 03:49:53'),
	(145, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:50:17', '2025-02-19 03:50:17', '2025-02-19 03:50:17'),
	(146, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:51:54', '2025-02-19 03:51:54', '2025-02-19 03:51:54'),
	(147, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:53:31', '2025-02-19 03:53:31', '2025-02-19 03:53:31'),
	(148, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:53:59', '2025-02-19 03:54:00', '2025-02-19 03:54:00'),
	(149, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 04:56:15', '2025-02-19 03:56:15', '2025-02-19 03:56:15'),
	(150, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:28:58', '2025-02-19 22:28:59', '2025-02-19 22:28:59'),
	(151, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:37:28', '2025-02-19 22:37:28', '2025-02-19 22:37:28'),
	(152, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:39:12', '2025-02-19 22:39:12', '2025-02-19 22:39:12'),
	(153, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:40:24', '2025-02-19 22:40:24', '2025-02-19 22:40:24'),
	(154, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:40:29', '2025-02-19 22:40:29', '2025-02-19 22:40:29'),
	(155, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:45:17', '2025-02-19 22:45:17', '2025-02-19 22:45:17'),
	(156, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:47:07', '2025-02-19 22:47:07', '2025-02-19 22:47:07'),
	(157, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:47:36', '2025-02-19 22:47:36', '2025-02-19 22:47:36'),
	(158, 1, 'Eliminación retirada', 'El administrador ha eliminado la retirada undefined', '2025-02-19 23:47:46', '2025-02-19 22:47:46', '2025-02-19 22:47:46'),
	(159, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:50:38', '2025-02-19 22:50:38', '2025-02-19 22:50:38'),
	(160, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:50:40', '2025-02-19 22:50:40', '2025-02-19 22:50:40'),
	(161, 1, 'Eliminación retirada', 'El administrador ha eliminado la retirada undefined', '2025-02-19 23:50:44', '2025-02-19 22:50:44', '2025-02-19 22:50:44'),
	(162, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:55:02', '2025-02-19 22:55:02', '2025-02-19 22:55:02'),
	(163, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:55:43', '2025-02-19 22:55:43', '2025-02-19 22:55:43'),
	(164, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-19 23:56:51', '2025-02-19 22:56:52', '2025-02-19 22:56:52'),
	(165, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:04:33', '2025-02-19 23:04:33', '2025-02-19 23:04:33'),
	(166, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:14:25', '2025-02-19 23:14:25', '2025-02-19 23:14:25'),
	(167, 1, 'Creación retirada', 'Se ha creado una nueva retirada', '2025-02-20 00:17:40', '2025-02-19 23:17:41', '2025-02-19 23:17:41'),
	(168, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:20:23', '2025-02-19 23:20:23', '2025-02-19 23:20:23'),
	(169, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:21:53', '2025-02-19 23:21:53', '2025-02-19 23:21:53'),
	(170, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:24:22', '2025-02-19 23:24:22', '2025-02-19 23:24:22'),
	(171, 1, 'Modificación retirada', 'El administrador ha modificado la retirada VHCL0007', '2025-02-20 00:24:29', '2025-02-19 23:24:30', '2025-02-19 23:24:30'),
	(172, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:24:47', '2025-02-19 23:24:47', '2025-02-19 23:24:47'),
	(173, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:54:28', '2025-02-19 23:54:28', '2025-02-19 23:54:28'),
	(174, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:56:04', '2025-02-19 23:56:04', '2025-02-19 23:56:04'),
	(175, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 00:57:05', '2025-02-19 23:57:05', '2025-02-19 23:57:05'),
	(176, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:00:38', '2025-02-20 00:00:38', '2025-02-20 00:00:38'),
	(177, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:01:21', '2025-02-20 00:01:21', '2025-02-20 00:01:21'),
	(178, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:02:01', '2025-02-20 00:02:01', '2025-02-20 00:02:01'),
	(179, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:08:15', '2025-02-20 00:08:15', '2025-02-20 00:08:15'),
	(180, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:08:31', '2025-02-20 00:08:31', '2025-02-20 00:08:31'),
	(181, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:09:32', '2025-02-20 00:09:32', '2025-02-20 00:09:32'),
	(182, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:09:48', '2025-02-20 00:09:49', '2025-02-20 00:09:49'),
	(183, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:09:57', '2025-02-20 00:09:57', '2025-02-20 00:09:57'),
	(184, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:10:11', '2025-02-20 00:10:11', '2025-02-20 00:10:11'),
	(185, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:10:17', '2025-02-20 00:10:17', '2025-02-20 00:10:17'),
	(186, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:10:26', '2025-02-20 00:10:27', '2025-02-20 00:10:27'),
	(187, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:11:14', '2025-02-20 00:11:14', '2025-02-20 00:11:14'),
	(188, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:12:13', '2025-02-20 00:12:13', '2025-02-20 00:12:13'),
	(189, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:14:24', '2025-02-20 00:14:24', '2025-02-20 00:14:24'),
	(190, 1, 'Login', 'El usuario ha iniciado sesión', '2025-02-20 01:15:33', '2025-02-20 00:15:33', '2025-02-20 00:15:33');

-- Volcando estructura para tabla grua_municipal.retiradas
CREATE TABLE IF NOT EXISTS `retiradas` (
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

-- Volcando datos para la tabla grua_municipal.retiradas: ~6 rows (aproximadamente)
DELETE FROM `retiradas`;
INSERT INTO `retiradas` (`id`, `fecha_entrada`, `fecha_salida`, `lugar`, `direccion`, `agente`, `matricula`, `marca`, `modelo`, `color`, `motivo`, `tipo_vehiculo`, `grua`, `estado`, `fecha`, `deleted_at`) VALUES
	('VHCL0001', '2023-10-01 10:00:00', '2023-10-03 12:00:00', 'Plaza Mayor', 'Calle Real, 12', 'Agente01', '1234ABC', 'Toyota', 'Corolla', 'Rojo', 'Estacionamiento indebido', 'Turismo', 'Grua01', 'Retirado', '2023-10-01 10:00:00', NULL),
	('VHCL0002', '2023-10-02 11:30:00', '2023-10-04 14:30:00', 'Parque Central', 'Avenida Principal, 5', 'Agente02', '5678XYZ', 'Ford', 'Focus', 'Azul', 'Accidente', 'Turismo', 'Grua02', 'Retirado', '2023-10-02 11:30:00', NULL),
	('VHCL0003', '2023-10-03 09:15:00', NULL, 'Zona Industrial', 'Calle Industria, 7', 'Agente03', '9012DEF', 'Renault', 'Clio', 'Blanco', 'Abandono', 'Turismo', 'Grua03', 'En depósito', '2023-10-03 09:15:00', NULL),
	('VHCL0004', '2023-10-04 13:45:00', NULL, 'Centro Comercial', 'Calle Comercio, 10', 'Agente04', '3456GHI', 'Seat', 'Ibiza', 'Negro', 'Obstrucción de tráfico', 'Turismo', 'Grua04', 'En depósito', '2023-10-04 13:45:00', NULL),
	('VHCL0005', NULL, NULL, NULL, 'asd', 'asd', 'asd', 'asd', NULL, NULL, NULL, NULL, NULL, 'En deposito', NULL, '2025-02-19 22:50:44'),
	('VHCL0007', '2025-02-28 12:32:00', NULL, 'Andalusia', 'Calle Falsa', 'Manuel Carrasco 023', '8346FGM', 'citroen', 'citroen c4', 'verde', 'mal aparcao', 'Turismo hasta 12 cv o Remolques hasta 750 kg', 'Grua Omega', 'En deposito', '2025-02-20 00:16:00', NULL);

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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(500) DEFAULT NULL,
  `password` varchar(500) DEFAULT NULL,
  `rol` varchar(500) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla grua_municipal.usuarios: ~7 rows (aproximadamente)
DELETE FROM `usuarios`;
INSERT INTO `usuarios` (`id`, `email`, `password`, `rol`, `deleted_at`) VALUES
	(1, 'admin', 'admin', 'administrador', NULL),
	(2, 'haefcna@maskdm', 'caca', 'usuario', NULL),
	(3, 'pedro@example.com', 'securepass', 'administrador', NULL),
	(4, 'laura@example.com', 'mypassword', 'usuario', NULL),
	(5, 'hecnugar@gmail.com', '$2y$12$G6sPTo9d38P/drKb2mTahuXnloJ0WoJZorhnmHrnpwWv4jPEUubHW', 'administrador', '2025-02-19 02:23:26'),
	(6, 'hecnugarr@gmail.com', 'asd123', 'usuario', '2025-02-19 02:23:24'),
	(7, 'caca@gmail.com', 'Prueba123456', 'administrador', '2025-02-19 02:27:21');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
