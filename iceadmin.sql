-- phpMyAdmin SQL Dump
-- version 4.2.12deb2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 08-12-2015 a las 07:19:03
-- Versión del servidor: 5.6.27-0ubuntu0.15.04.1
-- Versión de PHP: 5.6.4-4ubuntu6.4

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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

CREATE TABLE IF NOT EXISTS `price` (
`id` bigint(20) unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `price`
--

INSERT INTO `price` (`id`, `price`) VALUES
(1, 145.00),
(2, 80.00),
(3, 45.00),
(4, 40.00),
(5, 38.00),
(6, 35.00),
(7, 30.00),
(8, 20.00),
(9, 270.00),
(10, 40.00),
(11, 7.00),
(12, 3.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

CREATE TABLE IF NOT EXISTS `product` (
`id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `label` varchar(50) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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

CREATE TABLE IF NOT EXISTS `product_price` (
  `product_id` bigint(20) unsigned NOT NULL,
  `price_id` bigint(20) unsigned NOT NULL,
  `subsidiary_id` int(11) NOT NULL DEFAULT '1',
  `set_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `product_price`
--

INSERT INTO `product_price` (`product_id`, `price_id`, `subsidiary_id`, `set_date`) VALUES
(1, 1, 1, '2014-12-20 00:33:00'),
(2, 2, 1, '2014-12-20 15:12:27'),
(3, 3, 1, '2014-12-20 15:12:27'),
(4, 4, 1, '2014-12-20 15:12:27'),
(5, 5, 1, '2014-12-20 15:12:27'),
(6, 6, 1, '2014-12-20 15:12:27'),
(7, 7, 1, '2014-12-20 15:12:27'),
(8, 8, 1, '2014-12-20 15:12:27'),
(9, 9, 1, '2014-12-20 15:12:27'),
(10, 8, 1, '2014-12-20 15:20:05'),
(11, 7, 1, '2014-12-20 15:20:05'),
(12, 7, 1, '2014-12-20 15:20:05'),
(13, 10, 1, '2014-12-20 15:20:05'),
(14, 11, 1, '2014-12-20 15:20:05'),
(15, 12, 1, '2014-12-20 15:20:05'),
(1, 1, 2, '2014-12-20 00:33:00'),
(2, 2, 2, '2014-12-20 15:12:27'),
(3, 3, 2, '2014-12-20 15:12:27'),
(4, 4, 2, '2014-12-20 15:12:27'),
(5, 5, 2, '2014-12-20 15:12:27'),
(6, 6, 2, '2014-12-20 15:12:27'),
(7, 7, 2, '2014-12-20 15:12:27'),
(8, 8, 2, '2014-12-20 15:12:27'),
(9, 9, 2, '2014-12-20 15:12:27'),
(10, 8, 2, '2014-12-20 15:20:05'),
(11, 7, 2, '2014-12-20 15:20:05'),
(12, 7, 2, '2014-12-20 15:20:05'),
(13, 10, 2, '2014-12-20 15:20:05'),
(14, 11, 2, '2014-12-20 15:20:05'),
(15, 12, 2, '2014-12-20 15:20:05');


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_ticket`
--

CREATE TABLE IF NOT EXISTS `product_ticket` (
  `product_id` bigint(20) unsigned NOT NULL,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `subsidiary_id` int(11) NOT NULL DEFAULT '1',
  `price_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



--
-- Estructura de tabla para la tabla `quick_access`
--

CREATE TABLE IF NOT EXISTS `quick_access` (
  `product_id` bigint(11) unsigned NOT NULL,
  `position` int(11) unsigned NOT NULL,
  `group` int(11) unsigned NOT NULL
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
-- Estructura de tabla para la tabla `subsidiary`
--

CREATE TABLE IF NOT EXISTS `subsidiary` (
  `id` int(11) NOT NULL,
  `description` varchar(150) COLLATE utf8_bin NOT NULL,
  `address` varchar(150) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `subsidiary`
--

INSERT INTO `subsidiary` (`id`, `description`, `address`) VALUES
(1, 'Central MDA Sur', 'Brown 67'),
(2, 'Sucursal MDA Centro ', 'N/A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket`
--

CREATE TABLE IF NOT EXISTS `ticket` (
`id` bigint(20) unsigned NOT NULL,
  `subsidiary_id` int(11) NOT NULL DEFAULT '1',
  `printed_number` int(11) NOT NULL,
  `date_time` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



--
-- Estructura de tabla para la tabla `wifi_password`
--

CREATE TABLE IF NOT EXISTS `wifi_password` (
`id` int(11) NOT NULL,
  `date` date NOT NULL,
  `password` varchar(100) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `wifi_password`
--

INSERT INTO `wifi_password` (`id`, `date`, `password`) VALUES
(1, '2015-12-08', 'amores1234');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `price`
--
ALTER TABLE `price`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `product`
--
ALTER TABLE `product`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `product_price`
--
ALTER TABLE `product_price`
 ADD PRIMARY KEY (`product_id`,`price_id`,`subsidiary_id`), ADD UNIQUE KEY `date` (`product_id`,`price_id`,`subsidiary_id`,`set_date`), ADD KEY `price_id` (`price_id`), ADD KEY `subsidiary_id` (`subsidiary_id`);

--
-- Indices de la tabla `product_ticket`
--
ALTER TABLE `product_ticket`
 ADD PRIMARY KEY (`product_id`,`ticket_id`,`price_id`,`subsidiary_id`), ADD KEY `ticket_id` (`ticket_id`), ADD KEY `price_id` (`price_id`), ADD KEY `subsidiary_id` (`subsidiary_id`);

--
-- Indices de la tabla `quick_access`
--
ALTER TABLE `quick_access`
 ADD PRIMARY KEY (`product_id`);

--
-- Indices de la tabla `subsidiary`
--
ALTER TABLE `subsidiary`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ticket`
--
ALTER TABLE `ticket`
 ADD PRIMARY KEY (`id`,`subsidiary_id`), ADD KEY `subsidiary_id` (`subsidiary_id`);

--
-- Indices de la tabla `wifi_password`
--
ALTER TABLE `wifi_password`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `price`
--
ALTER TABLE `price`
MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `product`
--
ALTER TABLE `product`
MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `ticket`
--
ALTER TABLE `ticket`
MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=228;
--
-- AUTO_INCREMENT de la tabla `wifi_password`
--
ALTER TABLE `wifi_password`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `product_price`
--
ALTER TABLE `product_price`
ADD CONSTRAINT `product_price_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE,
ADD CONSTRAINT `product_price_ibfk_2` FOREIGN KEY (`price_id`) REFERENCES `price` (`id`) ON UPDATE CASCADE,
ADD CONSTRAINT `product_price_ibfk_3` FOREIGN KEY (`subsidiary_id`) REFERENCES `subsidiary` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `product_ticket`
--
ALTER TABLE `product_ticket`
ADD CONSTRAINT `product_ticket_ibfk_1` FOREIGN KEY (`price_id`) REFERENCES `price` (`id`) ON UPDATE CASCADE,
ADD CONSTRAINT `product_ticket_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`) ON UPDATE CASCADE,
ADD CONSTRAINT `product_ticket_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE,
ADD CONSTRAINT `product_ticket_ibfk_4` FOREIGN KEY (`subsidiary_id`) REFERENCES `subsidiary` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `quick_access`
--
ALTER TABLE `quick_access`
ADD CONSTRAINT `quick_access_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ticket`
--
ALTER TABLE `ticket`
ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`subsidiary_id`) REFERENCES `subsidiary` (`id`) ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
