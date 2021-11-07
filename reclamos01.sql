-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-10-2021 a las 23:40:29
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `reclamos01`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_reclamo` (IN `_obsrecla` VARCHAR(255), IN `_id_cliente` INT, IN `_id_sucursal` INT, IN `_Id_empleado` INT, IN `_prioridad` INT, OUT `nidreclamo` INT)  BEGIN
INSERT INTO reclamo (
obsrecla,
id_cliente,
id_sucursal,
Id_empleado,
prioridad
) VALUES (
_obsrecla,
_id_cliente,
_id_sucursal,
_Id_empleado,
_prioridad
);
SET nidreclamo = (SELECT LAST_INSERT_ID());
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(4) NOT NULL,
  `nombrecli` text NOT NULL,
  `contrato` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombrecli`, `contrato`) VALUES
(36, 'NOGA', 123),
(37, 'PUKARA SRL', 12321),
(38, 'NOGANET', 1231),
(39, 'IBM', 11121);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dto`
--

CREATE TABLE `dto` (
  `id_dto` int(3) NOT NULL,
  `id_zona` int(2) NOT NULL,
  `nombredto` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `dto`
--

INSERT INTO `dto` (`id_dto`, `id_zona`, `nombredto`) VALUES
(1, 1, 'JUJUY'),
(2, 1, 'SALTA'),
(3, 1, 'TUCUMAN'),
(4, 1, 'CATAMARCA'),
(5, 1, 'LA RIOJA'),
(6, 1, 'SANTIAGO DEL ESTERO'),
(7, 5, 'MISIONES'),
(8, 5, 'CORRIENTES'),
(10, 5, 'CHACO'),
(11, 5, 'FORMOSA'),
(13, 9, 'NEUQUEN'),
(14, 9, 'CHUBUT'),
(15, 9, 'RIO NEGRO'),
(16, 9, 'SANTA CRUZ'),
(17, 9, 'TIERRA DEL FUEGO'),
(18, 8, 'BUENOS AIRES'),
(19, 7, 'CORDOBA'),
(20, 7, 'SANTA FE'),
(21, 7, 'ENTRE RIOS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `info_tecnico`
--

CREATE TABLE `info_tecnico` (
  `id_infotec` int(10) NOT NULL,
  `id_reclamo` int(5) NOT NULL,
  `informe` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reclamo`
--

