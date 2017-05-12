-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-05-2017 a las 22:25:10
-- Versión del servidor: 5.7.14
-- Versión de PHP: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `adminlab`
--
CREATE DATABASE IF NOT EXISTS `adminlab` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `adminlab`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `backups`
--

DROP TABLE IF EXISTS `backups`;
CREATE TABLE IF NOT EXISTS `backups` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `file_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `backup_size` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `backups_name_unique` (`name`),
  UNIQUE KEY `backups_file_name_unique` (`file_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `tags` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '[]',
  `color` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `departments_name_unique` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `departments`
--

INSERT INTO `departments` (`id`, `name`, `tags`, `color`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Administration', '[]', '#000', NULL, '2017-03-07 04:21:33', '2017-03-07 04:21:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `designation` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Male',
  `mobile` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mobile2` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `dept` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `city` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `about` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_birth` date NOT NULL DEFAULT '1990-01-01',
  `date_hire` date NOT NULL,
  `date_left` date NOT NULL DEFAULT '1990-01-01',
  `salary_cur` decimal(15,3) NOT NULL DEFAULT '0.000',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employees_email_unique` (`email`),
  KEY `employees_dept_foreign` (`dept`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`id`, `name`, `designation`, `gender`, `mobile`, `mobile2`, `email`, `dept`, `city`, `address`, `about`, `date_birth`, `date_hire`, `date_left`, `salary_cur`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Administrador', 'Super Admin', 'Male', '8888888888', '', 'administrador@adminlab.com', 1, 'Pune', 'Karve nagar, Pune 411030', 'About user / biography', '2017-03-06', '2017-03-06', '2017-03-06', '0.000', NULL, '2017-03-07 04:23:44', '2017-03-07 04:23:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

DROP TABLE IF EXISTS `equipos`;
CREATE TABLE IF NOT EXISTS `equipos` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `descripcion` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `marca` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `codigo` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `anaquel` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `estante` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `cantidad` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `laboratorios`
--

DROP TABLE IF EXISTS `laboratorios`;
CREATE TABLE IF NOT EXISTS `laboratorios` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nombre` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `gcalendar_cal_id` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `color_frente` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `color_fondo` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `laboratorios`
--

INSERT INTO `laboratorios` (`id`, `deleted_at`, `created_at`, `updated_at`, `nombre`, `gcalendar_cal_id`, `color_frente`, `color_fondo`) VALUES
(1, NULL, '2017-05-12 07:59:56', '2017-05-12 07:59:56', 'Laboratorio de Ciencias', '', '#FFFFFF', '#308449');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `la_configs`
--

DROP TABLE IF EXISTS `la_configs`;
CREATE TABLE IF NOT EXISTS `la_configs` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `section` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `la_configs`
--

INSERT INTO `la_configs` (`id`, `key`, `section`, `value`, `created_at`, `updated_at`) VALUES
(1, 'sitename', '', 'AdminLab', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(2, 'sitename_part1', '', 'Admin', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(3, 'sitename_part2', '', 'Lab', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(4, 'sitename_short', '', 'AL', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(5, 'site_description', '', 'Administración de Laboratorios y Suministros', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(6, 'sidebar_search', '', '0', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(7, 'show_messages', '', '0', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(8, 'show_notifications', '', '0', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(9, 'show_tasks', '', '0', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(10, 'show_rightsidebar', '', '0', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(11, 'skin', '', 'skin-blue', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(12, 'layout', '', 'layout-boxed', '2017-03-07 04:21:33', '2017-03-07 08:39:17'),
(13, 'default_email', '', 'administrador@laraadmin.com', '2017-03-07 04:21:33', '2017-03-07 08:39:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `la_menus`
--

DROP TABLE IF EXISTS `la_menus`;
CREATE TABLE IF NOT EXISTS `la_menus` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'fa-cube',
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'module',
  `parent` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `hierarchy` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `la_menus`
--

INSERT INTO `la_menus` (`id`, `name`, `url`, `icon`, `type`, `parent`, `hierarchy`, `created_at`, `updated_at`) VALUES
(2, 'Users', 'users', 'fa-group', 'module', 1, 1, '2017-03-07 04:21:33', '2017-03-07 11:15:08'),
(6, 'Roles', 'roles', 'fa-user-plus', 'module', 1, 2, '2017-03-07 04:21:33', '2017-03-07 11:15:08'),
(8, 'Permissions', 'permissions', 'fa-magic', 'module', 1, 3, '2017-03-07 04:21:33', '2017-03-07 11:15:08'),
(9, 'Préstamos', 'prestamos', 'fa fa-cube', 'module', 0, 2, '2017-03-07 08:50:08', '2017-04-05 08:49:56'),
(10, 'Reservaciones', 'reservaciones', 'fa fa-cube', 'module', 0, 1, '2017-03-07 09:09:21', '2017-04-05 08:49:56'),
(11, 'Laboratorios', 'laboratorios', 'fa fa-cube', 'module', 20, 2, '2017-03-07 09:31:27', '2017-04-21 10:59:34'),
(12, 'Prácticas', 'practicas', 'fa fa-cube', 'module', 20, 1, '2017-03-07 09:41:34', '2017-04-21 10:59:30'),
(13, 'Materiales', 'materiales', 'fa fa-cube', 'module', 20, 3, '2017-03-07 10:08:11', '2017-04-21 10:59:40'),
(16, 'Reactivos', 'reactivos', 'fa fa-cube', 'module', 20, 4, '2017-03-07 11:36:24', '2017-04-21 10:59:43'),
(19, 'Users', 'users', 'fa-group', 'module', 21, 1, '2017-04-05 08:49:52', '2017-04-21 11:00:16'),
(20, 'Configuración', '#', 'fa-cube', 'custom', 0, 3, '2017-04-21 10:59:12', '2017-04-21 11:00:16'),
(21, 'Administración', '#', 'fa-cube', 'custom', 0, 4, '2017-04-21 11:00:00', '2017-04-21 11:00:16'),
(22, 'Prácticas', 'reservaspracticas', 'fa fa-cube', 'module', 10, 1, '2017-04-22 06:33:17', '2017-04-22 06:33:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

DROP TABLE IF EXISTS `materiales`;
CREATE TABLE IF NOT EXISTS `materiales` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `descripcion` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cantidad` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `marca` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `codigo` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `anaquel` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `estante` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`id`, `deleted_at`, `created_at`, `updated_at`, `descripcion`, `cantidad`, `marca`, `codigo`, `anaquel`, `estante`) VALUES
(1, NULL, '2017-04-05 05:22:01', '2017-04-05 05:35:08', 'LABQUEST', 4, 'Vernier Software & Technologi', '9221425', 1, 4),
(2, NULL, '2017-04-05 05:37:18', '2017-04-05 05:37:18', 'EKG Sensor', 12, 'Vernier Software & Technology', 'EKG-BTA', 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_05_26_050000_create_modules_table', 1),
('2014_05_26_055000_create_module_field_types_table', 1),
('2014_05_26_060000_create_module_fields_table', 1),
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1),
('2014_12_01_000000_create_uploads_table', 1),
('2016_05_26_064006_create_departments_table', 1),
('2016_05_26_064007_create_employees_table', 1),
('2016_05_26_064446_create_roles_table', 1),
('2016_07_05_115343_create_role_user_table', 1),
('2016_07_06_140637_create_organizations_table', 1),
('2016_07_07_134058_create_backups_table', 1),
('2016_07_07_134058_create_menus_table', 1),
('2016_09_10_163337_create_permissions_table', 1),
('2016_09_10_163520_create_permission_role_table', 1),
('2016_09_22_105958_role_module_fields_table', 1),
('2016_09_22_110008_role_module_table', 1),
('2016_10_06_115413_create_la_configs_table', 1),
('2017_03_07_024902_create_reservaciones_table', 2),
('2017_03_07_025810_create_prestamos_table', 1),
('2017_03_07_033127_create_laboratorios_table', 1),
('2017_03_07_034134_create_practicas_table', 1),
('2017_03_07_040811_create_materiales_table', 1),
('2017_03_07_041644_create_equipos_table', 1),
('2017_03_07_053624_create_reactivos_table', 1),
('2017_04_22_013317_create_reservaspracticas_table', 1),
('2017_05_04_194217_create_practicasmateriales_table', 1),
('2017_05_05_180840_create_practicasreactivos_table', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name_db` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `view_col` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `controller` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fa_icon` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'fa-cube',
  `is_gen` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `modules`
--

INSERT INTO `modules` (`id`, `name`, `label`, `name_db`, `view_col`, `model`, `controller`, `fa_icon`, `is_gen`, `created_at`, `updated_at`) VALUES
(1, 'Users', 'Users', 'users', 'nombre', 'User', 'UsersController', 'fa-group', 1, '2017-03-07 04:21:30', '2017-03-07 10:52:25'),
(2, 'Uploads', 'Uploads', 'uploads', 'name', 'Upload', 'UploadsController', 'fa-files-o', 1, '2017-03-07 04:21:30', '2017-03-07 04:21:33'),
(5, 'Roles', 'Roles', 'roles', 'name', 'Role', 'RolesController', 'fa-user-plus', 1, '2017-03-07 04:21:31', '2017-03-07 04:21:33'),
(7, 'Backups', 'Backups', 'backups', 'name', 'Backup', 'BackupsController', 'fa-hdd-o', 1, '2017-03-07 04:21:31', '2017-03-07 04:21:33'),
(8, 'Permissions', 'Permissions', 'permissions', 'name', 'Permission', 'PermissionsController', 'fa-magic', 1, '2017-03-07 04:21:32', '2017-03-07 04:21:33'),
(9, 'Prestamos', 'Préstamos', 'prestamos', 'fecha_inicio', 'Prestamo', 'PrestamosController', 'fa-cube', 1, '2017-03-07 08:42:35', '2017-03-07 08:50:18'),
(10, 'Reservaciones', 'Reservaciones', 'reservaciones', 'fecha_inicio', 'Reservacione', 'ReservacionesController', 'fa-cube', 1, '2017-03-07 09:04:24', '2017-03-07 09:09:21'),
(11, 'Laboratorios', 'Laboratorios', 'laboratorios', 'nombre', 'Laboratorio', 'LaboratoriosController', 'fa-cube', 1, '2017-03-07 09:30:31', '2017-03-07 09:31:27'),
(12, 'Practicas', 'Prácticas', 'practicas', 'nombre', 'Practica', 'PracticasController', 'fa-cube', 1, '2017-03-07 09:32:28', '2017-04-22 06:48:28'),
(13, 'Materiales', 'Materiales', 'materiales', 'descripcion', 'Materiale', 'MaterialesController', 'fa-cube', 1, '2017-03-07 09:48:17', '2017-04-22 06:54:39'),
(15, 'Reactivos', 'Reactivos', 'reactivos', 'nombre', 'Reactivo', 'ReactivosController', 'fa-cube', 1, '2017-03-07 11:29:31', '2017-04-05 05:26:49'),
(16, 'ReservasPracticas', 'ReservasPracticas', 'reservaspracticas', 'practica', 'ReservasPractica', 'ReservasPracticasController', 'fa-cube', 1, '2017-04-22 06:30:00', '2017-04-22 06:33:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `module_fields`
--

DROP TABLE IF EXISTS `module_fields`;
CREATE TABLE IF NOT EXISTS `module_fields` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `colname` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `module` int(10) UNSIGNED NOT NULL,
  `field_type` int(10) UNSIGNED NOT NULL,
  `unique` tinyint(1) NOT NULL DEFAULT '0',
  `defaultvalue` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `minlength` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxlength` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `popup_vals` text COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_fields_module_foreign` (`module`),
  KEY `module_fields_field_type_foreign` (`field_type`)
) ENGINE=MyISAM AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `module_fields`
--

INSERT INTO `module_fields` (`id`, `colname`, `label`, `module`, `field_type`, `unique`, `defaultvalue`, `minlength`, `maxlength`, `required`, `popup_vals`, `sort`, `created_at`, `updated_at`) VALUES
(1, 'nombre', 'Nombre', 1, 16, 0, '', 5, 250, 1, '', 0, '2017-03-07 04:21:30', '2017-03-07 10:49:59'),
(2, 'contexto_id', 'Contexto', 1, 13, 0, '0', 0, 11, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 10:50:31'),
(3, 'email', 'Email', 1, 8, 1, '', 0, 250, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(4, 'password', 'Password', 1, 17, 0, '', 3, 250, 1, '', 0, '2017-03-07 04:21:30', '2017-03-07 11:19:48'),
(5, 'tipo', 'Tipo de Usuario', 1, 7, 0, '', 0, 0, 1, '@roles', 0, '2017-03-07 04:21:30', '2017-04-05 08:49:29'),
(6, 'name', 'Name', 2, 16, 0, '', 5, 250, 1, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(7, 'path', 'Path', 2, 19, 0, '', 0, 250, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(8, 'extension', 'Extension', 2, 19, 0, '', 0, 20, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(9, 'caption', 'Caption', 2, 19, 0, '', 0, 250, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(10, 'user_id', 'Owner', 2, 7, 0, '1', 0, 0, 0, '@users', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(11, 'hash', 'Hash', 2, 19, 0, '', 0, 250, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(12, 'public', 'Is Public', 2, 2, 0, '0', 0, 0, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(30, 'name', 'Name', 5, 16, 1, '', 1, 250, 1, '', 0, '2017-03-07 04:21:31', '2017-03-07 04:21:31'),
(31, 'display_name', 'Display Name', 5, 19, 0, '', 0, 250, 1, '', 0, '2017-03-07 04:21:31', '2017-03-07 04:21:31'),
(32, 'description', 'Description', 5, 21, 0, '', 0, 1000, 0, '', 0, '2017-03-07 04:21:31', '2017-03-07 04:21:31'),
(33, 'parent', 'Parent Role', 5, 7, 0, '1', 0, 0, 0, '@roles', 0, '2017-03-07 04:21:31', '2017-03-07 04:21:31'),
(74, 'estante', 'Número de Estante', 13, 13, 0, '', 1, 11, 1, '', 6, '2017-03-07 11:28:21', '2017-03-07 11:28:21'),
(73, 'anaquel', 'Número de Anaquel', 13, 13, 0, '', 1, 11, 1, '', 5, '2017-03-07 11:27:47', '2017-03-07 11:27:47'),
(72, 'codigo', 'Código', 13, 22, 0, '', 3, 256, 1, '', 4, '2017-03-07 11:27:17', '2017-04-05 20:55:28'),
(71, 'marca', 'Marca', 13, 22, 0, '', 3, 256, 1, '', 2, '2017-03-07 11:26:40', '2017-04-05 20:55:45'),
(46, 'name', 'Name', 7, 16, 1, '', 0, 250, 1, '', 0, '2017-03-07 04:21:31', '2017-03-07 04:21:31'),
(47, 'file_name', 'File Name', 7, 19, 1, '', 0, 250, 1, '', 0, '2017-03-07 04:21:31', '2017-03-07 04:21:31'),
(48, 'backup_size', 'File Size', 7, 19, 0, '0', 0, 10, 1, '', 0, '2017-03-07 04:21:31', '2017-03-07 04:21:31'),
(49, 'name', 'Name', 8, 16, 1, '', 1, 250, 1, '', 0, '2017-03-07 04:21:32', '2017-03-07 04:21:32'),
(50, 'display_name', 'Display Name', 8, 19, 0, '', 0, 250, 1, '', 0, '2017-03-07 04:21:32', '2017-03-07 04:21:32'),
(51, 'description', 'Description', 8, 21, 0, '', 0, 1000, 0, '', 0, '2017-03-07 04:21:32', '2017-03-07 04:21:32'),
(52, 'fecha_inicio', 'Fecha de Inicio', 9, 5, 0, '', 0, 0, 1, '', 0, '2017-03-07 08:47:11', '2017-03-07 08:47:11'),
(53, 'fecha_fin', 'Fecha de Fin', 9, 5, 0, '', 0, 0, 1, '', 0, '2017-03-07 08:47:31', '2017-03-07 08:47:31'),
(54, 'fecha_inicio', 'Fecha de Inicio', 10, 5, 0, '', 0, 0, 1, '', 0, '2017-03-07 09:04:24', '2017-03-07 09:07:55'),
(55, 'fecha_fin', 'Fecha de Fin', 10, 5, 0, '', 0, 0, 1, '', 0, '2017-03-07 09:04:24', '2017-03-07 09:09:37'),
(56, 'nombre', 'Nombre', 11, 16, 1, '', 3, 256, 1, '', 0, '2017-03-07 09:31:16', '2017-04-22 06:44:25'),
(57, 'nombre', 'Nombre', 12, 16, 1, '', 3, 256, 1, '', 1, '2017-03-07 09:32:49', '2017-03-07 09:32:49'),
(58, 'objetivo', 'Objetivo', 12, 21, 0, '', 3, 256, 1, '', 2, '2017-03-07 09:33:23', '2017-03-08 22:47:51'),
(80, 'duracion', 'Duración ', 12, 13, 0, '3600', 0, 11, 1, '', 5, '2017-04-05 05:02:51', '2017-04-05 05:02:51'),
(79, 'practica_pdf', 'Subir práctica ', 12, 9, 0, '', 0, 0, 1, '', 6, '2017-04-05 04:57:34', '2017-04-05 04:57:34'),
(63, 'descripcion', 'Descripción', 13, 16, 1, '', 3, 256, 1, '', 1, '2017-03-07 09:48:40', '2017-03-07 11:26:16'),
(77, 'unidad', 'Unidad de Medida', 15, 7, 0, '', 0, 0, 0, '["kg","g","l","ml","cajas","paquetes"]', 3, '2017-03-07 11:36:13', '2017-03-07 11:36:13'),
(76, 'cantidad', 'Cantidad', 15, 13, 0, '0', 0, 11, 1, '', 2, '2017-03-07 11:31:42', '2017-03-07 11:31:42'),
(75, 'nombre', 'Nombre', 15, 16, 0, '', 3, 256, 1, '', 1, '2017-03-07 11:31:08', '2017-03-07 11:31:08'),
(70, 'cantidad', 'Cantidad', 13, 13, 0, '', 0, 11, 1, '', 3, '2017-03-07 10:28:41', '2017-03-07 10:28:41'),
(89, 'laboratorio_id', 'Laboratorio', 16, 18, 0, '', 0, 0, 1, '@laboratorios', 2, '2017-04-22 12:53:44', '2017-04-22 12:53:44'),
(85, 'practica_id', 'Práctica a realizar', 16, 18, 0, '', 0, 0, 1, '@practicas', 1, '2017-04-22 06:30:45', '2017-04-22 06:30:45'),
(87, 'fecha_inicio', 'Fecha de Inicio', 16, 5, 0, '', 0, 0, 1, '', 3, '2017-04-22 06:32:27', '2017-04-22 06:32:27'),
(88, 'solicitante_id', 'Solicitante', 16, 7, 0, '', 0, 256, 1, '@users', 4, '2017-04-22 06:33:02', '2017-04-22 07:10:10'),
(90, 'gcalendar_event_id', 'ID Google Calendar', 16, 16, 1, '', 0, 256, 0, '', 6, '2017-04-22 13:04:04', '2017-04-22 13:04:04'),
(91, 'gcalendar_cal_id', 'ID Google Calendar', 11, 16, 1, '', 0, 256, 0, '', 0, '2017-04-25 00:36:16', '2017-04-25 00:36:16'),
(92, 'color_frente', 'Color de Frente', 11, 19, 0, '', 0, 7, 0, '', 0, '2017-05-01 07:45:15', '2017-05-01 07:45:55'),
(93, 'color_fondo', 'Color de Fondo', 11, 19, 0, '', 0, 7, 0, '', 0, '2017-05-01 07:45:33', '2017-05-01 07:46:08'),
(94, 'participantes', 'Núm. Participantes', 16, 13, 0, '10', 1, 11, 1, '', 5, '2017-05-01 08:16:28', '2017-05-01 08:23:10'),
(95, 'fecha_fin', 'Fecha de Fin', 16, 5, 0, '', 0, 0, 1, '', 3, '2017-04-22 06:32:27', '2017-04-22 06:32:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `module_field_types`
--

DROP TABLE IF EXISTS `module_field_types`;
CREATE TABLE IF NOT EXISTS `module_field_types` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `module_field_types`
--

INSERT INTO `module_field_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Address', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(2, 'Checkbox', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(3, 'Currency', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(4, 'Date', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(5, 'Datetime', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(6, 'Decimal', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(7, 'Dropdown', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(8, 'Email', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(9, 'File', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(10, 'Float', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(11, 'HTML', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(12, 'Image', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(13, 'Integer', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(14, 'Mobile', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(15, 'Multiselect', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(16, 'Name', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(17, 'Password', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(18, 'Radio', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(19, 'String', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(20, 'Taginput', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(21, 'Textarea', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(22, 'TextField', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(23, 'URL', '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(24, 'Files', '2017-03-07 04:21:30', '2017-03-07 04:21:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `organizations`
--

DROP TABLE IF EXISTS `organizations`;
CREATE TABLE IF NOT EXISTS `organizations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'http://',
  `assigned_to` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `connect_since` date NOT NULL,
  `address` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `profile_image` int(11) NOT NULL,
  `profile` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organizations_name_unique` (`name`),
  UNIQUE KEY `organizations_email_unique` (`email`),
  KEY `organizations_assigned_to_foreign` (`assigned_to`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `display_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'ADMIN_PANEL', 'Panel de Administración', 'Permiso de acceso a la configuración del sistema', NULL, '2017-03-07 04:21:33', '2017-03-07 10:54:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE IF NOT EXISTS `permission_role` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practicas`
--

DROP TABLE IF EXISTS `practicas`;
CREATE TABLE IF NOT EXISTS `practicas` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nombre` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `objetivo` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `practica_pdf` int(11) NOT NULL DEFAULT '0',
  `duracion` int(10) UNSIGNED NOT NULL DEFAULT '3600',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `practicas`
--

INSERT INTO `practicas` (`id`, `deleted_at`, `created_at`, `updated_at`, `nombre`, `objetivo`, `practica_pdf`, `duracion`) VALUES
(3, NULL, '2017-04-05 05:31:02', '2017-05-05 07:47:59', 'Práctica 1. Conocimiento del equipo de interfaz independiente Labquest ', 'Conocerá las partes que conforman el equipo de Labquest marca vernier así como las mediciones que se pueden llevar a cabo con sensores que a él se le pueden integrar. ', 1, 3600);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practicasmateriales`
--

DROP TABLE IF EXISTS `practicasmateriales`;
CREATE TABLE IF NOT EXISTS `practicasmateriales` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `practica_id` int(10) UNSIGNED NOT NULL,
  `material_id` int(10) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `por_grupo` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `practicasmateriales`
--

INSERT INTO `practicasmateriales` (`id`, `practica_id`, `material_id`, `cantidad`, `por_grupo`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 3, 2, 1, 0, NULL, '2017-05-04 20:45:00', '2017-05-05 21:05:16'),
(2, 3, 1, 3, 0, NULL, '2017-05-04 20:46:00', '2017-05-05 20:58:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practicasreactivos`
--

DROP TABLE IF EXISTS `practicasreactivos`;
CREATE TABLE IF NOT EXISTS `practicasreactivos` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `practica_id` int(10) UNSIGNED NOT NULL,
  `reactivo_id` int(10) UNSIGNED NOT NULL,
  `cantidad` decimal(10,2) UNSIGNED NOT NULL DEFAULT '1.00',
  `por_grupo` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `practicasreactivos`
--

INSERT INTO `practicasreactivos` (`id`, `practica_id`, `reactivo_id`, `cantidad`, `por_grupo`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 3, 2, '14.24', 0, '2017-05-06 00:16:21', '2017-05-05 23:43:18', '2017-05-06 00:16:21'),
(2, 3, 1, '1.00', 1, NULL, '2017-05-06 00:02:29', '2017-05-06 00:02:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE IF NOT EXISTS `prestamos` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `fecha_fin` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reactivos`
--

DROP TABLE IF EXISTS `reactivos`;
CREATE TABLE IF NOT EXISTS `reactivos` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nombre` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cantidad` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `unidad` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `reactivos`
--

INSERT INTO `reactivos` (`id`, `deleted_at`, `created_at`, `updated_at`, `nombre`, `cantidad`, `unidad`) VALUES
(1, NULL, '2017-04-05 05:28:08', '2017-04-05 05:28:08', 'test', 1, 'kg'),
(2, NULL, '2017-05-05 09:35:43', '2017-05-05 09:35:43', 'Ácido Sulfúrico', 20, 'l');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservaciones`
--

DROP TABLE IF EXISTS `reservaciones`;
CREATE TABLE IF NOT EXISTS `reservaciones` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_inicio` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `fecha_fin` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservaspracticas`
--

DROP TABLE IF EXISTS `reservaspracticas`;
CREATE TABLE IF NOT EXISTS `reservaspracticas` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `practica_id` int(10) UNSIGNED NOT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `fecha_fin` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `solicitante_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `laboratorio_id` int(10) UNSIGNED NOT NULL,
  `gcalendar_event_id` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `participantes` int(10) UNSIGNED NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `reservaspracticas_solicitante_foreign` (`solicitante_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `reservaspracticas`
--

INSERT INTO `reservaspracticas` (`id`, `deleted_at`, `created_at`, `updated_at`, `practica_id`, `fecha_inicio`, `fecha_fin`, `solicitante_id`, `laboratorio_id`, `gcalendar_event_id`, `participantes`) VALUES
(1, '2017-04-22 13:51:08', '2017-04-22 13:50:53', '2017-04-22 13:51:08', 3, '2017-04-30 17:00:00', '1970-01-01 07:01:01', 1, 1, 's6vdtg95f70e8o2n98t4or8v88', 10),
(2, '2017-04-22 13:54:15', '2017-04-22 13:53:26', '2017-04-22 13:54:15', 3, '2017-04-30 17:04:00', '1970-01-01 07:01:01', 1, 1, 'qes6jq7iaq36qhk7t3jkbmvv00', 10),
(3, '2017-04-24 20:37:13', '2017-04-24 20:34:57', '2017-04-24 20:37:13', 3, '2017-04-28 17:00:00', '1970-01-01 07:01:01', 1, 1, 'n1bnko4m41ik39di3qk56bpf78', 10),
(4, '2017-04-24 20:37:04', '2017-04-24 20:35:33', '2017-04-24 20:37:04', 3, '2017-04-28 17:00:00', '1970-01-01 07:01:01', 1, 1, 'cdl15tki2603bu3atb2p9aeicc', 10),
(5, '2017-04-25 01:56:31', '2017-04-25 00:58:12', '2017-04-25 01:56:31', 3, '2017-04-27 17:00:00', '1970-01-01 07:01:01', 1, 1, '270ie5ofrbdkln37dlfj45qcd4', 10),
(6, '2017-04-25 01:00:39', '2017-04-25 01:00:28', '2017-04-25 01:00:39', 3, '2017-04-27 17:00:00', '1970-01-01 07:01:01', 1, 1, 'ghc3kqqptvqmngi9j1qlhge45g', 10),
(7, '2017-04-25 01:56:36', '2017-04-25 01:46:37', '2017-04-25 01:56:36', 3, '2017-04-27 17:00:00', '1970-01-01 07:01:01', 1, 1, 'i2akqqn4mip6v2dr1vrhqp373g', 10),
(8, '2017-04-28 20:30:21', '2017-04-25 02:00:57', '2017-04-28 20:30:21', 3, '2017-04-28 17:00:00', '1970-01-01 07:01:01', 1, 3, 'i9cuqt5ji09ag9q47ip98ihlng', 10),
(9, '2017-04-25 04:22:31', '2017-04-25 02:01:27', '2017-04-25 04:22:31', 3, '2017-04-28 17:00:00', '1970-01-01 07:01:01', 1, 3, '57ld8qpiuh9cmfqju60b4e6hg0', 10),
(10, '2017-04-25 07:19:51', '2017-04-25 07:18:51', '2017-04-25 07:19:51', 3, '2017-04-27 17:00:00', '1970-01-01 07:01:01', 1, 3, 'r0mktgun1hlpi0626knj9ner7k', 10),
(11, '2017-04-25 07:28:26', '2017-04-25 07:25:35', '2017-04-25 07:28:26', 3, '2017-04-26 05:00:00', '1970-01-01 07:01:01', 1, 3, '9sgtkou2psb054ukk8lot60uac', 10),
(12, '2017-04-25 08:30:12', '2017-04-25 08:29:53', '2017-04-25 08:30:12', 3, '2017-04-26 17:00:00', '1970-01-01 07:01:01', 1, 3, 'oonst4dmc48ta17623ajmvmofc', 10),
(13, '2017-04-26 21:27:02', '2017-04-26 21:25:13', '2017-04-26 21:27:02', 3, '2017-04-26 05:00:00', '1970-01-01 07:01:01', 1, 3, 's4oem0jm0jm2dhoc165di1rljs', 10),
(14, '2017-04-26 21:28:30', '2017-04-26 21:27:29', '2017-04-26 21:28:30', 3, '2017-04-28 17:00:00', '1970-01-01 07:01:01', 1, 3, '2a7d6mh9651tvftcjia9ffvikg', 10),
(15, '2017-05-06 02:14:04', '2017-04-28 21:34:25', '2017-05-06 02:14:04', 3, '2017-04-30 17:00:00', '1970-01-01 07:01:01', 1, 1, 'fu9egc91q7jl2a2dpu00g5eepo', 12),
(16, '2017-05-06 02:13:56', '2017-04-28 22:15:28', '2017-05-06 02:13:56', 3, '2017-04-29 17:00:00', '1970-01-01 07:01:01', 1, 2, 'fahpf0828gdbso44ahobehha2c', 10),
(17, '2017-05-12 03:34:19', '2017-05-06 02:14:28', '2017-05-12 03:34:19', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 1, 'h4g63kq40v0usnrqekr3nv6s1o', 10),
(18, '2017-05-12 01:13:09', '2017-05-12 01:00:28', '2017-05-12 01:13:09', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 1, '', 10),
(19, '2017-05-12 01:14:28', '2017-05-12 01:14:04', '2017-05-12 01:14:28', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 1, '', 10),
(20, '2017-05-12 01:15:05', '2017-05-12 01:14:45', '2017-05-12 01:15:05', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 1, '', 10),
(21, '2017-05-12 03:35:41', '2017-05-12 03:31:16', '2017-05-12 03:35:41', 3, '2017-05-31 06:00:00', '2017-05-31 07:00:00', 1, 1, '', 10),
(22, '2017-05-12 03:41:47', '2017-05-12 03:35:58', '2017-05-12 03:41:47', 3, '2017-05-31 05:00:00', '1970-01-01 06:00:00', 1, 1, '', 10),
(23, '2017-05-12 04:00:17', '2017-05-12 03:42:01', '2017-05-12 04:00:17', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 1, '', 10),
(24, '2017-05-12 04:00:22', '2017-05-12 03:55:23', '2017-05-12 04:00:22', 3, '2017-05-31 06:00:00', '2017-05-31 07:00:00', 1, 1, '', 10),
(25, NULL, '2017-05-12 04:08:06', '2017-05-12 04:09:14', 3, '2017-05-31 06:00:00', '2017-05-31 07:00:00', 1, 1, '', 10),
(26, '2017-05-12 04:10:00', '2017-05-12 04:08:34', '2017-05-12 04:10:00', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 2, '', 10),
(27, '2017-05-12 04:39:36', '2017-05-12 04:39:10', '2017-05-12 04:39:36', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 2, '', 10),
(28, '2017-05-12 08:01:33', '2017-05-12 07:47:10', '2017-05-12 08:01:33', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 4, '', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `display_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `parent` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`),
  KEY `roles_parent_foreign` (`parent`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `parent`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'SUPER_ADMIN', 'Administrador Raíz', 'Administrador de sistema', 0, NULL, '2017-03-07 04:21:33', '2017-03-07 10:53:37'),
(2, 'LabAdmin', 'Lab Admin', 'Administrador del laboratorio.', 1, NULL, '2017-04-05 08:28:07', '2017-04-05 08:28:07'),
(3, 'Asignatura', 'Asignatura', 'Profesor de asignatura.', 2, NULL, '2017-04-05 08:46:07', '2017-04-05 08:47:46'),
(4, 'Tiempo completo', 'Tiempo completo', 'Profesor tiempo completo', 2, NULL, '2017-04-05 08:47:33', '2017-04-05 08:47:52'),
(5, 'Investigador', 'investigador', 'Investigador de Cuvalles.', 2, NULL, '2017-04-05 08:48:31', '2017-04-05 08:48:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_module`
--

DROP TABLE IF EXISTS `role_module`;
CREATE TABLE IF NOT EXISTS `role_module` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(10) UNSIGNED NOT NULL,
  `module_id` int(10) UNSIGNED NOT NULL,
  `acc_view` tinyint(1) NOT NULL,
  `acc_create` tinyint(1) NOT NULL,
  `acc_edit` tinyint(1) NOT NULL,
  `acc_delete` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_module_role_id_foreign` (`role_id`),
  KEY `role_module_module_id_foreign` (`module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `role_module`
--

INSERT INTO `role_module` (`id`, `role_id`, `module_id`, `acc_view`, `acc_create`, `acc_edit`, `acc_delete`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1, 1, '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(2, 1, 2, 1, 1, 1, 1, '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(3, 1, 3, 1, 1, 1, 1, '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(4, 1, 4, 1, 1, 1, 1, '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(5, 1, 5, 1, 1, 1, 1, '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(6, 1, 6, 1, 1, 1, 1, '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(7, 1, 7, 1, 1, 1, 1, '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(8, 1, 8, 1, 1, 1, 1, '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(9, 1, 9, 1, 1, 1, 1, '2017-03-07 08:50:08', '2017-03-07 08:50:08'),
(10, 1, 10, 1, 1, 1, 1, '2017-03-07 09:09:21', '2017-03-07 09:09:21'),
(11, 1, 11, 1, 1, 1, 1, '2017-03-07 09:31:27', '2017-03-07 09:31:27'),
(12, 1, 12, 1, 1, 1, 1, '2017-03-07 09:41:34', '2017-03-07 09:41:34'),
(13, 1, 13, 1, 1, 1, 1, '2017-03-07 10:08:11', '2017-03-07 10:08:11'),
(14, 1, 14, 1, 1, 1, 1, '2017-03-07 10:16:44', '2017-03-07 10:16:44'),
(15, 1, 15, 1, 1, 1, 1, '2017-03-07 11:36:24', '2017-03-07 11:36:24'),
(16, 1, 16, 1, 1, 1, 1, '2017-04-22 06:33:17', '2017-04-22 06:33:17'),
(17, 2, 13, 0, 0, 0, 0, '2017-04-22 06:46:18', '2017-04-22 06:46:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_module_fields`
--

DROP TABLE IF EXISTS `role_module_fields`;
CREATE TABLE IF NOT EXISTS `role_module_fields` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(10) UNSIGNED NOT NULL,
  `field_id` int(10) UNSIGNED NOT NULL,
  `access` enum('invisible','readonly','write') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_module_fields_role_id_foreign` (`role_id`),
  KEY `role_module_fields_field_id_foreign` (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=143 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `role_module_fields`
--

INSERT INTO `role_module_fields` (`id`, `role_id`, `field_id`, `access`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(2, 1, 2, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(3, 1, 3, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(4, 1, 4, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(5, 1, 5, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(6, 1, 6, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(7, 1, 7, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(8, 1, 8, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(9, 1, 9, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(10, 1, 10, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(11, 1, 11, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(12, 1, 12, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(13, 1, 13, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(14, 1, 14, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(15, 1, 15, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(16, 1, 16, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(17, 1, 17, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(18, 1, 18, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(19, 1, 19, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(20, 1, 20, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(21, 1, 21, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(22, 1, 22, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(23, 1, 23, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(24, 1, 24, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(25, 1, 25, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(26, 1, 26, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(27, 1, 27, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(28, 1, 28, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(29, 1, 29, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(30, 1, 30, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(31, 1, 31, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(32, 1, 32, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(33, 1, 33, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(34, 1, 34, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(35, 1, 35, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(36, 1, 36, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(37, 1, 37, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(38, 1, 38, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(39, 1, 39, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(40, 1, 40, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(41, 1, 41, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(42, 1, 42, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(43, 1, 43, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(44, 1, 44, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(45, 1, 45, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(46, 1, 46, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(47, 1, 47, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(48, 1, 48, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(49, 1, 49, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(50, 1, 50, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(51, 1, 51, 'write', '2017-03-07 04:21:33', '2017-03-07 04:21:33'),
(52, 1, 52, 'write', '2017-03-07 08:47:11', '2017-03-07 08:47:11'),
(53, 1, 53, 'write', '2017-03-07 08:47:31', '2017-03-07 08:47:31'),
(54, 1, 54, 'write', '2017-03-07 09:09:21', '2017-03-07 09:09:21'),
(55, 1, 55, 'write', '2017-03-07 09:09:21', '2017-03-07 09:09:21'),
(56, 1, 56, 'write', '2017-03-07 09:31:16', '2017-03-07 09:31:16'),
(57, 1, 57, 'write', '2017-03-07 09:32:49', '2017-03-07 09:32:49'),
(58, 1, 58, 'write', '2017-03-07 09:33:23', '2017-03-07 09:33:23'),
(59, 1, 59, 'write', '2017-03-07 09:35:05', '2017-03-07 09:35:05'),
(60, 1, 60, 'write', '2017-03-07 09:37:42', '2017-03-07 09:37:42'),
(61, 1, 61, 'write', '2017-03-07 09:38:08', '2017-03-07 09:38:08'),
(62, 1, 62, 'write', '2017-03-07 09:41:23', '2017-03-07 09:41:23'),
(63, 1, 63, 'write', '2017-03-07 09:48:40', '2017-03-07 09:48:40'),
(64, 1, 64, 'write', '2017-03-07 10:14:15', '2017-03-07 10:14:15'),
(65, 1, 65, 'write', '2017-03-07 10:14:37', '2017-03-07 10:14:37'),
(66, 1, 66, 'write', '2017-03-07 10:15:19', '2017-03-07 10:15:19'),
(67, 1, 67, 'write', '2017-03-07 10:16:03', '2017-03-07 10:16:03'),
(68, 1, 68, 'write', '2017-03-07 10:16:30', '2017-03-07 10:16:30'),
(69, 1, 69, 'write', '2017-03-07 10:28:08', '2017-03-07 10:28:08'),
(70, 1, 70, 'write', '2017-03-07 10:28:41', '2017-03-07 10:28:41'),
(71, 1, 71, 'write', '2017-03-07 11:26:40', '2017-03-07 11:26:40'),
(72, 1, 72, 'write', '2017-03-07 11:27:17', '2017-03-07 11:27:17'),
(73, 1, 73, 'write', '2017-03-07 11:27:47', '2017-03-07 11:27:47'),
(74, 1, 74, 'write', '2017-03-07 11:28:21', '2017-03-07 11:28:21'),
(75, 1, 75, 'write', '2017-03-07 11:31:08', '2017-03-07 11:31:08'),
(76, 1, 76, 'write', '2017-03-07 11:31:42', '2017-03-07 11:31:42'),
(77, 1, 77, 'write', '2017-03-07 11:36:13', '2017-03-07 11:36:13'),
(78, 1, 78, 'write', '2017-03-08 22:51:26', '2017-03-08 22:51:26'),
(79, 1, 79, 'write', '2017-04-05 04:57:34', '2017-04-05 04:57:34'),
(80, 1, 80, 'write', '2017-04-05 05:02:51', '2017-04-05 05:02:51'),
(81, 1, 81, 'write', '2017-04-05 05:08:21', '2017-04-05 05:08:21'),
(82, 1, 82, 'write', '2017-04-05 05:09:09', '2017-04-05 05:09:09'),
(83, 1, 83, 'write', '2017-04-05 05:50:22', '2017-04-05 05:50:22'),
(84, 1, 84, 'write', '2017-04-05 06:30:51', '2017-04-05 06:30:51'),
(85, 1, 85, 'write', '2017-04-22 06:30:45', '2017-04-22 06:30:45'),
(86, 1, 86, 'write', '2017-04-22 06:31:45', '2017-04-22 06:31:45'),
(87, 1, 87, 'write', '2017-04-22 06:32:28', '2017-04-22 06:32:28'),
(88, 1, 88, 'write', '2017-04-22 06:33:02', '2017-04-22 06:33:02'),
(89, 2, 1, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(90, 2, 2, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(91, 2, 3, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(92, 2, 4, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(93, 2, 5, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(94, 3, 1, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(95, 3, 2, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(96, 3, 3, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(97, 3, 4, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(98, 3, 5, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(99, 4, 1, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(100, 4, 2, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(101, 4, 3, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(102, 4, 4, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(103, 4, 5, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(104, 5, 1, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(105, 5, 2, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(106, 5, 3, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(107, 5, 4, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(108, 5, 5, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(109, 2, 56, 'invisible', '2017-04-22 06:45:35', '2017-04-22 06:45:35'),
(110, 3, 56, 'invisible', '2017-04-22 06:45:35', '2017-04-22 06:45:35'),
(111, 4, 56, 'invisible', '2017-04-22 06:45:35', '2017-04-22 06:45:35'),
(112, 5, 56, 'invisible', '2017-04-22 06:45:35', '2017-04-22 06:45:35'),
(113, 2, 63, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(114, 2, 73, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(115, 2, 74, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(116, 2, 71, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(117, 2, 72, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(118, 2, 70, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(119, 3, 63, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(120, 3, 73, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(121, 3, 74, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(122, 3, 71, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(123, 3, 72, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(124, 3, 70, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(125, 4, 63, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(126, 4, 73, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(127, 4, 74, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(128, 4, 71, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(129, 4, 72, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(130, 4, 70, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(131, 5, 63, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(132, 5, 73, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(133, 5, 74, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(134, 5, 71, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(135, 5, 72, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(136, 5, 70, 'invisible', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(137, 1, 89, 'write', '2017-04-22 12:53:44', '2017-04-22 12:53:44'),
(138, 1, 90, 'write', '2017-04-22 13:04:04', '2017-04-22 13:04:04'),
(139, 1, 91, 'write', '2017-04-25 00:36:18', '2017-04-25 00:36:18'),
(140, 1, 92, 'write', '2017-05-01 07:45:15', '2017-05-01 07:45:15'),
(141, 1, 93, 'write', '2017-05-01 07:45:34', '2017-05-01 07:45:34'),
(142, 1, 94, 'write', '2017-05-01 08:16:28', '2017-05-01 08:16:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_user`
--

DROP TABLE IF EXISTS `role_user`;
CREATE TABLE IF NOT EXISTS `role_user` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  KEY `role_user_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `role_user`
--

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `uploads`
--

DROP TABLE IF EXISTS `uploads`;
CREATE TABLE IF NOT EXISTS `uploads` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `path` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `caption` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `hash` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uploads_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `uploads`
--

INSERT INTO `uploads` (`id`, `name`, `path`, `extension`, `caption`, `user_id`, `hash`, `public`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'INTRODUCCIÓN de prácticas.pdf', 'C:\\wamp640\\www\\Lab\\new\\adminlab\\storage\\uploads\\2017-04-05-001544-INTRODUCCIÓN de prácticas.pdf', 'pdf', '', 1, '9zlvcvrc408aqhwizir7', 0, NULL, '2017-04-05 05:15:44', '2017-04-05 05:15:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `contexto_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `tipo` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_tipo_foreign` (`tipo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `nombre`, `contexto_id`, `email`, `password`, `tipo`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Administrador', 1, 'administrador@adminlab.com', '$2y$10$.EpR/BnPbdzHLIE8Bb1ok.GSvCVr4N/9R8lzQFSYjknlZJ4CFUgOq', 0, 'HlxxLP6bpvZ4PqtVEr26GuTjg9k0YYkwr4rl0MvaXFYbDAlAm0v00QyCVBFA', NULL, '2017-03-07 04:23:44', '2017-04-26 21:28:54'),
(2, 'Rogelio Jimenez Meza', 1, 'rjmultimedia@gmail.com', '$2y$10$.9XHq4eYdahPDGAPruFAXOhmvhY7lRWFFCHA3XiS6EtJ5BIcwv0ey', 1, 'W0p9gePzlcxssQr1z9SUqRL43YIQNyyHn8pfoDzzAaOF14ntjlh6buI1pZv1', NULL, '2017-04-05 08:51:37', '2017-04-22 12:45:06');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
