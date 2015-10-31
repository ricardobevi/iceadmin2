-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 24-12-2014 a las 13:58:53
-- Versión del servidor: 5.5.40-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `iceadmin`
--
CREATE DATABASE IF NOT EXISTS `iceadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `iceadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `price`
--

DROP TABLE IF EXISTS `price`;
CREATE TABLE IF NOT EXISTS `price` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `price`
--

INSERT INTO `price` (`id`, `price`) VALUES
(1, 110.00),
(2, 60.00),
(3, 35.00),
(4, 30.00),
(5, 28.00),
(6, 25.00),
(7, 20.00),
(8, 15.00),
(9, 200.00),
(10, 30.00),
(11, 5.00),
(12, 2.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `label` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `label`) VALUES
(1, '1 Kg', '1 Kg', '1 Kg'),
(2, '1/2 Kg', '1/2 Kg', '1/2 Kg'),
(3, '1/4 Kg', '1/4 Kg', '1/4 Kg'),
(4, 'Cucurucho', 'Cucurucho', 'Cucurucho'),
(5, 'Vaso Grande', 'Vaso Nro 65', 'Vaso Grande'),
(6, 'Vaso Mediano', 'Vaso Nro 50', 'Vaso Mediano'),
(7, 'Vaso Chico', 'Vaso Nro. 30', 'Vaso Chico'),
(8, 'Conito 1 Sabor', 'Cono Nro. ?', 'Conito 1 Sabor'),
(9, 'Oferta 2Kg', 'Oferta 2Kg', 'Oferta 2Kg'),
(10, 'Café', 'Café Solo', 'Café'),
(11, 'Café con Leche', 'Café con Leche', 'Café con Leche'),
(12, 'Jugo de Naranja', 'Jugo de Naranja', 'Jugo de Naranja'),
(13, 'Licuado de Banana', 'Licuado de Banana', 'Licuado de Banana'),
(14, 'Rocklets', 'Rocklets', 'Rocklets'),
(15, 'Salsa', 'Salsa', 'Salsa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_price`
--

DROP TABLE IF EXISTS `product_price`;
CREATE TABLE IF NOT EXISTS `product_price` (
  `product_id` bigint(20) unsigned NOT NULL,
  `price_id` bigint(20) unsigned NOT NULL,
  `set_date` datetime NOT NULL,
  PRIMARY KEY (`product_id`,`price_id`,`set_date`),
  KEY `price_id` (`price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `product_price`
--

INSERT INTO `product_price` (`product_id`, `price_id`, `set_date`) VALUES
(1, 1, '2014-12-20 00:33:00'),
(2, 2, '2014-12-20 15:12:27'),
(3, 3, '2014-12-20 15:12:27'),
(4, 4, '2014-12-20 15:12:27'),
(5, 5, '2014-12-20 15:12:27'),
(6, 6, '2014-12-20 15:12:27'),
(13, 6, '2014-12-20 15:20:05'),
(7, 7, '2014-12-20 15:12:27'),
(11, 7, '2014-12-20 15:20:05'),
(12, 7, '2014-12-20 15:20:05'),
(8, 8, '2014-12-20 15:12:27'),
(10, 8, '2014-12-20 15:20:05'),
(9, 9, '2014-12-20 15:12:27'),
(14, 11, '2014-12-20 15:20:05'),
(15, 12, '2014-12-20 15:20:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_ticket`
--

DROP TABLE IF EXISTS `product_ticket`;
CREATE TABLE IF NOT EXISTS `product_ticket` (
  `product_id` bigint(20) unsigned NOT NULL,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `price_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`ticket_id`,`price_id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `price_id` (`price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `product_ticket`
--

INSERT INTO `product_ticket` (`product_id`, `ticket_id`, `price_id`, `quantity`) VALUES
(1, 115, 1, 2),
(1, 134, 1, 1),
(1, 143, 1, 1),
(2, 117, 2, 1),
(2, 132, 2, 1),
(2, 133, 2, 1),
(2, 139, 2, 1),
(2, 140, 2, 1),
(3, 141, 3, 1),
(4, 117, 4, 1),
(5, 115, 5, 1),
(5, 132, 5, 2),
(5, 133, 5, 1),
(5, 134, 5, 1),
(5, 137, 5, 1),
(5, 143, 5, 1),
(5, 144, 5, 1),
(5, 145, 5, 1),
(5, 146, 5, 1),
(6, 132, 6, 1),
(6, 133, 6, 1),
(6, 135, 6, 1),
(6, 136, 6, 1),
(6, 138, 6, 2),
(6, 142, 6, 1),
(6, 144, 6, 2),
(6, 145, 6, 1),
(8, 132, 8, 2),
(8, 134, 8, 2),
(8, 135, 8, 1),
(8, 146, 8, 1),
(9, 132, 9, 3),
(9, 133, 9, 3),
(9, 135, 9, 1),
(9, 136, 9, 2),
(10, 116, 8, 1),
(10, 132, 8, 1),
(10, 135, 8, 1),
(11, 136, 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `quick_access`
--

DROP TABLE IF EXISTS `quick_access`;
CREATE TABLE IF NOT EXISTS `quick_access` (
  `product_id` bigint(11) unsigned NOT NULL,
  `position` int(11) unsigned NOT NULL,
  `group` int(11) unsigned NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `quick_access`
--

INSERT INTO `quick_access` (`product_id`, `position`, `group`) VALUES
(1, 0, 1),
(2, 1, 1),
(3, 2, 1),
(4, 3, 1),
(5, 4, 1),
(6, 5, 1),
(7, 6, 1),
(8, 7, 1),
(9, 8, 1),
(10, 9, 1),
(11, 10, 1),
(12, 0, 2),
(13, 1, 2),
(14, 2, 2),
(15, 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket`
--

DROP TABLE IF EXISTS `ticket`;
CREATE TABLE IF NOT EXISTS `ticket` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `printed_number` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=147 ;

--
-- Volcado de datos para la tabla `ticket`
--

INSERT INTO `ticket` (`id`, `printed_number`, `date_time`) VALUES
(112, 100, '2014-12-22 18:00:56'),
(113, 100, '2014-12-22 18:23:17'),
(114, 100, '2014-12-22 19:27:59'),
(115, 100, '2014-12-22 19:50:31'),
(116, 100, '2014-12-22 19:51:11'),
(117, 100, '2014-12-22 20:02:00'),
(118, 100, '2014-12-22 23:18:33'),
(119, 100, '2014-12-22 23:18:35'),
(120, 100, '2014-12-22 23:18:37'),
(121, 100, '2014-12-22 23:18:46'),
(122, 100, '2014-12-22 23:19:19'),
(123, 100, '2014-12-22 23:19:23'),
(124, 100, '2014-12-22 23:19:41'),
(125, 100, '2014-12-22 23:19:50'),
(126, 100, '2014-12-22 23:19:53'),
(127, 100, '2014-12-22 23:22:26'),
(128, 100, '2014-12-22 23:22:39'),
(129, 100, '2014-12-23 00:03:46'),
(130, 100, '2014-12-23 00:08:10'),
(131, 100, '2014-12-23 00:11:02'),
(132, 100, '2014-12-23 00:12:40'),
(133, 100, '2014-12-23 00:13:35'),
(134, 100, '2014-12-23 00:24:54'),
(135, 100, '2014-12-23 17:18:47'),
(136, 100, '2014-12-23 17:25:32'),
(137, 100, '2014-12-24 05:01:41'),
(138, 100, '2014-12-24 05:03:24'),
(139, 100, '2014-12-24 05:04:46'),
(140, 100, '2014-12-24 05:07:10'),
(141, 100, '2014-12-24 05:07:20'),
(142, 100, '2014-12-24 05:07:39'),
(143, 100, '2014-12-24 05:08:08'),
(144, 100, '2014-12-24 05:09:59'),
(145, 100, '2014-12-24 13:52:46'),
(146, 100, '2014-12-24 13:53:41');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `product_price`
--
ALTER TABLE `product_price`
  ADD CONSTRAINT `product_price_ibfk_2` FOREIGN KEY (`price_id`) REFERENCES `price` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `product_price_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `product_ticket`
--
ALTER TABLE `product_ticket`
  ADD CONSTRAINT `product_ticket_ibfk_1` FOREIGN KEY (`price_id`) REFERENCES `price` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `product_ticket_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `product_ticket_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `quick_access`
--
ALTER TABLE `quick_access`
  ADD CONSTRAINT `quick_access_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
