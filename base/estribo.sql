-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 192.168.0.58
-- Tiempo de generación: 03-11-2021 a las 23:09:11
-- Versión del servidor: 5.6.43
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `estribo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `links`
--

CREATE TABLE `links` (
  `id_link` int(11) NOT NULL,
  `id_titulo` int(4) NOT NULL,
  `descripcion_link` varchar(100) NOT NULL,
  `path1` varchar(100) NOT NULL,
  `orden` int(3) NOT NULL,
  `borrado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `links`
--

INSERT INTO `links` (`id_link`, `id_titulo`, `descripcion_link`, `path1`, `orden`, `borrado`) VALUES
(1, 1, '03 de Enero 2021 (Tablas API y Mod. MT)', 'https://drive.google.com/file/d/1LgI1AEaj0D4vMWEV_pDLHJ5L9taxJBXt/view?usp=sharing', 1, 0),
(2, 1, '08 de Febrero 2021 (Tablas actualizadas)', 'https://drive.google.com/file/d/1vNqKeG_35uk0j-EjPuzuh5e2AuIHu3cc/view?usp=sharing', 2, 0),
(3, 1, '05 de Abril 2021 (Tablas API)', 'https://drive.google.com/file/d/1B9e0JKla4790LgdUlAs3wS1xvMWtPbSa/view?usp=sharing', 3, 0),
(4, 1, '17 de Mayo 2021 (Actualización Versión 2021-May12)', 'https://drive.google.com/file/d/1fXo5J_niXmzRjo6kPm5tqn50zKP2L-Ja/view?usp=sharing', 4, 0),
(5, 1, '15 de Julio 2021 (Versión 2021-Jul/15)', 'discoweb/Sellos/sellos-2021-07-15.exe', 5, 0),
(6, 1, 'Instructivo para hacer Backup ', 'registros/backup.pdf', 10, 0),
(7, 2, 'Sipres Version 	3.00 (versión 2021 a partir de la quincena 9 (primera de mayo)', 'https://www.santafe.gov.ar/index.php/web/content/download/261654/1375012/file/instalador300.exe', 1, 0),
(8, 3, 'Instalador Versión Actualizada', 'https://drive.google.com/file/d/1uDseWSjPjZFIuzhQKObPWo84cgcD_SRn/view?usp=sharing', 1, 0),
(9, 4, 'Caja Diaria', 'https://drive.google.com/file/d/11W6ZBR1wUfGxTWKX7nWuvktB2n2WLbzr/view?usp=sharing', 1, 0),
(10, 5, 'Mozilla Firefox', 'http://www.mozilla.org/es-AR/firefox/new/', 1, 0),
(11, 5, 'Breez para firefox (Extension p/Imprimir)', 'https://addons.mozilla.org/es/firefox/addon/breez-clickonce/?src=search', 2, 0),
(12, 5, 'Click Once para Chrome (Extension p/Imprimir)', 'https://chrome.google.com/webstore/detail/meta4-clickonce-launcher/jkncabbipkgbconhaajbapbhokpbgkdc', 3, 0),
(13, 6, 'SAP Cristal Report (Impresiones SURA)', 'https://www.dnrpa.gov.ar/rrss/requisitos_sura/CRforVS_clickonce_13_0_1.zip', 1, 0),
(14, 6, 'Framework 4.0', 'https://www.dnrpa.gov.ar/rrss/requisitos_sura/dotNetFx40_Full_x86_x64.zip', 2, 0),
(15, 6, 'Framework 4.5', 'https://www.dnrpa.gov.ar/rrss/requisitos_sura/NDP451-KB2858728-x86-x64-AllOS-ENU.exe', 3, 0),
(16, 6, 'Framework 3.5', 'https://drive.google.com/open?id=0B2T5CEHbcCDOd3ZRVVBMdFB6X00', 4, 0),
(17, 7, 'Ccleaner', 'https://www.ccleaner.com/es-es/ccleaner/download/standard', 1, 0),
(18, 7, 'TeamViewer Liviano (Conexión Máquina a Máquina)', 'https://drive.google.com/file/d/1ox_fZ37vYdaWFfT3dzA0C8Zv1EvBJYQR/view?usp=sharing', 2, 0),
(19, 7, 'TeamViewer Completo  (Conexión Máquina a Máquina)', 'https://download.teamviewer.com/download/version_13x/TeamViewer_Setup.exe', 3, 0),
(20, 7, 'AnyDesk', 'discoweb/AnyDesk.exe', 4, 0),
(21, 7, 'Configuración Mozilla Thunderbird', 'https://drive.google.com/file/d/15a_nlDMO-oOz2UlIqhRftkP1eOpLqV-n/view?usp=sharing', 5, 0),
(22, 7, 'Hoja de Registro (Confecciona Hojas de Registro Faciles y completas)', 'http://www.gestionregistral.com.ar/descargas/GR_Setup.exe', 6, 0),
(23, 7, 'Programas Utilitarios Varios', 'sura/utiles/', 7, 0),
(24, 7, 'Disco Web', 'discoweb', 8, 0),
(25, 7, 'PDF24 - Convertir imagenes en pdf y unir archivos pdf', 'sura/utiles/pdf24-creator-8.0.4.exe', 9, 0),
(26, 8, 'Constancias de Inscripción Automotor', 'sura/CONSTANCIA%20DE%20INSCRIPCION%20DE%20AUTOMOTOR%20O%20km.doc', 1, 0),
(27, 8, 'Constancia de Inscripción Motovehículo', 'sura/CONSTANCIA%20DE%20INSCRIPCION%20DE%20MOTOS%200KM.doc', 2, 0),
(28, 8, 'Constancia de Inscripción Acoplado', 'sura/CONSTANCIA%20DE%20INSCRIPCION%20DEL%20ACOPLADO%200KM.doc', 3, 0),
(29, 8, 'Permiso Circulación - Motos', 'sura/Permiso_Circulac_motos.doc', 4, 0),
(30, 8, 'Observación', 'discoweb/Observacion.doc', 5, 0),
(31, 8, 'Constancia de Titularidad', 'sura/CONSTANCIA%20DE%20TITULARIDAD.doc', 6, 0),
(32, 8, 'Constancia de Rehabilitación', 'sura/Constancia%20de%20REHABILITACION.doc', 7, 0),
(33, 8, 'Denuncia de Venta', 'sura/CARTA%20DENUNCIA%20DE%20VENTA.doc', 8, 0),
(34, 8, 'Nota Embargo', 'sura/Nota_Embargo.doc', 9, 0),
(35, 9, 'Descarga Completa del Sistema', 'gestores/InstEstGes.exe', 1, 0),
(36, 9, 'Actualización Tablas AFIP/API (Enero / 2021)', 'https://drive.google.com/file/d/1Hj89rQ9vlPSRlbdEusiK4J7C65TP99f7/view?usp=sharing', 2, 0),
(37, 10, 'Descargar Versión Completa', 'formularios/EstForm.exe', 1, 0),
(38, 10, 'Descargar Actualización Ago/2014', 'formularios/ef5417.exe', 2, 0),
(39, 11, '21001', 'registros/2021a/21001.exe', 1, 0),
(40, 11, '21002', 'registros/2021a/21002.exe', 2, 0),
(41, 11, '21003', 'registros/2021a/21003.exe', 3, 0),
(42, 11, '21004', 'registros/2021a/21004.exe', 4, 0),
(43, 11, '21005', 'registros/2021a/21005.exe', 5, 0),
(44, 11, '21006', 'registros/2021a/21006.exe', 6, 0),
(45, 11, '21007', 'registros/2021a/21007.exe', 7, 0),
(46, 11, '21008', 'registros/2021a/21008.exe', 8, 0),
(47, 11, '21009', 'registros/2021a/21009.exe', 9, 0),
(48, 11, '21010', 'registros/2021a/21010.exe', 10, 0),
(49, 11, '21011', 'registros/2021a/21011.exe', 11, 0),
(50, 11, '21012', 'registros/2021a/21012.exe', 12, 0),
(51, 11, '21013', 'registros/2021a/21013.exe', 13, 0),
(52, 11, '21014', 'registros/2021a/21014.exe', 14, 0),
(53, 11, '21015', 'registros/2021a/21015.exe', 15, 0),
(54, 2, 'Detalle de los manuales de SIPRES del 2021', 'www.gestionregistral.com.ar/manuales/sipres', 1, 0),
(55, 1, '1 de Septiembre 2021', 'https://drive.google.com/file/d/1tqqFQP9gyC2zJLDJ43r07rvhPdmDNja3/view?usp=sharing', 6, 0),
(56, 1, '01 de Octubre de 2021', 'https://drive.google.com/file/d/1R-K1E7OIz0GQdbU2LgwbvFw9efL8Ex7Y/view?usp=sharing', 7, 0),
(57, 4, 'Turnos y Vencimientos', 'https://drive.google.com/file/d/1BLJRKJ8rpr_a8PQ6D1Hh0os1B0N-zRFn/view?usp=sharing', 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_pantallas`
--

CREATE TABLE `menu_pantallas` (
  `id_menu` int(3) NOT NULL,
  `descripcion_menu` varchar(50) NOT NULL,
  `url` varchar(20) NOT NULL,
  `icono` varchar(60) NOT NULL,
  `footer_pantalla` varchar(200) NOT NULL,
  `oculto` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `menu_pantallas`
--

INSERT INTO `menu_pantallas` (`id_menu`, `descripcion_menu`, `url`, `icono`, `footer_pantalla`, `oculto`) VALUES
(1, 'Registros', 'Registros', 'pi pi-fw pi-file', 'Descargue el que corresponda. Si esta en la Computadora que tiene instalado el sistema, puede elegir directamente la opción ABRIR o EJECUTAR y automáticamente comenzara a instalarse.', 0),
(2, 'Sura', 'Sura', 'pi pi-fw pi-pencil', '', 0),
(3, 'Gestores', 'Gestores', 'pi pi-fw pi-user', '', 0),
(4, 'Formularios', 'Formularios', 'pi pi-fw pi-calendar', '', 0),
(5, 'Sellados', 'Sellados', 'pi pi-fw pi-power-off', '', 0),
(6, 'Administrar', 'Admin', 'pi pi-lock-open', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `titulos`
--

CREATE TABLE `titulos` (
  `id_titulo` int(11) NOT NULL,
  `id_menu` int(3) NOT NULL,
  `descripcion_titulo` varchar(50) NOT NULL,
  `imagen_path` varchar(100) NOT NULL,
  `footer` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `titulos`
--

INSERT INTO `titulos` (`id_titulo`, `id_menu`, `descripcion_titulo`, `imagen_path`, `footer`) VALUES
(1, 1, 'Sellado Santa Fe', '', ''),
(2, 1, 'SIPRES', '', ''),
(3, 1, 'Sellado Entre Rios', '', ''),
(4, 1, 'Sistema de Caja', '', 'Sistema Estribo Caja (Un sistema para simplificar la rendición de la caja diaria y llevar un control de los gastos diarios y mensuales)'),
(5, 2, 'Navegadores', '', ''),
(6, 2, 'Programas para Sura', '', ''),
(7, 2, 'Utilitarios', '', ''),
(8, 2, 'Modelo de Cartas/Notas en Word', '', ''),
(9, 3, 'Sistema de Tablas de Valuacion', '', '(Costo de la Actualización: El equivalente a 4 certificaciones de firmasen el Registro de la Propiedad del Automotor y CP.)'),
(10, 4, 'Sistema Estribo Formularios', 'formularios.jpg', ''),
(11, 5, 'Sellados (Habilitaciones)', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `clave` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `mail`, `clave`) VALUES
(1, 'cfditoro@estribo.com', '12345678');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `links`
--
ALTER TABLE `links`
  ADD PRIMARY KEY (`id_link`),
  ADD KEY `titulo` (`id_titulo`);

--
-- Indices de la tabla `menu_pantallas`
--
ALTER TABLE `menu_pantallas`
  ADD UNIQUE KEY `id_menu` (`id_menu`);

--
-- Indices de la tabla `titulos`
--
ALTER TABLE `titulos`
  ADD PRIMARY KEY (`id_titulo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `links`
--
ALTER TABLE `links`
  MODIFY `id_link` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `titulos`
--
ALTER TABLE `titulos`
  MODIFY `id_titulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
