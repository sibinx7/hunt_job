-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 25, 2015 at 06:21 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `jobs_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `active_admin_comments`
--

CREATE TABLE IF NOT EXISTS `active_admin_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namespace` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `resource_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `resource_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_active_admin_comments_on_namespace` (`namespace`),
  KEY `index_active_admin_comments_on_author_type_and_author_id` (`author_type`,`author_id`),
  KEY `index_active_admin_comments_on_resource_type_and_resource_id` (`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE IF NOT EXISTS `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`),
  UNIQUE KEY `index_admin_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `created_at`, `updated_at`) VALUES
(1, 'admin@example.com', '$2a$10$rz7gueBex6SeY0KojmvF7OOlMoQgkshBNO6iwhWc8pzkVgMnHdvQ6', NULL, NULL, NULL, 2, '2015-03-31 06:45:40', '2015-03-31 00:25:05', '127.0.0.1', '127.0.0.1', '2015-03-26 05:05:01', '2015-03-31 06:45:40');

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `place` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ifsc_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_csc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `user_id`, `name`, `address`, `place`, `account_no`, `ifsc_code`, `card_no`, `card_csc`, `created_at`, `updated_at`) VALUES
(2, 1, 'Union Bank Of India', '<p>Union Bank Of India</p>\r\n\r\n<p>Koovappady&nbsp;</p>\r\n\r\n<p>Perumnavoor&nbsp;</p>\r\n', 'Koovappady', 'BBBBUS3MXXX', 'UBIN0533874', 'BBBBUS3MXXX', '213', '2015-04-15 15:55:46', '2015-04-15 15:55:46'),
(3, 1, 'Union Bank Of India', '<p>Union Bank Of India&nbsp;</p>\r\n', 'Koovappady', 'BBBBUS3MXXX', 'UBIN0533874', 'BBBBUS3MXXX', '123', '2015-04-15 15:58:32', '2015-04-15 15:58:32');

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE IF NOT EXISTS `bids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `details` text COLLATE utf8_unicode_ci,
  `project_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `bid` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL,
  `granted` tinyint(1) DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  `accepted_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` (`id`, `details`, `project_id`, `user_id`, `bid`, `duration`, `status`, `percentage`, `granted`, `accepted`, `accepted_date`) VALUES
(1, '<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\n\n<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\n', 64, 1, 120, 20, NULL, NULL, NULL, NULL, '2015-04-22 17:58:03'),
(2, '<p>Thanks for, I can build website&nbsp;</p>\r\n', 66, 1, 100, 30, NULL, NULL, NULL, NULL, '2015-04-22 17:57:41'),
(3, '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consequat pretium lectus scelerisque dictum. Integer non porta orci. Curabitur nulla tellus, ultrices at tempus nec, finibus quis risus. Fusce tempus hendrerit luctus. Ut imperdiet lorem nec neque dictum, vel luctus mi dapibus. Vestibulum maximus nec justo eu viverra. Sed fermentum vulputate tristique. Vestibulum quis ligula quis ipsum tincidunt scelerisque. Nunc nibh nibh, eleifend vel turpis quis, posuere euismod nulla. Nam vel sapien quis augue sagittis varius. In non iaculis ante. Praesent vitae suscipit est, id tincidunt leo. Donec eget leo ipsum.</p>\r\n', 65, 1, 100, 10, NULL, 63, 1, 1, '2015-04-22 17:57:01');

-- --------------------------------------------------------

--
-- Table structure for table `ckeditor_assets`
--

