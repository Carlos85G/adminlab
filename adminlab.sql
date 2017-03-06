-- Adminer 4.2.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

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


DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `tags` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '[]',
  `color` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `departments_name_unique` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `departments` (`id`, `name`, `tags`, `color`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1,	'Administration',	'[]',	'#000',	NULL,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33');

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `designation` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Male',
  `mobile` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mobile2` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `dept` int(10) unsigned NOT NULL DEFAULT '1',
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `employees` (`id`, `name`, `designation`, `gender`, `mobile`, `mobile2`, `email`, `dept`, `city`, `address`, `about`, `date_birth`, `date_hire`, `date_left`, `salary_cur`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1,	'Administrador',	'Super Admin',	'Male',	'8888888888',	'',	'administrador@adminlab.com',	1,	'Pune',	'Karve nagar, Pune 411030',	'About user / biography',	'2017-03-06',	'2017-03-06',	'2017-03-06',	0.000,	NULL,	'2017-03-07 04:23:44',	'2017-03-07 04:23:44');

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
(1,	'sitename',	'',	'LaraAdmin 1.0',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(2,	'sitename_part1',	'',	'Lara',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(3,	'sitename_part2',	'',	'Admin 1.0',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(4,	'sitename_short',	'',	'LA',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(5,	'site_description',	'',	'LaraAdmin is a open-source Laravel Admin Panel for quick-start Admin based applications and boilerplate for CRM or CMS systems.',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(6,	'sidebar_search',	'',	'1',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(7,	'show_messages',	'',	'1',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(8,	'show_notifications',	'',	'1',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(9,	'show_tasks',	'',	'1',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(10,	'show_rightsidebar',	'',	'1',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(11,	'skin',	'',	'skin-white',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(12,	'layout',	'',	'fixed',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(13,	'default_email',	'',	'test@example.com',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33');

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
(1,	'Team',	'#',	'fa-group',	'custom',	0,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(2,	'Users',	'users',	'fa-group',	'module',	1,	0,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(3,	'Uploads',	'uploads',	'fa-files-o',	'module',	0,	0,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(4,	'Departments',	'departments',	'fa-tags',	'module',	1,	0,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(5,	'Employees',	'employees',	'fa-group',	'module',	1,	0,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(6,	'Roles',	'roles',	'fa-user-plus',	'module',	1,	0,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(7,	'Organizations',	'organizations',	'fa-university',	'module',	0,	0,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33'),
(8,	'Permissions',	'permissions',	'fa-magic',	'module',	1,	0,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33');

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
('2016_10_06_115413_create_la_configs_table',	1);

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
(1,	'Users',	'Users',	'users',	'name',	'User',	'UsersController',	'fa-group',	1,	'2017-03-07 04:21:30',	'2017-03-07 04:21:33'),
(2,	'Uploads',	'Uploads',	'uploads',	'name',	'Upload',	'UploadsController',	'fa-files-o',	1,	'2017-03-07 04:21:30',	'2017-03-07 04:21:33'),
(3,	'Departments',	'Departments',	'departments',	'name',	'Department',	'DepartmentsController',	'fa-tags',	1,	'2017-03-07 04:21:30',	'2017-03-07 04:21:33'),
(4,	'Employees',	'Employees',	'employees',	'name',	'Employee',	'EmployeesController',	'fa-group',	1,	'2017-03-07 04:21:31',	'2017-03-07 04:21:33'),
(5,	'Roles',	'Roles',	'roles',	'name',	'Role',	'RolesController',	'fa-user-plus',	1,	'2017-03-07 04:21:31',	'2017-03-07 04:21:33'),
(6,	'Organizations',	'Organizations',	'organizations',	'name',	'Organization',	'OrganizationsController',	'fa-university',	1,	'2017-03-07 04:21:31',	'2017-03-07 04:21:33'),
(7,	'Backups',	'Backups',	'backups',	'name',	'Backup',	'BackupsController',	'fa-hdd-o',	1,	'2017-03-07 04:21:31',	'2017-03-07 04:21:33'),
(8,	'Permissions',	'Permissions',	'permissions',	'name',	'Permission',	'PermissionsController',	'fa-magic',	1,	'2017-03-07 04:21:32',	'2017-03-07 04:21:33');

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
(1,	'name',	'Name',	1,	16,	0,	'',	5,	250,	1,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(2,	'context_id',	'Context',	1,	13,	0,	'0',	0,	0,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(3,	'email',	'Email',	1,	8,	1,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(4,	'password',	'Password',	1,	17,	0,	'',	6,	250,	1,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(5,	'type',	'User Type',	1,	7,	0,	'Employee',	0,	0,	0,	'[\"Employee\",\"Client\"]',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(6,	'name',	'Name',	2,	16,	0,	'',	5,	250,	1,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(7,	'path',	'Path',	2,	19,	0,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(8,	'extension',	'Extension',	2,	19,	0,	'',	0,	20,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(9,	'caption',	'Caption',	2,	19,	0,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(10,	'user_id',	'Owner',	2,	7,	0,	'1',	0,	0,	0,	'@users',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(11,	'hash',	'Hash',	2,	19,	0,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(12,	'public',	'Is Public',	2,	2,	0,	'0',	0,	0,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(13,	'name',	'Name',	3,	16,	1,	'',	1,	250,	1,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(14,	'tags',	'Tags',	3,	20,	0,	'[]',	0,	0,	0,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(15,	'color',	'Color',	3,	19,	0,	'',	0,	50,	1,	'',	0,	'2017-03-07 04:21:30',	'2017-03-07 04:21:30'),
(16,	'name',	'Name',	4,	16,	0,	'',	5,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(17,	'designation',	'Designation',	4,	19,	0,	'',	0,	50,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(18,	'gender',	'Gender',	4,	18,	0,	'Male',	0,	0,	1,	'[\"Male\",\"Female\"]',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(19,	'mobile',	'Mobile',	4,	14,	0,	'',	10,	20,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(20,	'mobile2',	'Alternative Mobile',	4,	14,	0,	'',	10,	20,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(21,	'email',	'Email',	4,	8,	1,	'',	5,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(22,	'dept',	'Department',	4,	7,	0,	'0',	0,	0,	1,	'@departments',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(23,	'city',	'City',	4,	19,	0,	'',	0,	50,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(24,	'address',	'Address',	4,	1,	0,	'',	0,	1000,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(25,	'about',	'About',	4,	19,	0,	'',	0,	0,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(26,	'date_birth',	'Date of Birth',	4,	4,	0,	'1990-01-01',	0,	0,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(27,	'date_hire',	'Hiring Date',	4,	4,	0,	'date(\'Y-m-d\')',	0,	0,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(28,	'date_left',	'Resignation Date',	4,	4,	0,	'1990-01-01',	0,	0,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(29,	'salary_cur',	'Current Salary',	4,	6,	0,	'0.0',	0,	2,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(30,	'name',	'Name',	5,	16,	1,	'',	1,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(31,	'display_name',	'Display Name',	5,	19,	0,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(32,	'description',	'Description',	5,	21,	0,	'',	0,	1000,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(33,	'parent',	'Parent Role',	5,	7,	0,	'1',	0,	0,	0,	'@roles',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(34,	'dept',	'Department',	5,	7,	0,	'1',	0,	0,	0,	'@departments',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(35,	'name',	'Name',	6,	16,	1,	'',	5,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(36,	'email',	'Email',	6,	8,	1,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(37,	'phone',	'Phone',	6,	14,	0,	'',	0,	20,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(38,	'website',	'Website',	6,	23,	0,	'http://',	0,	250,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(39,	'assigned_to',	'Assigned to',	6,	7,	0,	'0',	0,	0,	0,	'@employees',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(40,	'connect_since',	'Connected Since',	6,	4,	0,	'date(\'Y-m-d\')',	0,	0,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(41,	'address',	'Address',	6,	1,	0,	'',	0,	1000,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(42,	'city',	'City',	6,	19,	0,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(43,	'description',	'Description',	6,	21,	0,	'',	0,	1000,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(44,	'profile_image',	'Profile Image',	6,	12,	0,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(45,	'profile',	'Company Profile',	6,	9,	0,	'',	0,	250,	0,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(46,	'name',	'Name',	7,	16,	1,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(47,	'file_name',	'File Name',	7,	19,	1,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(48,	'backup_size',	'File Size',	7,	19,	0,	'0',	0,	10,	1,	'',	0,	'2017-03-07 04:21:31',	'2017-03-07 04:21:31'),
(49,	'name',	'Name',	8,	16,	1,	'',	1,	250,	1,	'',	0,	'2017-03-07 04:21:32',	'2017-03-07 04:21:32'),
(50,	'display_name',	'Display Name',	8,	19,	0,	'',	0,	250,	1,	'',	0,	'2017-03-07 04:21:32',	'2017-03-07 04:21:32'),
(51,	'description',	'Description',	8,	21,	0,	'',	0,	1000,	0,	'',	0,	'2017-03-07 04:21:32',	'2017-03-07 04:21:32');

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

DROP TABLE IF EXISTS `organizations`;
CREATE TABLE `organizations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'http://',
  `assigned_to` int(10) unsigned NOT NULL DEFAULT '1',
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
(1,	'ADMIN_PANEL',	'Admin Panel',	'Admin Panel Permission',	NULL,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33');

DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1,	1);

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `display_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `parent` int(10) unsigned NOT NULL DEFAULT '1',
  `dept` int(10) unsigned NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`),
  KEY `roles_parent_foreign` (`parent`),
  KEY `roles_dept_foreign` (`dept`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `parent`, `dept`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1,	'SUPER_ADMIN',	'Super Admin',	'Full Access Role',	1,	1,	NULL,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33');

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
(8,	1,	8,	1,	1,	1,	1,	'2017-03-07 04:21:33',	'2017-03-07 04:21:33');

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
(51,	1,	51,	'write',	'2017-03-07 04:21:33',	'2017-03-07 04:21:33');

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
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `context_id` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Employee',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `name`, `context_id`, `email`, `password`, `type`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1,	'Administrador',	1,	'administrador@adminlab.com',	'$2y$10$XExy.c2H9bi/IGipM.NrKuRY2aRs.7.V06PhIJj/PBUOpY/2eaO..',	'Employee',	NULL,	NULL,	'2017-03-07 04:23:44',	'2017-03-07 04:23:44');

-- 2017-03-06 22:35:55
