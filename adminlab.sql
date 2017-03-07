-- Adminer 4.2.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `adminlab`;
CREATE DATABASE `adminlab` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `adminlab`;

DROP TABLE IF EXISTS `backups`;
CREATE TABLE `backups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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


DROP TABLE IF EXISTS `laboratorios`;
CREATE TABLE `laboratorios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nombre` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `la_configs`;
CREATE TABLE `la_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `section` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `la_configs` (`id`, `key`, `section`, `value`, `created_at`, `updated_at`) VALUES
(1,	'sitename',	'',	'AdminLab',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(2,	'sitename_part1',	'',	'Admin',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(3,	'sitename_part2',	'',	'Lab',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(4,	'sitename_short',	'',	'AL',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(5,	'site_description',	'',	'Administración de Laboratorios y Suministros',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(6,	'sidebar_search',	'',	'0',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(7,	'show_messages',	'',	'0',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(8,	'show_notifications',	'',	'0',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(9,	'show_tasks',	'',	'0',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(10,	'show_rightsidebar',	'',	'0',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(11,	'skin',	'',	'skin-blue',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(12,	'layout',	'',	'layout-boxed',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17'),
(13,	'default_email',	'',	'administrador@laraadmin.com',	'2017-03-07 04:21:33',	'2017-03-07 08:39:17');

DROP TABLE IF EXISTS `la_menus`;
CREATE TABLE `la_menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'fa-cube',
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'module',
  `parent` int(10) unsigned NOT NULL DEFAULT '0',
  `hierarchy` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `la_menus` (`id`, `name`, `url`, `icon`, `type`, `parent`, `hierarchy`, `created_at`, `updated_at`) VALUES
(1,	'Team',	'#',	'fa-group',	'custom',	0,	4,	'2017-03-07 04:21:33',	'2017-03-07 11:37:06'),
(2,	'Users',	'users',	'fa-group',	'module',	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 11:15:08'),
(6,	'Roles',	'roles',	'fa-user-plus',	'module',	1,	2,	'2017-03-07 04:21:33',	'2017-03-07 11:15:08'),
(8,	'Permissions',	'permissions',	'fa-magic',	'module',	1,	3,	'2017-03-07 04:21:33',	'2017-03-07 11:15:08'),
(9,	'Prestamos',	'prestamos',	'fa fa-cube',	'module',	0,	3,	'2017-03-07 08:50:08',	'2017-03-07 11:37:06'),
(10,	'Reservaciones',	'reservaciones',	'fa fa-cube',	'module',	0,	2,	'2017-03-07 09:09:21',	'2017-03-07 11:37:06'),
(11,	'Laboratorios',	'laboratorios',	'fa fa-cube',	'module',	10,	2,	'2017-03-07 09:31:27',	'2017-03-07 11:37:24'),
(12,	'Practicas',	'practicas',	'fa fa-cube',	'module',	10,	1,	'2017-03-07 09:41:34',	'2017-03-07 11:37:20'),
(13,	'Materiales',	'materiales',	'fa fa-cube',	'module',	10,	3,	'2017-03-07 10:08:11',	'2017-03-07 11:37:27'),
(16,	'Reactivos',	'reactivos',	'fa fa-cube',	'module',	10,	4,	'2017-03-07 11:36:24',	'2017-03-07 11:37:34'),
(15,	'Uploads',	'uploads',	'fa-files-o',	'module',	0,	1,	'2017-03-07 11:15:26',	'2017-03-07 11:16:10');

DROP TABLE IF EXISTS `materiales`;
CREATE TABLE `materiales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `descripcion` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cantidad` int(10) unsigned NOT NULL DEFAULT '0',
  `marca` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `codigo` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `anaquel` int(10) unsigned NOT NULL DEFAULT '0',
  `estante` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_05_26_050000_create_modules_table',	1),
('2014_05_26_055000_create_module_field_types_table',	1),
('2014_05_26_060000_create_module_fields_table',	1),
('2014_10_12_000000_create_users_table',	1),
('2014_10_12_100000_create_password_resets_table',	1),
('2014_12_01_000000_create_uploads_table',	1),
('2016_05_26_064006_create_departments_table',	1),
('2016_05_26_064007_create_employees_table',	1),
('2016_05_26_064446_create_roles_table',	1),
('2016_07_05_115343_create_role_user_table',	1),
('2016_07_06_140637_create_organizations_table',	1),
('2016_07_07_134058_create_backups_table',	1),
('2016_07_07_134058_create_menus_table',	1),
('2016_09_10_163337_create_permissions_table',	1),
('2016_09_10_163520_create_permission_role_table',	1),
('2016_09_22_105958_role_module_fields_table',	1),
('2016_09_22_110008_role_module_table',	1),
('2016_10_06_115413_create_la_configs_table',	1),
('2017_03_07_024902_create_reservaciones_table',	2);

DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `modules` (`id`, `name`, `label`, `name_db`, `view_col`, `model`, `controller`, `fa_icon`, `is_gen`, `created_at`, `updated_at`) VALUES
(1,	'Users',	'Users',	'users',	'nombre',	'User',	'UsersController',	'fa-group',	1,	'2017-03-07 04:21:30',	'2017-03-07 10:52:25'),
(2,	'Uploads',	'Uploads',	'uploads',	'name',	'Upload',	'UploadsController',	'fa-files-o',	1,	'2017-03-07 04:21:30',	'2017-03-07 04:21:33'),
(5,	'Roles',	'Roles',	'roles',	'name',	'Role',	'RolesController',	'fa-user-plus',	1,	'2017-03-07 04:21:31',	'2017-03-07 04:21:33'),
(7,	'Backups',	'Backups',	'backups',	'name',	'Backup',	'BackupsController',	'fa-hdd-o',	1,	'2017-03-07 04:21:31',	'2017-03-07 04:21:33'),
(8,	'Permissions',	'Permissions',	'permissions',	'name',	'Permission',	'PermissionsController',	'fa-magic',	1,	'2017-03-07 04:21:32',	'2017-03-07 04:21:33'),
(9,	'Prestamos',	'Prestamos',	'prestamos',	'fecha_inicio',	'Prestamo',	'PrestamosController',	'fa-cube',	1,	'2017-03-07 08:42:35',	'2017-03-07 08:50:18'),
(10,	'Reservaciones',	'Reservaciones',	'reservaciones',	'fecha_inicio',	'Reservacione',	'ReservacionesController',	'fa-cube',	1,	'2017-03-07 09:04:24',	'2017-03-07 09:09:21'),
(11,	'Laboratorios',	'Laboratorios',	'laboratorios',	'nombre',	'Laboratorio',	'LaboratoriosController',	'fa-cube',	1,	'2017-03-07 09:30:31',	'2017-03-07 09:31:27'),
(12,	'Practicas',	'Practicas',	'practicas',	'nombre',	'Practica',	'PracticasController',	'fa-cube',	1,	'2017-03-07 09:32:28',	'2017-03-07 09:41:34'),
(13,	'Materiales',	'Materiales',	'materiales',	'nombre',	'Materiale',	'MaterialesController',	'fa-cube',	1,	'2017-03-07 09:48:17',	'2017-03-07 10:08:11'),
(15,	'Reactivos',	'Reactivos',	'reactivos',	'nombre',	'Reactivo',	'ReactivosController',	'fa-cube',	1,	'2017-03-07 11:29:31',	'2017-03-07 11:36:24');

DROP TABLE IF EXISTS `module_fields`;
CREATE TABLE `module_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `colname` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `module` int(10) unsigned NOT NULL,
  `field_type` int(10) unsigned NOT NULL,
  `unique` tinyint(1) NOT NULL DEFAULT '0',
  `defaultvalue` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `minlength` int(10) unsigned NOT NULL DEFAULT '0',
  `maxlength` int(10) unsigned NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `popup_vals` text COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_fields_module_foreign` (`module`),
  KEY `module_fields_field_type_foreign` (`field_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `module_fields` (`id`, `colname`, `label`, `module`, `field_type`, `unique`, `defaultvalue`, `minlength`, `maxlength`, `required`, `popup_vals`, `sort`, `created_at`, `updated_at`) VALUES
(1,	'nombre',	'Nombre',	1,	16,	0,	'',	5,	250,	1,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 10:49:59'),
(2,	'contexto_id',	'Contexto',	1,	13,	0,	'0',	0,	11,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 10:50:31'),
(3,	'email',	'Email',	1,	8,	1,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(4,	'password',	'Password',	1,	17,	0,	'',	3,	250,	1,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 11:19:48'),
(5,	'tipo',	'Tipo de Usuario',	1,	7,	0,	'Asignatura',	0,	0,	1,	'[\"Asignatura\",\"Tiempo Completo\",\"Investigador\",\"Administrador\"]',	0,	'2017-03-07 04:21:30',	'2017-03-07 11:19:11'),
(6,	'name',	'Name',	2,	16,	0,	'',	5,	250,	1,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(7,	'path',	'Path',	2,	19,	0,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(8,	'extension',	'Extension',	2,	19,	0,	'',	0,	20,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(9,	'caption',	'Caption',	2,	19,	0,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(10,	'user_id',	'Owner',	2,	7,	0,	'1',	0,	0,	0,	'@users',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(11,	'hash',	'Hash',	2,	19,	0,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(12,	'public',	'Is Public',	2,	2,	0,	'0',	0,	0,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(30,	'name',	'Name',	5,	16,	1,	'',	1,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(31,	'display_name',	'Display Name',	5,	19,	0,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(32,	'description',	'Description',	5,	21,	0,	'',	0,	1000,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(33,	'parent',	'Parent Role',	5,	7,	0,	'1',	0,	0,	0,	'@roles',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(74,	'estante',	'Número de Estante',	13,	13,	0,	'',	1,	11,	1,	'',	0,	'2017-03-07 11:28:21',	'2017-03-07 11:28:21'),
(73,	'anaquel',	'Número de Anaquel',	13,	13,	0,	'',	1,	11,	1,	'',	0,	'2017-03-07 11:27:47',	'2017-03-07 11:27:47'),
(72,	'codigo',	'Código',	13,	16,	0,	'',	3,	256,	1,	'',	0,	'2017-03-07 11:27:17',	'2017-03-07 11:27:17'),
(71,	'marca',	'Marca',	13,	16,	0,	'',	3,	256,	1,	'',	0,	'2017-03-07 11:26:40',	'2017-03-07 11:26:40'),
(46,	'name',	'Name',	7,	16,	1,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(47,	'file_name',	'File Name',	7,	19,	1,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(48,	'backup_size',	'File Size',	7,	19,	0,	'0',	0,	10,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(49,	'name',	'Name',	8,	16,	1,	'',	1,	250,	1,	'',	0,	'2017-03-07 04:21:32',	'2017-03-07 04:21:32'),
(50,	'display_name',	'Display Name',	8,	19,	0,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:32',	'2017-03-07 04:21:32'),
(51,	'description',	'Description',	8,	21,	0,	'',	0,	1000,	0,	'',	0,	'2017-03-07 04:21:32',	'2017-03-07 04:21:32'),
(52,	'fecha_inicio',	'Fecha de Inicio',	9,	5,	0,	'',	0,	0,	1,	'',	0,	'2017-03-07 08:47:11',	'2017-03-07 08:47:11'),
(53,	'fecha_fin',	'Fecha de Fin',	9,	5,	0,	'',	0,	0,	1,	'',	0,	'2017-03-07 08:47:31',	'2017-03-07 08:47:31'),
(54,	'fecha_inicio',	'Fecha de Inicio',	10,	5,	0,	'',	0,	0,	1,	'',	0,	'2017-03-07 09:04:24',	'2017-03-07 09:07:55'),
(55,	'fecha_fin',	'Fecha de Fin',	10,	5,	0,	'',	0,	0,	1,	'',	0,	'2017-03-07 09:04:24',	'2017-03-07 09:09:37'),
(56,	'nombre',	'Nombre',	11,	16,	1,	'',	3,	256,	1,	'',	0,	'2017-03-07 09:31:16',	'2017-03-07 09:31:16'),
(57,	'nombre',	'Nombre',	12,	16,	1,	'',	3,	256,	1,	'',	0,	'2017-03-07 09:32:49',	'2017-03-07 09:32:49'),
(58,	'objetivo',	'Objetivo',	12,	22,	0,	'',	3,	256,	1,	'',	0,	'2017-03-07 09:33:23',	'2017-03-07 09:33:23'),
(59,	'introduccion',	'Introducción',	12,	22,	0,	'',	3,	256,	1,	'',	0,	'2017-03-07 09:35:05',	'2017-03-07 09:35:05'),
(60,	'bibliografia',	'Bibliografia',	12,	22,	0,	'',	3,	256,	1,	'',	0,	'2017-03-07 09:37:41',	'2017-03-07 09:37:41'),
(61,	'procedimiento',	'Procedimiento',	12,	22,	0,	'',	3,	256,	1,	'',	0,	'2017-03-07 09:38:08',	'2017-03-07 09:38:08'),
(62,	'preguntas',	'Preguntas',	12,	22,	0,	'',	3,	256,	1,	'',	0,	'2017-03-07 09:41:22',	'2017-03-07 09:41:22'),
(63,	'descripcion',	'Descripción',	13,	16,	1,	'',	3,	256,	1,	'',	0,	'2017-03-07 09:48:40',	'2017-03-07 11:26:16'),
(77,	'unidad',	'Unidad de Medida',	15,	7,	0,	'',	0,	0,	0,	'[\"kg\",\"g\",\"l\",\"ml\",\"cajas\",\"paquetes\"]',	0,	'2017-03-07 11:36:13',	'2017-03-07 11:36:13'),
(76,	'cantidad',	'Cantidad',	15,	13,	0,	'0',	0,	11,	1,	'',	0,	'2017-03-07 11:31:42',	'2017-03-07 11:31:42'),
(75,	'nombre',	'Nombre',	15,	16,	0,	'',	3,	256,	1,	'',	0,	'2017-03-07 11:31:08',	'2017-03-07 11:31:08'),
(70,	'cantidad',	'Cantidad',	13,	13,	0,	'',	0,	11,	1,	'',	0,	'2017-03-07 10:28:41',	'2017-03-07 10:28:41');

DROP TABLE IF EXISTS `module_field_types`;
CREATE TABLE `module_field_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `module_field_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1,	'Address',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(2,	'Checkbox',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(3,	'Currency',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(4,	'Date',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(5,	'Datetime',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(6,	'Decimal',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(7,	'Dropdown',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(8,	'Email',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(9,	'File',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(10,	'Float',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(11,	'HTML',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(12,	'Image',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(13,	'Integer',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(14,	'Mobile',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(15,	'Multiselect',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(16,	'Name',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(17,	'Password',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(18,	'Radio',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(19,	'String',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(20,	'Taginput',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(21,	'Textarea',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(22,	'TextField',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(23,	'URL',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(24,	'Files',	'2017-03-07 04:21:30',	'2017-03-07 04:21:30');

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `display_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1,	'ADMIN_PANEL',	'Panel de Administración',	'Permiso de acceso a la configuración del sistema',	NULL,	'2017-03-07 04:21:33',	'2017-03-07 10:54:19');

DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1,	1);

DROP TABLE IF EXISTS `practicas`;
CREATE TABLE `practicas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nombre` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `objetivo` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `introduccion` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `bibliografia` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `procedimiento` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `preguntas` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE `prestamos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `fecha_fin` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `reactivos`;
CREATE TABLE `reactivos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nombre` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cantidad` int(10) unsigned NOT NULL DEFAULT '0',
  `unidad` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `reservaciones`;
CREATE TABLE `reservaciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_inicio` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `fecha_fin` timestamp NOT NULL DEFAULT '1970-01-01 07:01:01',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `display_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `parent` int(10) unsigned NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`),
  KEY `roles_parent_foreign` (`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `parent`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1,	'SUPER_ADMIN',	'Administrador Raíz',	'Administrador de sistema',	0,	NULL,	'2017-03-07 04:21:33',	'2017-03-07 10:53:37');

DROP TABLE IF EXISTS `role_module`;
CREATE TABLE `role_module` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `module_id` int(10) unsigned NOT NULL,
  `acc_view` tinyint(1) NOT NULL,
  `acc_create` tinyint(1) NOT NULL,
  `acc_edit` tinyint(1) NOT NULL,
  `acc_delete` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_module_role_id_foreign` (`role_id`),
  KEY `role_module_module_id_foreign` (`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `role_module` (`id`, `role_id`, `module_id`, `acc_view`, `acc_create`, `acc_edit`, `acc_delete`, `created_at`, `updated_at`) VALUES
(1,	1,	1,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(2,	1,	2,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(3,	1,	3,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(4,	1,	4,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(5,	1,	5,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(6,	1,	6,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(7,	1,	7,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(8,	1,	8,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(9,	1,	9,	1,	1,	1,	1,	'2017-03-07 08:50:08',	'2017-03-07 08:50:08'),
(10,	1,	10,	1,	1,	1,	1,	'2017-03-07 09:09:21',	'2017-03-07 09:09:21'),
(11,	1,	11,	1,	1,	1,	1,	'2017-03-07 09:31:27',	'2017-03-07 09:31:27'),
(12,	1,	12,	1,	1,	1,	1,	'2017-03-07 09:41:34',	'2017-03-07 09:41:34'),
(13,	1,	13,	1,	1,	1,	1,	'2017-03-07 10:08:11',	'2017-03-07 10:08:11'),
(14,	1,	14,	1,	1,	1,	1,	'2017-03-07 10:16:44',	'2017-03-07 10:16:44'),
(15,	1,	15,	1,	1,	1,	1,	'2017-03-07 11:36:24',	'2017-03-07 11:36:24');

DROP TABLE IF EXISTS `role_module_fields`;
CREATE TABLE `role_module_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `field_id` int(10) unsigned NOT NULL,
  `access` enum('invisible','readonly','write') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_module_fields_role_id_foreign` (`role_id`),
  KEY `role_module_fields_field_id_foreign` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `role_module_fields` (`id`, `role_id`, `field_id`, `access`, `created_at`, `updated_at`) VALUES
(1,	1,	1,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(2,	1,	2,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(3,	1,	3,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(4,	1,	4,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(5,	1,	5,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(6,	1,	6,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(7,	1,	7,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(8,	1,	8,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(9,	1,	9,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(10,	1,	10,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(11,	1,	11,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(12,	1,	12,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(13,	1,	13,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(14,	1,	14,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(15,	1,	15,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(16,	1,	16,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(17,	1,	17,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(18,	1,	18,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(19,	1,	19,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(20,	1,	20,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(21,	1,	21,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(22,	1,	22,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(23,	1,	23,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(24,	1,	24,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(25,	1,	25,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(26,	1,	26,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(27,	1,	27,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(28,	1,	28,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(29,	1,	29,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(30,	1,	30,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(31,	1,	31,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(32,	1,	32,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(33,	1,	33,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(34,	1,	34,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(35,	1,	35,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(36,	1,	36,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(37,	1,	37,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(38,	1,	38,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(39,	1,	39,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(40,	1,	40,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(41,	1,	41,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(42,	1,	42,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(43,	1,	43,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(44,	1,	44,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(45,	1,	45,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(46,	1,	46,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(47,	1,	47,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(48,	1,	48,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(49,	1,	49,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(50,	1,	50,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(51,	1,	51,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(52,	1,	52,	'write',	'2017-03-07 08:47:11',	'2017-03-07 08:47:11'),
(53,	1,	53,	'write',	'2017-03-07 08:47:31',	'2017-03-07 08:47:31'),
(54,	1,	54,	'write',	'2017-03-07 09:09:21',	'2017-03-07 09:09:21'),
(55,	1,	55,	'write',	'2017-03-07 09:09:21',	'2017-03-07 09:09:21'),
(56,	1,	56,	'write',	'2017-03-07 09:31:16',	'2017-03-07 09:31:16'),
(57,	1,	57,	'write',	'2017-03-07 09:32:49',	'2017-03-07 09:32:49'),
(58,	1,	58,	'write',	'2017-03-07 09:33:23',	'2017-03-07 09:33:23'),
(59,	1,	59,	'write',	'2017-03-07 09:35:05',	'2017-03-07 09:35:05'),
(60,	1,	60,	'write',	'2017-03-07 09:37:42',	'2017-03-07 09:37:42'),
(61,	1,	61,	'write',	'2017-03-07 09:38:08',	'2017-03-07 09:38:08'),
(62,	1,	62,	'write',	'2017-03-07 09:41:23',	'2017-03-07 09:41:23'),
(63,	1,	63,	'write',	'2017-03-07 09:48:40',	'2017-03-07 09:48:40'),
(64,	1,	64,	'write',	'2017-03-07 10:14:15',	'2017-03-07 10:14:15'),
(65,	1,	65,	'write',	'2017-03-07 10:14:37',	'2017-03-07 10:14:37'),
(66,	1,	66,	'write',	'2017-03-07 10:15:19',	'2017-03-07 10:15:19'),
(67,	1,	67,	'write',	'2017-03-07 10:16:03',	'2017-03-07 10:16:03'),
(68,	1,	68,	'write',	'2017-03-07 10:16:30',	'2017-03-07 10:16:30'),
(69,	1,	69,	'write',	'2017-03-07 10:28:08',	'2017-03-07 10:28:08'),
(70,	1,	70,	'write',	'2017-03-07 10:28:41',	'2017-03-07 10:28:41'),
(71,	1,	71,	'write',	'2017-03-07 11:26:40',	'2017-03-07 11:26:40'),
(72,	1,	72,	'write',	'2017-03-07 11:27:17',	'2017-03-07 11:27:17'),
(73,	1,	73,	'write',	'2017-03-07 11:27:47',	'2017-03-07 11:27:47'),
(74,	1,	74,	'write',	'2017-03-07 11:28:21',	'2017-03-07 11:28:21'),
(75,	1,	75,	'write',	'2017-03-07 11:31:08',	'2017-03-07 11:31:08'),
(76,	1,	76,	'write',	'2017-03-07 11:31:42',	'2017-03-07 11:31:42'),
(77,	1,	77,	'write',	'2017-03-07 11:36:13',	'2017-03-07 11:36:13');

DROP TABLE IF EXISTS `role_user`;
CREATE TABLE `role_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  KEY `role_user_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1,	1,	1,	NULL,	NULL);

DROP TABLE IF EXISTS `uploads`;
CREATE TABLE `uploads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `path` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `caption` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT '1',
  `hash` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uploads_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `contexto_id` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `tipo` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Asignatura',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `nombre`, `contexto_id`, `email`, `password`, `tipo`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1,	'Administrador',	1,	'administrador@adminlab.com',	'$2y$10$.EpR/BnPbdzHLIE8Bb1ok.GSvCVr4N/9R8lzQFSYjknlZJ4CFUgOq',	'Administrador',	'uUoojlUjVulEOap6y8ljpNvEl4SdGm9QTADSQdQGNKwCPZba2fFjXu3MgT65',	NULL,	'2017-03-07 04:23:44',	'2017-03-07 11:38:20');

-- 2017-03-07 05:42:23
