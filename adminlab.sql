-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-05-2017 a las 22:29:47
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
(1, 'Administración', '[]', '#000', NULL, '2017-03-07 04:21:33', '2017-05-14 04:03:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `designation` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Masculino',
  `mobile` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mobile2` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `dept` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `city` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `about` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`id`, `name`, `designation`, `gender`, `mobile`, `mobile2`, `email`, `dept`, `city`, `address`, `about`, `date_birth`, `date_hire`, `date_left`, `salary_cur`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Carlos González', 'Administrador Raíz', 'Masculino', '3221119200', '', 'administrador@adminlab.com', 1, 'Puerto Vallarta, Jalisco', 'Gaviota C-1, Col. Gastronómicos', '', '1985-06-30', '2017-03-06', '1970-01-01', '10000.000', NULL, '2017-03-07 04:23:44', '2017-05-14 04:18:59'),
(2, 'Rogelio Jiménez Meza', 'Administrador Adjunto', 'Masculino', '3222921895', '', 'rjmultimedia@gmail.com', 1, 'Puerto Vallarta, Jalisco', 'Arboledas', '', '1990-01-01', '1970-01-01', '1990-01-01', '0.000', NULL, '2017-05-14 03:18:16', '2017-05-14 03:18:16'),
(3, 'Administrador de laboratorio', 'Administrador de laboratorio', 'Femenino', '88888888888', '', 'labadmin@adminlab.com', 1, '', '', '', '1990-01-01', '1970-01-01', '1990-01-01', '0.000', NULL, '2017-05-14 04:20:01', '2017-05-14 04:20:21'),
(4, 'Profesor de Asignatura', 'Profesor de Asignatura', 'Femenino', '88888888888', '', 'asignatura@adminlab.com', 1, '', '', '', '1990-01-01', '1970-01-01', '1990-01-01', '0.000', NULL, '2017-05-14 04:21:18', '2017-05-14 04:21:18'),
(5, 'Profesor de Tiempo Completo', 'Profesor de Tiempo Completo', 'Masculino', '88888888888', '', 'tiempocompleto@adminlab.com', 1, '', '', '', '1990-01-01', '1970-01-01', '1990-01-01', '0.000', NULL, '2017-05-14 04:22:02', '2017-05-14 04:22:02'),
(6, 'Profesor Investigador', 'Profesor Investigador', 'Femenino', '88888888888', '', 'investigador@adminlab.com', 1, '', '', '', '1990-01-01', '1970-01-01', '1990-01-01', '0.000', NULL, '2017-05-14 04:22:34', '2017-05-14 04:22:34');

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
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `la_menus`
--

INSERT INTO `la_menus` (`id`, `name`, `url`, `icon`, `type`, `parent`, `hierarchy`, `created_at`, `updated_at`) VALUES
(2, 'Users', 'users', 'fa-group', 'module', 1, 1, '2017-03-07 04:21:33', '2017-03-07 11:15:08'),
(6, 'Roles', 'roles', 'fa-user-plus', 'module', 1, 2, '2017-03-07 04:21:33', '2017-03-07 11:15:08'),
(8, 'Permissions', 'permissions', 'fa-magic', 'module', 1, 3, '2017-03-07 04:21:33', '2017-03-07 11:15:08'),
(9, 'Préstamos', 'prestamos', 'fa fa-cube', 'module', 0, 2, '2017-03-07 08:50:08', '2017-05-14 23:14:57'),
(29, 'Reservaciones', '#', 'fa-cube', 'custom', 0, 1, '2017-05-14 23:14:28', '2017-05-14 23:14:57'),
(11, 'Laboratorios', 'laboratorios', 'fa fa-cube', 'module', 20, 2, '2017-03-07 09:31:27', '2017-04-21 10:59:34'),
(12, 'Prácticas', 'practicas', 'fa fa-cube', 'module', 20, 1, '2017-03-07 09:41:34', '2017-04-21 10:59:30'),
(13, 'Materiales', 'materiales', 'fa fa-cube', 'module', 20, 3, '2017-03-07 10:08:11', '2017-04-21 10:59:40'),
(16, 'Reactivos', 'reactivos', 'fa fa-cube', 'module', 20, 4, '2017-03-07 11:36:24', '2017-04-21 10:59:43'),
(30, 'Prácticas', 'reservaspracticas', 'fa-cube', 'module', 29, 1, '2017-05-14 23:14:43', '2017-05-14 23:14:55'),
(20, 'Configuración', '#', 'fa-cube', 'custom', 0, 3, '2017-04-21 10:59:12', '2017-05-14 23:14:55'),
(21, 'Administración', '#', 'fa-cube', 'custom', 0, 4, '2017-04-21 11:00:00', '2017-05-14 23:14:55'),
(22, 'Prácticas', 'reservaspracticas', 'fa fa-cube', 'module', 10, 1, '2017-04-22 06:33:17', '2017-04-22 06:33:42'),
(23, 'Usuarios', 'employees', 'fa-group', 'module', 21, 1, '2017-05-14 03:01:09', '2017-05-14 23:14:33'),
(31, 'Laboratorios', 'reservaslaboratorios', 'fa fa-cube', 'module', 29, 2, '2017-05-15 01:32:33', '2017-05-15 01:40:33');

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
(1, NULL, '2017-04-05 05:22:01', '2017-05-15 08:28:49', 'LABQUEST', 20, 'Vernier Software & Technologi', '9221425', 1, 4),
(2, NULL, '2017-04-05 05:37:18', '2017-05-15 08:28:49', 'EKG Sensor', 20, 'Vernier Software & Technology', 'EKG-BTA', 1, 3);

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
('2017_05_05_180840_create_practicasreactivos_table', 3),
('2017_05_12_154729_create_movimientosmateriales_table', 4),
('2017_05_12_163644_create_movimientosreactivos_table', 5);

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
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(17, 'ReservasLaboratorios', 'Laboratorios', 'reservas', 'solicitante_id', 'ReservasLaboratorio', 'ReservasLaboratoriosController', 'fa-cube', 1, '2017-05-15 01:21:11', '2017-05-15 01:32:33'),
(11, 'Laboratorios', 'Laboratorios', 'laboratorios', 'nombre', 'Laboratorio', 'LaboratoriosController', 'fa-cube', 1, '2017-03-07 09:30:31', '2017-03-07 09:31:27'),
(12, 'Practicas', 'Prácticas', 'practicas', 'nombre', 'Practica', 'PracticasController', 'fa-cube', 1, '2017-03-07 09:32:28', '2017-04-22 06:48:28'),
(13, 'Materiales', 'Materiales', 'materiales', 'descripcion', 'Materiale', 'MaterialesController', 'fa-cube', 1, '2017-03-07 09:48:17', '2017-04-22 06:54:39'),
(15, 'Reactivos', 'Reactivos', 'reactivos', 'nombre', 'Reactivo', 'ReactivosController', 'fa-cube', 1, '2017-03-07 11:29:31', '2017-04-05 05:26:49'),
(16, 'ReservasPracticas', 'Prácticas', 'reservas', 'practica', 'ReservasPractica', 'ReservasPracticasController', 'fa-cube', 1, '2017-04-22 06:30:00', '2017-04-22 06:33:17'),
(3, 'Departments', 'Departments', 'departments', 'name', 'Department', 'DepartmentsController', 'fa-tags', 1, '2017-05-14 07:31:32', '2017-05-14 07:31:34'),
(4, 'Employees', 'Usuarios', 'employees', 'name', 'Employee', 'EmployeesController', 'fa-group', 1, '2017-05-14 07:31:32', '2017-05-14 07:31:34'),
(6, 'Organizations', 'Organizations', 'organizations', 'name', 'Organization', 'OrganizationsController', 'fa-university', 1, '2017-05-14 07:31:32', '2017-05-14 07:31:34'),
(18, 'ReservasMateriales', 'ReservasMateriales', 'reservasmateriales', '', 'ReservasMateriale', 'ReservasMaterialesController', 'fa-cube', 0, '2017-05-15 04:37:19', '2017-05-15 04:37:19');

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
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `module_fields`
--

INSERT INTO `module_fields` (`id`, `colname`, `label`, `module`, `field_type`, `unique`, `defaultvalue`, `minlength`, `maxlength`, `required`, `popup_vals`, `sort`, `created_at`, `updated_at`) VALUES
(1, 'name', 'Nombre', 1, 16, 0, '', 5, 250, 1, '', 0, '2017-03-07 04:21:30', '2017-03-07 10:49:59'),
(2, 'context_id', 'Contexto', 1, 13, 0, '0', 0, 11, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 10:50:31'),
(3, 'email', 'Email', 1, 8, 1, '', 0, 250, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(4, 'password', 'Password', 1, 17, 0, '', 3, 250, 1, '', 0, '2017-03-07 04:21:30', '2017-03-07 11:19:48'),
(5, 'type', 'Tipo de Usuario', 1, 7, 0, '', 0, 0, 1, '["Employee","Client"]', 0, '2017-03-07 04:21:30', '2017-05-14 04:00:06'),
(6, 'name', 'Name', 2, 16, 0, '', 5, 250, 1, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(7, 'path', 'Path', 2, 19, 0, '', 0, 250, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(8, 'extension', 'Extension', 2, 19, 0, '', 0, 20, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(9, 'caption', 'Caption', 2, 19, 0, '', 0, 250, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(10, 'user_id', 'Owner', 2, 7, 0, '1', 0, 0, 0, '@users', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(11, 'hash', 'Hash', 2, 19, 0, '', 0, 250, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(12, 'public', 'Is Public', 2, 2, 0, '0', 0, 0, 0, '', 0, '2017-03-07 04:21:30', '2017-03-07 04:21:30'),
(30, 'name', 'Nombre', 5, 16, 1, '', 1, 250, 1, '', 0, '2017-03-07 04:21:31', '2017-05-15 06:00:47'),
(31, 'display_name', 'Nombre a mostrar', 5, 19, 0, '', 0, 250, 1, '', 0, '2017-03-07 04:21:31', '2017-05-15 06:01:07'),
(32, 'description', 'Descripción', 5, 21, 0, '', 0, 1000, 0, '', 0, '2017-03-07 04:21:31', '2017-05-15 06:01:24'),
(33, 'parent', 'Rol padre', 5, 7, 0, '1', 0, 0, 0, '@roles', 0, '2017-03-07 04:21:31', '2017-05-15 06:01:42'),
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
(96, 'reserva_type', 'Tipo de Reservación', 16, 16, 0, 'App\\Models\\ReservasPractica', 0, 256, 1, '', 0, '2017-05-14 23:46:12', '2017-05-14 23:46:12'),
(56, 'nombre', 'Nombre', 11, 16, 1, '', 3, 256, 1, '', 0, '2017-03-07 09:31:16', '2017-04-22 06:44:25'),
(57, 'nombre', 'Nombre', 12, 16, 1, '', 3, 256, 1, '', 1, '2017-03-07 09:32:49', '2017-03-07 09:32:49'),
(58, 'objetivo', 'Objetivo', 12, 21, 0, '', 3, 256, 1, '', 2, '2017-03-07 09:33:23', '2017-03-08 22:47:51'),
(13, 'name', 'Name', 3, 16, 1, '', 1, 250, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
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
(88, 'solicitante_id', 'Solicitante', 16, 7, 0, '', 0, 256, 1, '@employees', 4, '2017-04-22 06:33:02', '2017-05-14 05:01:18'),
(90, 'gcalendar_event_id', 'ID Google Calendar', 16, 16, 1, '', 0, 256, 0, '', 6, '2017-04-22 13:04:04', '2017-04-22 13:04:04'),
(91, 'gcalendar_cal_id', 'ID Google Calendar', 11, 16, 1, '', 0, 256, 0, '', 0, '2017-04-25 00:36:16', '2017-04-25 00:36:16'),
(92, 'color_frente', 'Color de Frente', 11, 19, 0, '', 0, 7, 0, '', 0, '2017-05-01 07:45:15', '2017-05-01 07:45:55'),
(93, 'color_fondo', 'Color de Fondo', 11, 19, 0, '', 0, 7, 0, '', 0, '2017-05-01 07:45:33', '2017-05-01 07:46:08'),
(94, 'participantes', 'Núm. Participantes', 16, 13, 0, '10', 1, 11, 1, '', 5, '2017-05-01 08:16:28', '2017-05-01 08:23:10'),
(95, 'fecha_fin', 'Fecha de Fin', 16, 5, 0, '', 0, 0, 1, '', 3, '2017-04-22 06:32:27', '2017-04-22 06:32:27'),
(14, 'tags', 'Tags', 3, 20, 0, '[]', 0, 0, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(15, 'color', 'Color', 3, 19, 0, '', 0, 50, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(16, 'name', 'Nombre', 4, 16, 0, '', 5, 250, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:02:48'),
(17, 'designation', 'Puesto', 4, 19, 0, '', 0, 50, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:02:59'),
(18, 'gender', 'Género', 4, 18, 0, 'Masculino', 0, 0, 1, '["Masculino","Femenino"]', 0, '2017-05-14 07:31:32', '2017-05-14 07:03:32'),
(19, 'mobile', 'Teléfono móvil', 4, 14, 0, '', 10, 20, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:03:51'),
(20, 'mobile2', 'Móvil alternativo', 4, 14, 0, '', 10, 20, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:04:07'),
(21, 'email', 'Email', 4, 8, 1, '', 5, 250, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(22, 'dept', 'Departmento', 4, 7, 0, '0', 0, 0, 1, '@departments', 0, '2017-05-14 07:31:32', '2017-05-14 07:04:18'),
(23, 'city', 'Ciudad', 4, 19, 0, '', 0, 50, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:04:30'),
(24, 'address', 'Dirección', 4, 1, 0, '', 0, 1000, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:04:45'),
(25, 'about', 'Sobre el usuario', 4, 19, 0, '', 0, 256, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:05:07'),
(26, 'date_birth', 'Nacimiento', 4, 4, 0, '1990-01-01', 0, 0, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:11:48'),
(27, 'date_hire', 'Contratación', 4, 4, 0, 'date(\'Y-m-d\')', 0, 0, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:12:22'),
(28, 'date_left', 'Terminación', 4, 4, 0, '1990-01-01', 0, 0, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:14:00'),
(29, 'salary_cur', 'Salario Actual', 4, 6, 0, '0.0', 0, 2, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:14:30'),
(34, 'dept', 'Departmento', 5, 7, 0, '1', 0, 0, 0, '@departments', 0, '2017-05-14 07:31:32', '2017-05-15 06:01:56'),
(35, 'name', 'Name', 6, 16, 1, '', 5, 250, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(36, 'email', 'Email', 6, 8, 1, '', 0, 250, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(37, 'phone', 'Phone', 6, 14, 0, '', 0, 20, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(38, 'website', 'Website', 6, 23, 0, 'http://', 0, 250, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(39, 'assigned_to', 'Assigned to', 6, 7, 0, '0', 0, 0, 0, '@employees', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(40, 'connect_since', 'Connected Since', 6, 4, 0, 'date(\'Y-m-d\')', 0, 0, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(41, 'address', 'Address', 6, 1, 0, '', 0, 1000, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(42, 'city', 'City', 6, 19, 0, '', 0, 250, 1, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(43, 'description', 'Description', 6, 21, 0, '', 0, 1000, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(44, 'profile_image', 'Profile Image', 6, 12, 0, '', 0, 250, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(45, 'profile', 'Company Profile', 6, 9, 0, '', 0, 250, 0, '', 0, '2017-05-14 07:31:32', '2017-05-14 07:31:32'),
(97, 'reserva_type', 'Tipo de Reservación', 17, 16, 0, 'App\\Models\\ReservasLaboratorio', 0, 256, 1, '', 0, '2017-05-15 01:25:50', '2017-05-15 01:25:50'),
(98, 'practica_id', 'Práctica a realizar', 17, 18, 0, 'null', 0, 0, 0, '@practicas', 0, '2017-05-15 01:26:57', '2017-05-15 01:26:57'),
(99, 'laboratorio_id', 'Laboratorio', 17, 18, 0, '', 0, 0, 1, '@laboratorios', 0, '2017-05-15 01:27:43', '2017-05-15 01:27:43'),
(100, 'fecha_inicio', 'Fecha de Inicio', 17, 5, 0, '', 0, 0, 1, '', 0, '2017-05-15 01:28:12', '2017-05-15 01:28:12'),
(101, 'fecha_fin', 'Fecha de Fin', 17, 5, 0, '', 0, 0, 1, '', 0, '2017-05-15 01:28:38', '2017-05-15 01:28:38'),
(102, 'solicitante_id', 'Solicitante', 17, 7, 0, '', 0, 0, 1, '@employees', 0, '2017-05-15 01:29:22', '2017-05-15 01:29:22'),
(103, 'participantes', 'Núm. Participantes', 17, 13, 0, '1', 1, 10, 1, '', 0, '2017-05-15 01:31:17', '2017-05-15 01:31:17'),
(104, 'material_id', 'Material', 18, 18, 0, '', 0, 0, 1, '@materiales', 0, '2017-05-15 05:01:27', '2017-05-15 05:01:27'),
(105, 'cantidad', 'Cantidad', 18, 13, 0, '1', 1, 11, 1, '', 0, '2017-05-15 05:02:00', '2017-05-15 05:02:00'),
(106, 'fecha_inicio', 'Fecha de Inicio', 18, 5, 0, '', 0, 0, 1, '', 0, '2017-05-15 05:02:39', '2017-05-15 05:02:39'),
(107, 'fecha_fin', 'Fecha de Fin', 18, 5, 0, '', 0, 0, 1, '', 0, '2017-05-15 05:02:57', '2017-05-15 05:04:05'),
(108, 'dias_max_laboratorio', 'Máx. días Lab.', 5, 13, 0, '1', 0, 31, 1, '', 0, '2017-05-15 06:06:29', '2017-05-15 07:02:57'),
(110, 'dias_max_material', 'Máx. días Mat.', 5, 13, 0, '1', 0, 31, 1, '', 0, '2017-05-15 07:32:45', '2017-05-15 07:33:01');

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
-- Estructura de tabla para la tabla `movimientosmateriales`
--

DROP TABLE IF EXISTS `movimientosmateriales`;
CREATE TABLE IF NOT EXISTS `movimientosmateriales` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `material_id` int(10) UNSIGNED NOT NULL,
  `cantidad` decimal(10,2) NOT NULL DEFAULT '1.00',
  `asignable_id` int(10) UNSIGNED NOT NULL,
  `asignable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `movimientosmateriales`
--

INSERT INTO `movimientosmateriales` (`id`, `material_id`, `cantidad`, `asignable_id`, `asignable_type`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, '-10.00', 1, 'App\\Models\\ReservasPractica', '2017-05-14 10:20:56', '2017-05-14 09:31:52', '2017-05-14 10:20:56'),
(2, 2, '-10.00', 1, 'App\\Models\\ReservasPractica', '2017-05-14 10:20:56', '2017-05-14 09:31:52', '2017-05-14 10:20:56'),
(3, 1, '1.00', 1, 'App\\Models\\ReservasPractica', '2017-05-14 10:20:56', '2017-05-14 10:20:02', '2017-05-14 10:20:56'),
(4, 2, '1.00', 1, 'App\\Models\\ReservasPractica', '2017-05-14 10:20:56', '2017-05-14 10:20:02', '2017-05-14 10:20:56'),
(5, 1, '8.00', 1, 'App\\Models\\ReservasPractica', '2017-05-14 10:20:56', '2017-05-14 10:20:30', '2017-05-14 10:20:56'),
(6, 2, '8.00', 1, 'App\\Models\\ReservasPractica', '2017-05-14 10:20:56', '2017-05-14 10:20:30', '2017-05-14 10:20:56'),
(7, 1, '-10.00', 2, 'App\\Models\\ReservasPractica', '2017-05-15 08:28:44', '2017-05-14 10:48:55', '2017-05-15 08:28:44'),
(8, 2, '-10.00', 2, 'App\\Models\\ReservasPractica', '2017-05-15 08:28:44', '2017-05-14 10:48:55', '2017-05-15 08:28:44'),
(9, 1, '-2.00', 2, 'App\\Models\\ReservasPractica', '2017-05-15 08:28:44', '2017-05-14 10:54:54', '2017-05-15 08:28:44'),
(10, 2, '-2.00', 2, 'App\\Models\\ReservasPractica', '2017-05-15 08:28:44', '2017-05-14 10:54:54', '2017-05-15 08:28:44'),
(11, 1, '9.00', 2, 'App\\Models\\ReservasPractica', '2017-05-15 08:28:44', '2017-05-14 10:56:23', '2017-05-15 08:28:44'),
(12, 2, '9.00', 2, 'App\\Models\\ReservasPractica', '2017-05-15 08:28:44', '2017-05-14 10:56:23', '2017-05-15 08:28:44'),
(13, 1, '-10.00', 3, 'App\\Models\\ReservasPractica', '2017-05-15 08:28:49', '2017-05-14 22:39:48', '2017-05-15 08:28:49'),
(14, 2, '-10.00', 3, 'App\\Models\\ReservasPractica', '2017-05-15 08:28:49', '2017-05-14 22:39:48', '2017-05-15 08:28:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientosreactivos`
--

DROP TABLE IF EXISTS `movimientosreactivos`;
CREATE TABLE IF NOT EXISTS `movimientosreactivos` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reactivo_id` int(10) UNSIGNED NOT NULL,
  `cantidad` decimal(10,2) NOT NULL DEFAULT '1.00',
  `asignable_id` int(10) UNSIGNED NOT NULL,
  `asignable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5);

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
(2, 3, 1, 1, 0, NULL, '2017-05-04 20:46:00', '2017-05-12 09:23:22');

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
(2, 3, 1, '1.00', 1, '2017-05-12 09:23:22', '2017-05-06 00:02:29', '2017-05-12 09:23:22');

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
(1, NULL, '2017-04-05 05:28:08', '2017-05-12 21:43:21', 'test', 20, 'kg'),
(2, NULL, '2017-05-05 09:35:43', '2017-05-05 09:35:43', 'Ácido Sulfúrico', 20, 'l');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

DROP TABLE IF EXISTS `reservas`;
CREATE TABLE IF NOT EXISTS `reservas` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `practica_id` int(10) UNSIGNED DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `fecha_fin` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `solicitante_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `laboratorio_id` int(10) UNSIGNED NOT NULL,
  `gcalendar_event_id` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `participantes` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `reserva_type` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT 'App\\Models\\ReservasPractica',
  PRIMARY KEY (`id`),
  KEY `reservaspracticas_solicitante_id_foreign` (`solicitante_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `deleted_at`, `created_at`, `updated_at`, `practica_id`, `fecha_inicio`, `fecha_fin`, `solicitante_id`, `laboratorio_id`, `gcalendar_event_id`, `participantes`, `reserva_type`) VALUES