CREATE TABLE IF NOT EXISTS `ckeditor_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_file_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_file_size` int(11) DEFAULT NULL,
  `assetable_id` int(11) DEFAULT NULL,
  `assetable_type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ckeditor_assetable_type` (`assetable_type`,`type`,`assetable_id`),
  KEY `idx_ckeditor_assetable` (`assetable_type`,`assetable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `milestones`
--

CREATE TABLE IF NOT EXISTS `milestones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `milestone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bid_id` int(11) DEFAULT NULL,
  `payment` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL,
  `request_payment` tinyint(1) DEFAULT NULL,
  `grant_payment` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

--
-- Dumping data for table `milestones`
--

INSERT INTO `milestones` (`id`, `milestone`, `bid_id`, `payment`, `status`, `percentage`, `request_payment`, `grant_payment`) VALUES
(7, 'Web design', 1, 30, NULL, NULL, NULL, NULL),
(8, 'Features', 1, 50, NULL, NULL, NULL, NULL),
(9, 'Database', 1, 10, NULL, NULL, NULL, NULL),
(10, 'Testing', 1, 10, NULL, NULL, NULL, NULL),
(11, 'Extra features', 1, 20, NULL, NULL, NULL, NULL),
(12, 'Build website', 2, 100, NULL, NULL, NULL, NULL),
(13, 'Templete design', 3, 30, NULL, 100, NULL, NULL),
(14, 'Website Features', 3, 60, NULL, 50, NULL, NULL),
(15, 'Testing', 3, 10, NULL, 39, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `not_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `related_task` int(11) DEFAULT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `title`, `content`, `not_type`, `user_id`, `project_id`, `related_task`, `link`, `created_at`, `updated_at`) VALUES
(1, 'You have been created a new Project', '<p> You have been create a project <b>Create a new Website using Bootstrap</b>, for more information please check this on Project page', 'project', 1, 64, 64, '/projects/64', '2015-04-15 15:44:58', '2015-04-15 15:45:09'),
(2, 'You have been created a Project', '<p>A new Project <b>Business Website Design</b> created. Please see your project on Project listing page', 'project', 1, 67, 67, '/projects/67', '2015-04-15 16:57:47', '2015-04-15 16:57:47'),
(3, 'You have received a new Bid', '<p>Sibin Xavier placed a new Bid on your Project <b>Build a simple text Website (no jQuery/AJAX) -- 2</b>.Quoted Budget is around\n      $ 100.</p><p>Estimated Project duration is 10</p></p>You can see more details on\n      Project Bid page</p>', 'bid', 2, 65, 3, 'http://localhost:4000/dashboard/project/65', '2015-04-16 10:20:12', '2015-04-16 10:20:12'),
(4, 'You have been placed a new Bid', '<p>You create a new Bid on Project Build a simple text Website (no jQuery/AJAX) -- 2.\n       You have been quote $100 for 10 days work.</p>\n      <p>More information available on project page</p>', 'bid', 1, 65, 3, 'http://localhost:4000/dashboard/project/65', '2015-04-16 10:20:12', '2015-04-16 10:20:12'),
(5, 'You Project has been rejected', 'Sibin Xavier rejected  Build a simple text Website (no jQuery/AJAX) -- 2. Please see\n            Project page to know more about your bid', 'bid', 1, NULL, 3, 'http://localhost:4000/bid/project/65/show/3', '2015-04-19 15:19:48', '2015-04-19 15:19:48'),
(6, 'You Project has been rejected', 'Sibin Xavier rejected  Build a simple text Website (no jQuery/AJAX) -- 2. Please see\n            Project page to know more about your bid', 'bid', 1, NULL, 3, 'http://localhost:4000/bid/project/65/show/3', '2015-04-19 15:24:31', '2015-04-19 15:24:31'),
(7, 'You Project has been rejected', 'Sibin Xavier rejected  Build a simple text Website (no jQuery/AJAX) -- 2. Please see\n            Project page to know more about your bid', 'bid', 1, NULL, 3, 'http://localhost:4000/bid/project/65/show/3', '2015-04-19 15:33:04', '2015-04-19 15:33:04'),
(8, 'You Project has been rejected', 'Sibin Xavier rejected  Build a simple text Website (no jQuery/AJAX) -- 2. Please see\n            Project page to know more about your bid', 'bid', 1, NULL, 3, 'http://localhost:4000/bid/project/65/show/3', '2015-04-19 15:35:12', '2015-04-19 15:35:12'),
(9, 'You Project has been rejected', 'Sibin Xavier rejected  Build a simple text Website (no jQuery/AJAX) -- 2. Please see\n            Project page to know more about your bid', 'bid', 1, NULL, 3, 'http://localhost:4000/bid/project/65/show/3', '2015-04-19 15:35:39', '2015-04-19 15:35:39'),
(10, 'You Project has been rejected', 'Sibin Xavier rejected  Build a simple text Website (no jQuery/AJAX) -- 2. Please see\n            Project page to know more about your bid', 'bid', 1, NULL, 3, 'http://localhost:4000/bid/project/65/show/3', '2015-04-19 15:36:18', '2015-04-19 15:36:18'),
(11, 'You Project has been rejected', 'Sibin Xavier rejected  Build a simple text Website (no jQuery/AJAX) -- 2. Please see\n            Project page to know more about your bid', 'bid', 1, NULL, 3, 'http://localhost:4000/bid/project/65/show/3', '2015-04-19 15:45:16', '2015-04-19 15:45:16'),
(12, 'You Project has been rejected', 'Sibin Xavier rejected  Build a simple text Website (no jQuery/AJAX) -- 2. Please see\n            Project page to know more about your bid', 'bid', 1, NULL, 3, 'http://localhost:4000/bid/project/65/show/3', '2015-04-19 15:45:19', '2015-04-19 15:45:19');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `creator` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `min_budget` int(11) DEFAULT NULL,
  `max_budget` int(11) DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `assigned_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `close` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=68 ;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `title`, `description`, `creator`, `min_budget`, `max_budget`, `close_date`, `assigned_to`, `created_at`, `updated_at`, `status`, `close`) VALUES
(63, 'Sample Website for Ecoomers Application', '<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English.</p>\r\n\r\n<p>Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n', '1', 10, 200, '2015-08-17', NULL, '2015-04-10 01:22:49', '2015-04-10 01:22:49', NULL, NULL),
(64, 'Convert a Form Wireframe to custom html & css', '<p><span style="font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 18px;">I need a form with 10 or so fields, and a few radio buttons that is currently wireframed, to be designed and developed into an html form with css files for styling.</span></p>\r\n', '1', 118, 1234, '2015-08-10', NULL, '2015-04-10 17:11:35', '2015-04-10 17:11:35', NULL, NULL),
(65, 'Build a simple text Website (no jQuery/AJAX) -- 2', '<p>Build a simple text website which pulls data from mysql (no jQuery/AJAX or anything fancy)<br />\r\nLong term work for the right developer</p>\r\n', '2', 12, 120, '2015-08-17', NULL, '2015-04-11 01:17:35', '2015-04-11 01:17:35', NULL, NULL),
(66, 'Security Controls Database and Website', '<p>I need a private website and a database created to take security control standards (currently in the form of a word document) and be able to:</p>\r\n\r\n<p>a) Have a method of entry of the data from the word document into the database<br />\r\nb) To have a method to edit the data once it is in the database<br />\r\nc) To be able to export all or part of the data from the database into various forms mainly something that can be opened in excel or word.<br />\r\nd) to be able to have freeform and specific field searches of the database and display the records.<br />\r\ne) to Substitute a specific key such as &quot;&lt;&lt;COMPANY NAME&gt;&gt;&quot; into a logged in variable such as &quot;YBOS Ltd&quot; so the documented security controls appears customised to different companies.</p>\r\n\r\n<p>Currently they are 307 controls but they are all in a basic similar format mainly consisting of headings, free flow text, and measurements / numerics.</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2', 100, 200, '2015-07-15', NULL, '2015-04-14 09:48:32', '2015-04-14 09:48:32', NULL, NULL),
(67, 'Business Website Design', '<p>Project Description:</p>\r\n\r\n<p>Hi,&nbsp;</p>\r\n\r\n<p>We are looking to have a website built<br />\r\nfor our new service. The whole website<br />\r\nwill be built in ONE big page which can<br />\r\nbe scrolled. This website will be the<br />\r\nmarketing homepage as well as the central<br />\r\nsite for all client activities.</p>\r\n\r\n<p>All the buttons for e.g features, services,<br />\r\npricing, etc will be on the main page only.<br />\r\nWhen the buttons are clicked it will take<br />\r\nthe visitor to the different section of<br />\r\nthe website for, example,up,down, centre etc.</p>\r\n', '1', 10, 100, '2015-08-20', NULL, '2015-04-15 16:57:47', '2015-04-15 16:57:47', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `projects_skills`
--

CREATE TABLE IF NOT EXISTS `projects_skills` (
  `project_id` int(11) DEFAULT NULL,
  `skill_id` int(11) DEFAULT NULL,
  KEY `index_projects_skills_on_project_id_and_skill_id` (`project_id`,`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `projects_skills`
--

INSERT INTO `projects_skills` (`project_id`, `skill_id`) VALUES
(63, 1),
(63, 5),
(63, 6),
(64, 21),
(65, 1),
(65, 7),
(66, 1),
(66, 5),
(67, 1),
(67, 5),
(67, 19);

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20150326045856'),
('20150326045914'),
('20150326050133'),
('20150326050158'),
('20150326050328'),
('20150330183730'),
('20150331053248'),
('20150331053249'),
('20150331053250'),
('20150331065707'),
('20150331072013'),
('20150404164757'),
('20150404170818'),
('20150406043438'),
('20150406045936'),
('20150406172918'),
('20150406174406'),
('20150408054934'),
('20150408145520'),
('20150410115203'),
('20150410115429'),
('20150412095125'),
('20150412095753'),
('20150415115657'),
('20150415144728'),
('20150416181059'),
('20150417005557'),
('20150417005845'),
('20150422175124');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE IF NOT EXISTS `services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `creator` int(11) DEFAULT NULL,
  `service_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `service_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE IF NOT EXISTS `skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=35 ;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `name`) VALUES
(1, 'PHP'),
(3, 'Laravel'),
(4, 'Java'),
(5, 'Wordpress'),
(6, 'MySql'),
(7, 'HTML'),
(8, 'Jquery'),
(9, 'NodeJs'),
(10, 'MangoDB'),
(11, 'Angular'),
(12, 'Python'),
(13, 'Django'),
(14, 'Haml'),
(15, 'Backbone'),
(16, 'Express'),
(17, 'JSON'),
(18, 'AJAX'),
(19, 'HTML5'),
(20, 'CSS'),
(21, 'SQL'),
(22, 'Magneto'),
(26, 'Latest'),
(27, 'Drupal'),
(28, 'FuelPHP'),
(29, 'Ghost'),
(30, 'PhpBB'),
(31, 'Joomla'),
(33, 'WinJS'),
(34, 'OpenCart');

-- --------------------------------------------------------

--
-- Table structure for table `skills_users`
--

CREATE TABLE IF NOT EXISTS `skills_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skill_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `skills_users`
--

INSERT INTO `skills_users` (`id`, `skill_id`, `user_id`) VALUES
(1, 1, 1),
(2, 5, 1),
(3, 7, 1),
(5, 14, 1),
(6, 34, 1),
(7, 11, 1),
(8, 18, 1),
(9, 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_image_file_size` int(11) DEFAULT NULL,
  `profile_image_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `country`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `created_at`, `updated_at`, `provider`, `uid`, `profile_image_file_name`, `profile_image_content_type`, `profile_image_file_size`, `profile_image_updated_at`) VALUES
(1, 'Sibin Xavier', 'sibinx7', 'IN', 'sibinx7@outlook.com', '$2a$10$yVCLab87J9h8B1ceENbVMeXOAC3ZJrwah27ehF8FsP70AXNaggITS', NULL, NULL, '2015-04-17 16:14:10', 44, '2015-04-24 18:07:10', '2015-04-24 04:35:49', '127.0.0.1', '127.0.0.1', '2015-03-31 05:32:17', '2015-04-24 18:07:10', NULL, NULL, 'text-jpg.gif', 'image/gif', 26510, '2015-04-08 17:12:20'),
(2, 'Meljo Xavier', 'meljo', 'US', 'sibinx7@gmail.com', '$2a$10$Uald9yQ6UrAv12rsIUkjmu5W0mLde7EpPomeN8MjeOCh5zANXvTze', NULL, NULL, '2015-04-15 11:26:01', 17, '2015-04-24 18:08:14', '2015-04-21 17:09:09', '127.0.0.1', '127.0.0.1', '2015-04-11 01:06:15', '2015-04-24 18:08:14', NULL, NULL, 'user.jpg', 'image/jpeg', 20516, '2015-04-11 01:11:30');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