CREATE TABLE `reclamo` (
  `id_reclamo` int(10) NOT NULL,
  `obsrecla` text NOT NULL,
  `id_cliente` int(4) NOT NULL,
  `id_sucursal` int(3) NOT NULL,
  `Id_empleado` int(3) DEFAULT NULL,
  `f_cierre` date DEFAULT NULL,
  `f_creacion` date NOT NULL,
  `estadorecla` int(1) DEFAULT 0,
  `prioridad` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `reclamo`
--

INSERT INTO `reclamo` (`id_reclamo`, `obsrecla`, `id_cliente`, `id_sucursal`, `Id_empleado`, `f_cierre`, `f_creacion`, `estadorecla`, `prioridad`) VALUES
(31, 'sin bateria y nada mas che', 39, 16, 3, 10, NULL, '2021-09-14', 0, 0),
(32, 'perilla rota', 38, 17, 3, 10, '2021-10-12', '2021-10-12', 1, 2),
(34, 'grupo 2 no arranca', 39, 16, 3, 10, NULL, '2021-10-16', 0, 0),
(35, 'nada1', 36, 16, 3, 10, NULL, '2021-10-16', 0, 1),
(40, 'se rompio todooo', 36, 16, 3, 10, NULL, '2021-10-16', 0, 1),
(52, 'todo mala onda', 36, 16, 3, 10, NULL, '2021-10-16', 0, 1),
(53, 'todo mala onda', 36, 16, 3, 10, NULL, '2021-10-16', 0, 1),
(54, 'todo mala onda', 36, 16, 3, 10, NULL, '2021-10-16', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `id_sucursal` int(3) NOT NULL,
  `id_cliente` int(4) NOT NULL,
  `id_dto` int(3) NOT NULL,
  `nombresuc` text NOT NULL,
  `direccionsuc` text NOT NULL,
  `telefonosuc` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`id_sucursal`, `id_cliente`, `id_dto`, `nombresuc`, `direccionsuc`, `telefonosuc`) VALUES
(16, 39, 1, 'IBM DEL NORTE ARGENTINO', 'Cumaya 123', 12343241),
(17, 36, 1, 'NOGA SALTA', 'trulala 212', 232344545);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnico`
--

CREATE TABLE `empleado` (
  `Id_Empleado` int(3) NOT NULL,
  `id_zona` int(2) NOT NULL,
  `Nombre` text NOT NULL,
  `Apellido` text NOT NULL, 
  `Teléfono` number NOT NULL,
  `Email` text NOT NULL,
  `Usuario` text NOT NULL, 
  `Clave` text NOT NULL,
  `Sector` text,
  `Id_Sucursal` number NOT NULL,
  `matriculatec` int(6) NOT NULL,
  `departamentotec` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

Id_Empleado, Nombre, Apellido, Contacto, Teléfono, Email,
Usuario, Contraseña, Sector, Id_Sucursal.
--
-- Volcado de datos para la tabla `tecnico`
--

INSERT INTO `empleado` (`Id_Empleado`, `id_zona`, `Nombre`, `Apellido`, `Teléfono`,`Email`,`usuario`, `clave`, `Id_Sucursal`,`matriculatec`, `departamentotec`) VALUES
(10, 1, 'LUIS', 'PEREZ', 1123456789, 'user@prueba.com','user@prueba.com','clavePrueba',1, 121, 'Electricidad'),
(11, 9, 'Alejadro', 'Gomez',1123456789, 'user@prueba.com','user@prueba.com','clavePrueba',1, 3333,'electromecanica'),
(12, 1, 'Ramiro', 'Lopez ',1123456789,'user@prueba.com','user@prueba.com','clavePrueba',1, 1111, 'Termomecanica');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_reclamos_abiertos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_reclamos_abiertos` (
`id_reclamo` int(10)
,`obsrecla` text
,`estadorecla` int(1)
,`f_creacion` date
,`f_cierre` date
,`prioridad` int(1)
,`nombrecli` text
,`nombresuc` text
,`direccionsuc` text
,`telefonosuc` int(9)
,`nombretec` text
,`departamentotec` text
,`nombredto` varchar(30)
,`nombrezona` varchar(15)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_reclamos_cerrados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_reclamos_cerrados` (
`id_reclamo` int(10)
,`obsrecla` text
,`estadorecla` int(1)
,`f_creacion` date
,`f_cierre` date
,`prioridad` int(1)
,`nombrecli` text
,`nombresuc` text
,`direccionsuc` text
,`telefonosuc` int(9)
,`nombretec` text
,`departamentotec` text
,`nombredto` varchar(30)
,`nombrezona` varchar(15)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_reclamos_todos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_reclamos_todos` (
`id_reclamo` int(10)
,`obsrecla` text
,`estadorecla` int(1)
,`f_creacion` date
,`f_cierre` date
,`prioridad` int(1)
,`nombrecli` text
,`nombresuc` text
,`direccionsuc` text
,`telefonosuc` int(9)
,`nombretec` text
,`departamentotec` text
,`nombredto` varchar(30)
,`nombrezona` varchar(15)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_reclamos_z1`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_reclamos_z1` (
`id_reclamo` int(10)
,`obsrecla` text
,`estadorecla` int(1)
,`f_creacion` date
,`f_cierre` date
,`prioridad` int(1)
,`nombrecli` text
,`nombresuc` text
,`direccionsuc` text
,`telefonosuc` int(9)
,`nombretec` text
,`departamentotec` text
,`nombredto` varchar(30)
,`nombrezona` varchar(15)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zona`
--

CREATE TABLE `zona` (
  `id_zona` int(2) NOT NULL,
  `nombrezona` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `zona`
--

INSERT INTO `zona` (`id_zona`, `nombrezona`) VALUES
(1, 'NOA'),
(5, 'LITORAL'),
(6, 'CUYO'),
(7, 'CENTRO'),
(8, 'BUENOS AIRES'),
(9, 'PATAGONIA');

-- --------------------------------------------------------

--
-- Estructura para la vista `v_reclamos_abiertos`
--
DROP TABLE IF EXISTS `v_reclamos_abiertos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reclamos_abiertos`  AS SELECT `reclamo`.`id_reclamo` AS `id_reclamo`, `reclamo`.`obsrecla` AS `obsrecla`, `reclamo`.`estadorecla` AS `estadorecla`, `reclamo`.`f_creacion` AS `f_creacion`, `reclamo`.`f_cierre` AS `f_cierre`, `reclamo`.`prioridad` AS `prioridad`, `cliente`.`nombrecli` AS `nombrecli`, `sucursal`.`nombresuc` AS `nombresuc`, `sucursal`.`direccionsuc` AS `direccionsuc`, `sucursal`.`telefonosuc` AS `telefonosuc`, `empleado`.`nombretec` AS `nombretec`, `empleado`.`departamentotec` AS `departamentotec`, `dto`.`nombredto` AS `nombredto`, `zona`.`nombrezona` AS `nombrezona` FROM (((((`reclamo` join `cliente` on(`reclamo`.`id_cliente` = `cliente`.`id_cliente`)) join `sucursal` on(`reclamo`.`id_sucursal` = `sucursal`.`id_sucursal`)) join `empleado` on(`reclamo`.`Id_empleado` = `empleado`.`Id_empleado`)) join `dto` on(`sucursal`.`id_dto` = `dto`.`id_dto`)) join `zona` on(`dto`.`id_dto` = `zona`.`id_zona`)) WHERE `reclamo`.`estadorecla` = 0 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_reclamos_cerrados`
--
DROP TABLE IF EXISTS `v_reclamos_cerrados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reclamos_cerrados`  AS SELECT `reclamo`.`id_reclamo` AS `id_reclamo`, `reclamo`.`obsrecla` AS `obsrecla`, `reclamo`.`estadorecla` AS `estadorecla`, `reclamo`.`f_creacion` AS `f_creacion`, `reclamo`.`f_cierre` AS `f_cierre`, `reclamo`.`prioridad` AS `prioridad`, `cliente`.`nombrecli` AS `nombrecli`, `sucursal`.`nombresuc` AS `nombresuc`, `sucursal`.`direccionsuc` AS `direccionsuc`, `sucursal`.`telefonosuc` AS `telefonosuc`, `empleado`.`nombretec` AS `nombretec`, `empleado`.`departamentotec` AS `departamentotec`, `dto`.`nombredto` AS `nombredto`, `zona`.`nombrezona` AS `nombrezona` FROM (((((`reclamo` join `cliente` on(`reclamo`.`id_cliente` = `cliente`.`id_cliente`)) join `sucursal` on(`reclamo`.`id_sucursal` = `sucursal`.`id_sucursal`)) join `empleado` on(`reclamo`.`Id_empleado` = `empleado`.`Id_empleado`)) join `dto` on(`sucursal`.`id_dto` = `dto`.`id_dto`)) join `zona` on(`dto`.`id_dto` = `zona`.`id_zona`)) WHERE `reclamo`.`estadorecla` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_reclamos_todos`
--
DROP TABLE IF EXISTS `v_reclamos_todos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reclamos_todos`  AS SELECT `reclamo`.`id_reclamo` AS `id_reclamo`, `reclamo`.`obsrecla` AS `obsrecla`, `reclamo`.`estadorecla` AS `estadorecla`, `reclamo`.`f_creacion` AS `f_creacion`, `reclamo`.`f_cierre` AS `f_cierre`, `reclamo`.`prioridad` AS `prioridad`, `cliente`.`nombrecli` AS `nombrecli`, `sucursal`.`nombresuc` AS `nombresuc`, `sucursal`.`direccionsuc` AS `direccionsuc`, `sucursal`.`telefonosuc` AS `telefonosuc`, `empleado`.`nombretec` AS `nombretec`, `empleado`.`departamentotec` AS `departamentotec`, `dto`.`nombredto` AS `nombredto`, `zona`.`nombrezona` AS `nombrezona` FROM (((((`reclamo` join `cliente` on(`reclamo`.`id_cliente` = `cliente`.`id_cliente`)) join `sucursal` on(`reclamo`.`id_sucursal` = `sucursal`.`id_sucursal`)) join `empleado` on(`reclamo`.`Id_empleado` = `emple1ado`.`Id_empleado`)) join `dto` on(`sucursal`.`id_dto` = `dto`.`id_dto`)) join `zona` on(`dto`.`id_dto` = `zona`.`id_zona`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_reclamos_z1`
--
DROP TABLE IF EXISTS `v_reclamos_z1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reclamos_z1`  AS SELECT `reclamo`.`id_reclamo` AS `id_reclamo`, `reclamo`.`obsrecla` AS `obsrecla`, `reclamo`.`estadorecla` AS `estadorecla`, `reclamo`.`f_creacion` AS `f_creacion`, `reclamo`.`f_cierre` AS `f_cierre`, `reclamo`.`prioridad` AS `prioridad`, `cliente`.`nombrecli` AS `nombrecli`, `sucursal`.`nombresuc` AS `nombresuc`, `sucursal`.`direccionsuc` AS `direccionsuc`, `sucursal`.`telefonosuc` AS `telefonosuc`, `empleado`.`nombretec` AS `nombretec`, `empleado`.`departamentotec` AS `departamentotec`, `dto`.`nombredto` AS `nombredto`, `zona`.`nombrezona` AS `nombrezona` FROM (((((`reclamo` join `cliente` on(`reclamo`.`id_cliente` = `cliente`.`id_cliente`)) join `sucursal` on(`reclamo`.`id_sucursal` = `sucursal`.`id_sucursal`)) join `empleado` on(`reclamo`.`Id_empleado` = `empleado`.`Id_empleado`)) join `dto` on(`sucursal`.`id_dto` = `dto`.`id_dto`)) join `zona` on(`dto`.`id_dto` = `zona`.`id_zona`)) WHERE `zona`.`id_zona` = 1 ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `dto`
--
ALTER TABLE `dto`
  ADD PRIMARY KEY (`id_dto`),
  ADD KEY `id_zona` (`id_zona`);

--
-- Indices de la tabla `info_tecnico`
--
ALTER TABLE `info_tecnico`
  ADD PRIMARY KEY (`id_infotec`),
  ADD KEY `id_reclamo` (`id_reclamo`);


--
-- Indices de la tabla `reclamo`
--
ALTER TABLE `reclamo`
  ADD PRIMARY KEY (`id_reclamo`),
  ADD KEY `reclamo` (`id_cliente`,`id_sucursal`) USING BTREE,
  ADD KEY `Id_empleado` (`Id_empleado`) USING BTREE,
  ADD KEY `fk_suc` (`id_sucursal`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`id_sucursal`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_dto` (`id_dto`);

--
-- Indices de la tabla `tecnico`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`Id_empleado`),
  ADD KEY `id_zona` (`id_zona`);

--
-- Indices de la tabla `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`id_zona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `dto`
--
ALTER TABLE `dto`
  MODIFY `id_dto` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `info_tecnico`
--
ALTER TABLE `info_tecnico`
  MODIFY `id_infotec` int(10) NOT NULL AUTO_INCREMENT;



--
-- AUTO_INCREMENT de la tabla `reclamo`
--
ALTER TABLE `reclamo`
  MODIFY `id_reclamo` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `id_sucursal` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tecnico`
--
ALTER TABLE `empleado`
  MODIFY `Id_empleado` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `zona`
--
ALTER TABLE `zona`
  MODIFY `id_zona` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `dto`
--
ALTER TABLE `dto`
  ADD CONSTRAINT `dto_ibfk_1` FOREIGN KEY (`id_zona`) REFERENCES `zona` (`id_zona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `info_tecnico`
--
ALTER TABLE `info_tecnico`
  ADD CONSTRAINT `info_tecnico_ibfk_1` FOREIGN KEY (`id_reclamo`) REFERENCES `reclamo` (`id_reclamo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reclamo`
--
ALTER TABLE `reclamo`
  ADD CONSTRAINT `fk_cte` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `fk_suc` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`),
  ADD CONSTRAINT `fk_tec` FOREIGN KEY (`Id_empleado`) REFERENCES `empleado` (`Id_empleado`);

--
-- Filtros para la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD CONSTRAINT `fk_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sucursal_ibfk_1` FOREIGN KEY (`id_dto`) REFERENCES `dto` (`id_dto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tecnico`
--
ALTER TABLE `Empleado`
  ADD CONSTRAINT `tecnico_ibfk_1` FOREIGN KEY (`id_zona`) REFERENCES `zona` (`id_zona`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