(1, '2017-05-14 10:20:56', '2017-05-14 09:31:52', '2017-05-14 10:20:56', 3, '2017-05-31 05:00:00', '2017-05-31 06:00:00', 1, 1, '', 1, 'App\\Models\\ReservasPractica'),
(2, '2017-05-15 08:28:44', '2017-05-14 10:48:55', '2017-05-15 08:28:44', 3, '2017-05-26 17:00:00', '2017-05-26 18:00:00', 1, 1, '', 3, 'App\\Models\\ReservasPractica'),
(3, '2017-05-15 08:28:49', '2017-05-14 22:39:48', '2017-05-15 08:28:49', 3, '2017-05-18 05:00:00', '2017-05-18 06:00:00', 4, 1, '', 10, 'App\\Models\\ReservasPractica'),
(4, '2017-05-15 02:10:23', '2017-05-15 02:06:02', '2017-05-15 02:10:23', NULL, '2017-05-14 05:00:00', '2017-05-13 05:00:00', 1, 1, '', 1, 'App\\Models\\ReservasLaboratorio'),
(5, '2017-05-15 03:41:29', '2017-05-15 03:32:33', '2017-05-15 03:41:29', NULL, '2017-05-27 05:00:00', '2017-05-27 12:00:00', 1, 1, '', 1, 'App\\Models\\ReservasLaboratorio'),
(6, '2017-05-15 05:57:23', '2017-05-15 04:17:54', '2017-05-15 05:57:23', NULL, '2017-05-28 05:00:00', '2017-05-29 05:00:00', 1, 1, '', 1, 'App\\Models\\ReservasLaboratorio'),
(7, '2017-05-15 08:28:24', '2017-05-15 08:03:57', '2017-05-15 08:28:24', NULL, '2017-05-14 05:00:00', '2017-05-16 04:00:00', 1, 1, '', 10, 'App\\Models\\ReservasLaboratorio'),
(8, '2017-05-15 08:28:30', '2017-05-15 08:09:45', '2017-05-15 08:28:30', NULL, '2017-06-01 05:00:00', '2017-06-02 05:00:00', 4, 1, '', 10, 'App\\Models\\ReservasLaboratorio'),
(9, '2017-05-15 08:28:35', '2017-05-15 08:26:52', '2017-05-15 08:28:35', NULL, '2017-06-21 05:00:00', '2017-06-21 08:00:00', 4, 1, '', 10, 'App\\Models\\ReservasLaboratorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservasmateriales`
--

DROP TABLE IF EXISTS `reservasmateriales`;
CREATE TABLE IF NOT EXISTS `reservasmateriales` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `material_id` int(10) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `fecha_inicio` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `fecha_fin` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `dept` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `dias_max_laboratorio` int(10) NOT NULL DEFAULT '1',
  `dias_max_material` int(10) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`),
  KEY `roles_parent_foreign` (`parent`),
  KEY `roles_dept_foreign` (`dept`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `parent`, `dept`, `deleted_at`, `created_at`, `updated_at`, `dias_max_laboratorio`, `dias_max_material`) VALUES
(1, 'SUPER_ADMIN', 'Administrador Raíz', 'Administrador de sistema', 1, 1, NULL, '2017-03-07 04:21:33', '2017-05-15 06:07:19', -1, -1),
(2, 'LabAdmin', 'Lab Admin', 'Administrador de Laboratorios', 1, 1, NULL, '2017-04-05 08:28:07', '2017-05-15 06:07:33', -1, -1),
(3, 'Asignatura', 'Asignatura', 'Profesor de Asignatura', 1, 1, NULL, '2017-04-05 08:46:07', '2017-05-14 04:01:24', 1, 1),
(4, 'Tiempo completo', 'Tiempo completo', 'Profesor de Tiempo Completo', 1, 1, NULL, '2017-04-05 08:47:33', '2017-05-14 04:01:36', 1, 1),
(5, 'Investigador', 'investigador', 'Investigador de CUValles', 1, 1, NULL, '2017-04-05 08:48:31', '2017-05-14 04:01:47', 1, 1);

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
) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(17, 2, 13, 1, 1, 1, 1, '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(18, 2, 1, 1, 1, 1, 1, '2017-05-14 00:21:45', '2017-05-14 00:21:45'),
(19, 3, 1, 0, 0, 0, 0, '2017-05-14 00:21:45', '2017-05-14 00:21:45'),
(20, 4, 1, 0, 0, 0, 0, '2017-05-14 00:21:45', '2017-05-14 00:21:45'),
(21, 5, 1, 0, 0, 0, 0, '2017-05-14 00:21:45', '2017-05-14 00:21:45'),
(22, 2, 2, 0, 0, 0, 0, '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(23, 3, 2, 0, 0, 0, 0, '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(24, 4, 2, 0, 0, 0, 0, '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(25, 5, 2, 0, 0, 0, 0, '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(26, 2, 5, 0, 0, 0, 0, '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(27, 3, 5, 0, 0, 0, 0, '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(28, 4, 5, 0, 0, 0, 0, '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(29, 5, 5, 0, 0, 0, 0, '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(30, 2, 7, 0, 0, 0, 0, '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(31, 3, 7, 0, 0, 0, 0, '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(32, 4, 7, 0, 0, 0, 0, '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(33, 5, 7, 0, 0, 0, 0, '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(34, 2, 8, 0, 0, 0, 0, '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(35, 3, 8, 0, 0, 0, 0, '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(36, 4, 8, 0, 0, 0, 0, '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(37, 5, 8, 0, 0, 0, 0, '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(38, 2, 9, 1, 1, 1, 1, '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(39, 3, 9, 1, 1, 1, 0, '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(40, 4, 9, 1, 1, 1, 0, '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(41, 5, 9, 1, 1, 1, 0, '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(42, 2, 10, 1, 1, 1, 1, '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(43, 3, 10, 1, 1, 1, 0, '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(44, 4, 10, 1, 1, 1, 0, '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(45, 5, 10, 1, 1, 1, 0, '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(46, 2, 11, 1, 1, 1, 1, '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(47, 3, 11, 0, 0, 0, 0, '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(48, 4, 11, 0, 0, 0, 0, '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(49, 5, 11, 0, 0, 0, 0, '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(50, 2, 12, 1, 1, 1, 1, '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(51, 3, 12, 0, 0, 0, 0, '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(52, 4, 12, 0, 0, 0, 0, '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(53, 5, 12, 0, 0, 0, 0, '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(54, 3, 13, 0, 0, 0, 0, '2017-05-14 00:29:49', '2017-05-14 00:29:49'),
(55, 4, 13, 0, 0, 0, 0, '2017-05-14 00:29:49', '2017-05-14 00:29:49'),
(56, 5, 13, 0, 0, 0, 0, '2017-05-14 00:29:49', '2017-05-14 00:29:49'),
(57, 2, 15, 1, 1, 1, 1, '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(58, 3, 15, 0, 0, 0, 0, '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(59, 4, 15, 0, 0, 0, 0, '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(60, 5, 15, 0, 0, 0, 0, '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(61, 2, 16, 1, 1, 1, 1, '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(62, 3, 16, 1, 1, 1, 0, '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(63, 4, 16, 1, 1, 1, 0, '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(64, 5, 16, 1, 1, 1, 0, '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(65, 2, 3, 1, 1, 1, 1, '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(66, 3, 3, 0, 0, 0, 0, '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(67, 4, 3, 0, 0, 0, 0, '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(68, 5, 3, 0, 0, 0, 0, '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(69, 2, 4, 1, 1, 1, 1, '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(70, 3, 4, 0, 0, 0, 0, '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(71, 4, 4, 0, 0, 0, 0, '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(72, 5, 4, 0, 0, 0, 0, '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(73, 2, 6, 0, 0, 0, 0, '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(74, 3, 6, 0, 0, 0, 0, '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(75, 4, 6, 0, 0, 0, 0, '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(76, 5, 6, 0, 0, 0, 0, '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(77, 1, 17, 1, 1, 1, 1, '2017-05-15 01:32:33', '2017-05-15 01:32:33'),
(78, 2, 17, 1, 1, 1, 1, '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(79, 3, 17, 1, 1, 1, 0, '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(80, 4, 17, 1, 1, 1, 0, '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(81, 5, 17, 1, 1, 1, 0, '2017-05-15 08:07:36', '2017-05-15 08:07:36');

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
) ENGINE=MyISAM AUTO_INCREMENT=454 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(89, 2, 1, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(90, 2, 2, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(91, 2, 3, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(92, 2, 4, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(93, 2, 5, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(94, 3, 1, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(95, 3, 2, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(96, 3, 3, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(97, 3, 4, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(98, 3, 5, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(99, 4, 1, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(100, 4, 2, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(101, 4, 3, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(102, 4, 4, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(103, 4, 5, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(104, 5, 1, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(105, 5, 2, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(106, 5, 3, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(107, 5, 4, 'write', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(108, 5, 5, 'invisible', '2017-04-22 06:45:03', '2017-04-22 06:45:03'),
(109, 2, 56, 'write', '2017-04-22 06:45:35', '2017-04-22 06:45:35'),
(110, 3, 56, 'invisible', '2017-04-22 06:45:35', '2017-04-22 06:45:35'),
(111, 4, 56, 'invisible', '2017-04-22 06:45:35', '2017-04-22 06:45:35'),
(112, 5, 56, 'invisible', '2017-04-22 06:45:35', '2017-04-22 06:45:35'),
(113, 2, 63, 'write', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(114, 2, 73, 'write', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(115, 2, 74, 'write', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(116, 2, 71, 'write', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(117, 2, 72, 'write', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
(118, 2, 70, 'write', '2017-04-22 06:46:18', '2017-04-22 06:46:18'),
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
(138, 1, 90, 'invisible', '2017-04-22 13:04:04', '2017-04-22 13:04:04'),
(139, 1, 91, 'write', '2017-04-25 00:36:18', '2017-04-25 00:36:18'),
(140, 1, 92, 'write', '2017-05-01 07:45:15', '2017-05-01 07:45:15'),
(141, 1, 93, 'write', '2017-05-01 07:45:34', '2017-05-01 07:45:34'),
(142, 1, 94, 'write', '2017-05-01 08:16:28', '2017-05-01 08:16:28'),
(143, 2, 6, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(144, 2, 7, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(145, 2, 8, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(146, 2, 9, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(147, 2, 10, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(148, 2, 11, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(149, 2, 12, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(150, 3, 6, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(151, 3, 7, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(152, 3, 8, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(153, 3, 9, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(154, 3, 10, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(155, 3, 11, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(156, 3, 12, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(157, 4, 6, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(158, 4, 7, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(159, 4, 8, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(160, 4, 9, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(161, 4, 10, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(162, 4, 11, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(163, 4, 12, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(164, 5, 6, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(165, 5, 7, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(166, 5, 8, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(167, 5, 9, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(168, 5, 10, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(169, 5, 11, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(170, 5, 12, 'invisible', '2017-05-14 00:22:32', '2017-05-14 00:22:32'),
(171, 2, 30, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(172, 2, 31, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(173, 2, 32, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(174, 2, 33, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(175, 3, 30, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(176, 3, 31, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(177, 3, 32, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(178, 3, 33, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(179, 4, 30, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(180, 4, 31, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(181, 4, 32, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(182, 4, 33, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(183, 5, 30, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(184, 5, 31, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(185, 5, 32, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(186, 5, 33, 'invisible', '2017-05-14 00:22:58', '2017-05-14 00:22:58'),
(187, 2, 46, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(188, 2, 47, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(189, 2, 48, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(190, 3, 46, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(191, 3, 47, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(192, 3, 48, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(193, 4, 46, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(194, 4, 47, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(195, 4, 48, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(196, 5, 46, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(197, 5, 47, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(198, 5, 48, 'invisible', '2017-05-14 00:23:17', '2017-05-14 00:23:17'),
(199, 2, 49, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(200, 2, 50, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(201, 2, 51, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(202, 3, 49, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(203, 3, 50, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(204, 3, 51, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(205, 4, 49, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(206, 4, 50, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(207, 4, 51, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(208, 5, 49, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(209, 5, 50, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(210, 5, 51, 'invisible', '2017-05-14 00:23:33', '2017-05-14 00:23:33'),
(211, 2, 52, 'invisible', '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(212, 2, 53, 'invisible', '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(213, 3, 52, 'invisible', '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(214, 3, 53, 'invisible', '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(215, 4, 52, 'invisible', '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(216, 4, 53, 'invisible', '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(217, 5, 52, 'invisible', '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(218, 5, 53, 'invisible', '2017-05-14 00:26:15', '2017-05-14 00:26:15'),
(219, 2, 54, 'invisible', '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(220, 2, 55, 'invisible', '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(221, 3, 54, 'invisible', '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(222, 3, 55, 'invisible', '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(223, 4, 54, 'invisible', '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(224, 4, 55, 'invisible', '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(225, 5, 54, 'invisible', '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(226, 5, 55, 'invisible', '2017-05-14 00:27:11', '2017-05-14 00:27:11'),
(227, 2, 91, 'write', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(228, 2, 92, 'write', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(229, 2, 93, 'write', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(230, 3, 91, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(231, 3, 92, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(232, 3, 93, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(233, 4, 91, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(234, 4, 92, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(235, 4, 93, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(236, 5, 91, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(237, 5, 92, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(238, 5, 93, 'invisible', '2017-05-14 00:28:55', '2017-05-14 00:28:55'),
(239, 2, 57, 'write', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(240, 2, 58, 'write', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(241, 2, 80, 'write', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(242, 2, 79, 'write', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(243, 3, 57, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(244, 3, 58, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(245, 3, 80, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(246, 3, 79, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(247, 4, 57, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(248, 4, 58, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(249, 4, 80, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(250, 4, 79, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(251, 5, 57, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(252, 5, 58, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(253, 5, 80, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(254, 5, 79, 'invisible', '2017-05-14 00:29:24', '2017-05-14 00:29:24'),
(255, 2, 75, 'write', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(256, 2, 76, 'write', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(257, 2, 77, 'write', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(258, 3, 75, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(259, 3, 76, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(260, 3, 77, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(261, 4, 75, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(262, 4, 76, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(263, 4, 77, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(264, 5, 75, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(265, 5, 76, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(266, 5, 77, 'invisible', '2017-05-14 00:30:39', '2017-05-14 00:30:39'),
(267, 1, 95, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(268, 2, 85, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(269, 2, 89, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(270, 2, 87, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(271, 2, 95, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(272, 2, 88, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(273, 2, 94, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(274, 2, 90, 'invisible', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(275, 3, 85, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(276, 3, 89, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(277, 3, 87, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(278, 3, 95, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(279, 3, 88, 'readonly', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(280, 3, 94, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(281, 3, 90, 'invisible', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(282, 4, 85, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(283, 4, 89, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(284, 4, 87, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(285, 4, 95, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(286, 4, 88, 'readonly', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(287, 4, 94, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(288, 4, 90, 'invisible', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(289, 5, 85, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(290, 5, 89, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(291, 5, 87, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(292, 5, 95, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(293, 5, 88, 'readonly', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(294, 5, 94, 'write', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(295, 5, 90, 'invisible', '2017-05-14 00:33:55', '2017-05-14 00:33:55'),
(296, 2, 13, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(297, 2, 14, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(298, 2, 15, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(299, 3, 13, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(300, 3, 14, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(301, 3, 15, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(302, 4, 13, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(303, 4, 14, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(304, 4, 15, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(305, 5, 13, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(306, 5, 14, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(307, 5, 15, 'invisible', '2017-05-14 03:11:54', '2017-05-14 03:11:54'),
(308, 2, 16, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(309, 2, 17, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(310, 2, 18, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(311, 2, 19, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(312, 2, 20, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(313, 2, 21, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(314, 2, 22, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(315, 2, 23, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(316, 2, 24, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(317, 2, 25, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(318, 2, 26, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(319, 2, 27, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(320, 2, 28, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(321, 2, 29, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(322, 3, 16, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(323, 3, 17, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(324, 3, 18, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(325, 3, 19, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(326, 3, 20, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(327, 3, 21, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(328, 3, 22, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(329, 3, 23, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(330, 3, 24, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(331, 3, 25, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(332, 3, 26, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(333, 3, 27, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(334, 3, 28, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(335, 3, 29, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(336, 4, 16, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(337, 4, 17, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(338, 4, 18, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(339, 4, 19, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(340, 4, 20, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(341, 4, 21, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(342, 4, 22, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(343, 4, 23, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(344, 4, 24, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(345, 4, 25, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(346, 4, 26, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(347, 4, 27, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(348, 4, 28, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(349, 4, 29, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(350, 5, 16, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(351, 5, 17, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(352, 5, 18, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(353, 5, 19, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(354, 5, 20, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(355, 5, 21, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(356, 5, 22, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(357, 5, 23, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(358, 5, 24, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(359, 5, 25, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(360, 5, 26, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(361, 5, 27, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(362, 5, 28, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(363, 5, 29, 'invisible', '2017-05-14 03:12:19', '2017-05-14 03:12:19'),
(364, 2, 35, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(365, 2, 36, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(366, 2, 37, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(367, 2, 38, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(368, 2, 39, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(369, 2, 40, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(370, 2, 41, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(371, 2, 42, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(372, 3, 35, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(373, 3, 36, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(374, 3, 37, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(375, 3, 38, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(376, 3, 39, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(377, 3, 40, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(378, 3, 41, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(379, 3, 42, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(380, 4, 35, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(381, 4, 36, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(382, 4, 37, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(383, 4, 38, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(384, 4, 39, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(385, 4, 40, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(386, 4, 41, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(387, 4, 42, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(388, 5, 35, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(389, 5, 36, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(390, 5, 37, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(391, 5, 38, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(392, 5, 39, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(393, 5, 40, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(394, 5, 41, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(395, 5, 42, 'invisible', '2017-05-14 03:12:58', '2017-05-14 03:12:58'),
(396, 2, 34, 'invisible', '2017-05-14 04:30:34', '2017-05-14 04:30:34'),
(397, 3, 34, 'invisible', '2017-05-14 04:30:34', '2017-05-14 04:30:34'),
(398, 4, 34, 'invisible', '2017-05-14 04:30:34', '2017-05-14 04:30:34'),
(399, 5, 34, 'invisible', '2017-05-14 04:30:34', '2017-05-14 04:30:34'),
(400, 2, 43, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(401, 2, 44, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(402, 2, 45, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(403, 3, 43, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(404, 3, 44, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(405, 3, 45, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(406, 4, 43, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(407, 4, 44, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(408, 4, 45, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(409, 5, 43, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(410, 5, 44, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(411, 5, 45, 'invisible', '2017-05-14 04:30:50', '2017-05-14 04:30:50'),
(412, 1, 96, 'write', '2017-05-14 23:47:22', '2017-05-14 23:47:22'),
(413, 1, 97, 'write', '2017-05-15 01:25:51', '2017-05-15 01:25:51'),
(414, 1, 98, 'write', '2017-05-15 01:26:57', '2017-05-15 01:26:57'),
(415, 1, 99, 'write', '2017-05-15 01:27:43', '2017-05-15 01:27:43'),
(416, 1, 100, 'write', '2017-05-15 01:28:12', '2017-05-15 01:28:12'),
(417, 1, 101, 'write', '2017-05-15 01:28:38', '2017-05-15 01:28:38'),
(418, 1, 102, 'write', '2017-05-15 01:29:22', '2017-05-15 01:29:22'),
(419, 1, 103, 'write', '2017-05-15 01:31:18', '2017-05-15 01:31:18'),
(420, 1, 104, 'write', '2017-05-15 05:01:27', '2017-05-15 05:01:27'),
(421, 1, 105, 'write', '2017-05-15 05:02:00', '2017-05-15 05:02:00'),
(422, 1, 106, 'write', '2017-05-15 05:02:39', '2017-05-15 05:02:39'),
(423, 1, 107, 'write', '2017-05-15 05:02:57', '2017-05-15 05:02:57'),
(424, 1, 108, 'write', '2017-05-15 06:06:30', '2017-05-15 06:06:30'),
(425, 1, 110, 'write', '2017-05-15 07:32:46', '2017-05-15 07:32:46'),
(426, 2, 97, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(427, 2, 98, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(428, 2, 99, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(429, 2, 100, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(430, 2, 101, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(431, 2, 102, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(432, 2, 103, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(433, 3, 97, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(434, 3, 98, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(435, 3, 99, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(436, 3, 100, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(437, 3, 101, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(438, 3, 102, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(439, 3, 103, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(440, 4, 97, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(441, 4, 98, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(442, 4, 99, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(443, 4, 100, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(444, 4, 101, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(445, 4, 102, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(446, 4, 103, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(447, 5, 97, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(448, 5, 98, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(449, 5, 99, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(450, 5, 100, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(451, 5, 101, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(452, 5, 102, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36'),
(453, 5, 103, 'write', '2017-05-15 08:07:36', '2017-05-15 08:07:36');

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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `role_user`
--

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(10, 1, 1, NULL, NULL),
(8, 1, 2, NULL, NULL),
(12, 2, 3, NULL, NULL),
(13, 3, 4, NULL, NULL),
(14, 4, 5, NULL, NULL),
(15, 5, 6, NULL, NULL);

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
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `context_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `context_id`, `email`, `password`, `type`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Carlos González', 1, 'administrador@adminlab.com', '$2y$10$.EpR/BnPbdzHLIE8Bb1ok.GSvCVr4N/9R8lzQFSYjknlZJ4CFUgOq', 'Administrador Raíz', 'uDEwPz8SByjpOKeXx4XFSJqg29TB6aGePLnnhLeus8zotVNPqlB4kiFjnli0', NULL, '2017-03-07 04:23:44', '2017-05-15 08:07:45'),
(2, 'Rogelio Jiménez Meza', 2, 'rjmultimedia@gmail.com', '$2y$10$xx.ZlqZt21OjLrtBmPQlZOOony131OORDkCNR7.lu9sCTa7JWTfD6', 'Employee', 'QYm8i8vpsuQiYzbFEqJdLVEajLIUIGqwDaVlc1f12hYxRO047TkgGqW88hUx', NULL, '2017-05-14 03:18:16', '2017-05-14 04:16:18'),
(3, 'Administrador de laboratorio', 3, 'labadmin@adminlab.com', '$2y$10$OKPm.KwtHXGaTkiqv0xRv.T8/yZYsh/TDTcUMKa5DzD6rkPOpNaSy', 'Employee', 'XXIrWWzjuRbihbtJisMC31aChTKG5RJrH589x95rRsQ8WxULDdv8xa6BegEy', NULL, '2017-05-14 04:20:01', '2017-05-14 22:34:14'),
(4, 'Profesor de Asignatura', 4, 'asignatura@adminlab.com', '$2y$10$jYkMl/X7XhE.dVoSjPxvu.US6OxkrkQ3/AjNyPFICP.tk88WNvQdK', 'Employee', '12KmQjDihlU9tRnx0Yhy061L6082zqzGT70oXXaJXtSpSWjbR5Plh3r1Ve1M', NULL, '2017-05-14 04:21:18', '2017-05-15 08:27:55'),
(5, 'Profesor de Tiempo Completo', 5, 'tiempocompleto@adminlab.com', '$2y$10$9osXh3F87nGUbDiE6qvRzOw055BgQHkgZB2OFsob.CZVYKJNmtQpm', 'Employee', NULL, NULL, '2017-05-14 04:22:02', '2017-05-14 04:23:39'),
(6, 'Profesor Investigador', 6, 'investigador@adminlab.com', '$2y$10$YhVTHIYnP/.kG1/zpt0C2.o3h.cLVQRKoMnpyEwbUZdx31MTPBR82', 'Employee', 'Bfiu5twiJB85yFTutav0l3iuSF1FZlD70XjZ7ET1AqcInWUR8aILZS1iKVvk', NULL, '2017-05-14 04:22:34', '2017-05-14 06:31:34');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
