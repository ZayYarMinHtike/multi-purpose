-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 26, 2019 at 08:34 AM
-- Server version: 5.7.27-0ubuntu0.18.04.1
-- PHP Version: 7.2.19-0ubuntu0.18.04.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `multi`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `body`, `created_at`, `updated_at`) VALUES
(1, 6, 2, 'a great post ! admin', '2019-08-26 00:26:44', '2019-08-26 00:26:44'),
(2, 2, 2, 'yep', '2019-08-26 00:27:16', '2019-08-26 00:27:16'),
(3, 7, 3, 'check out my post dude!', '2019-08-26 00:33:37', '2019-08-26 00:33:37');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_08_19_102311_create_posts_table', 1),
(9, '2019_08_20_170327_create_comments_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `body`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, 'Using Laravel Seeders', 'Laravel includes a simple method of seeding your database with test data using seed classes. All seed classes are stored in the database/seeds directory. Seed classes may have any name you wish, but probably should follow some sensible convention, such as UsersTableSeeder, etc. By default, a DatabaseSeeder class is defined for you. From this class, you may use the  call method to run other seed classes, allowing you to control the seeding order.', '1566801783.jpeg', '2019-08-25 14:29:34', '2019-08-26 00:13:04'),
(2, 1, 'Database: Migrations', 'Migrations are like version control for your database, allowing your team to easily modify and share the application\'s database schema. Migrations are typically paired with Laravel\'s schema builder to easily build your application\'s database schema. If you have ever had to tell a teammate to manually add a column to their local database schema, you\'ve faced the problem that database migrations solve.', '1566802019.jpeg', '2019-08-25 14:29:34', '2019-08-26 00:16:59'),
(3, 2, 'How do you teach frontend development to a new-comer or yourself', 'That’s the beauty of web development, Unlike the backend programming language where you need to remember many classes, utilities, paradigms, and flow diagram, Frontend development gives you an option to explore your creativity and create the templates, which suits you the most.\nSo basic tip is to not to memorize anything, instead, learner should visualize, what he will be making like a clone to facebook or amazon etc. Once this goal is fixed, he might be lured into and can easily apply his own ideas. You can even set a timeline for the goal like 15 days. After that, you help him to start building each block of the website and teach him to merge them together.', 'how-do-you-teach-frontend-development-to-a-new-comer-or-yourself.jpeg', '2019-08-26 00:20:54', '2019-08-26 00:20:54'),
(4, 6, 'What is a Full Stack Developer?', 'A full stack developer is a web developer or engineer who works with both the front and back ends of a website or application—meaning they can tackle projects that involve databases, building user-facing websites, or even work with clients during the planning phase of projects.', 'what-is-a-full-stack-developer.jpeg', '2019-08-26 00:24:32', '2019-08-26 00:24:32'),
(5, 7, 'Books & Coffee: A Love Story', 'I have a special love of books and coffee, the two pairing perfectly together. Coffee can be a pick-me-up to a dreary day; so can a book. Coffee can be the jolt you need to start on a new project; so can a book. The memory of a good cup of coffee will stay with you long after you’ve consumed it, and the same goes for a good book. It’s no surprise then that the combined bookstore/cafe enterprise would work so well.\r\n\r\n“I think the special connection between books and coffee is simple: ideas,” says Matthew Davis of Politics & Prose in Washington D.C. “Bookstores are creative places that are full of new ideas and stories and perspectives. Coffee is the lubricant for that creativity.”', '1566802961.jpeg', '2019-08-26 00:32:29', '2019-08-26 00:32:41'),
(6, 8, 'Does Ninja still exist?', 'Ninja (忍者) was a covert agent or mercenary in feudal Japan, and it’s mostly known as assassins with special techniques. Mie and Shiga Prefectures are best known as the birthplace of Ninja, and there are some related spots in Tokyo, too.\r\n\r\nIf you are keen on learning Ninja’s special techniques, you can experience them at Musashi, the Ninja ancestors who came to Tokyo over 400 years ago. Put on Ninja costume and practice some of significant techniques like Ninja star and blowgun with real Ninja!\r\n\r\nSamurai (侍) or sometimes called Bushi (武士) is another well-known symbol of Japan. They have built their golden history for fighting in hundreds and thousands years. The spirit of Samurai has been strongly remained in our hearts today, and the word Samurai is often used for calling Japanese athletes at big sport competitions today.\r\n\r\nBut how much do we know about Samurai? What did they actually look like? In Tokyo, there are several spots where you can learn and experience\r\nthe Samurai culture, such as Samurai Museum and Samurai Armor Photo Studio.', 'does-ninja-still-exist.jpeg', '2019-08-26 00:39:24', '2019-08-26 00:39:24');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `bio` mediumtext COLLATE utf8mb4_unicode_ci,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'profile.png',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `type`, `bio`, `photo`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'zymh', 'zymh@gmail.com', '$2y$10$Vt7ftmx/a6sik58fCsebgu1YGfIn4kgq7lcz3TFaCIcWGznueFQfK', 'admin', 'administartor and group leader', '1566802070.png', NULL, '2019-08-25 14:29:34', '2019-08-26 00:17:50'),
(2, 'drzymh', 'drzymh@gmail.com', '$2y$10$EZm0e0BHQrteES7d14MkNOdnTC9gcyLO/wx9k.LmDMlwCkWQxyq3m', 'admin', 'second admin', '1566802712.png', NULL, '2019-08-25 14:29:34', '2019-08-26 00:28:32'),
(3, 'koko', 'koko@gmail.com', '$2y$10$UXwDaE4w49A5AgkLDAS6ye1Q2TOZEwo9btFa6.b9wKlbWPSNp1g6u', 'user', NULL, 'profile.png', NULL, '2019-08-25 23:59:29', '2019-08-25 23:59:29'),
(4, 'popo', 'popo@gmail.com', '$2y$10$Zr1voBiBPDF1Lt7WUHFnQ.J9usR2a81UhMDX3J1PATdHVIExmFXwK', 'user', NULL, 'profile.png', NULL, '2019-08-25 23:59:56', '2019-08-25 23:59:56'),
(5, 'ye yint', 'yeyint@gmail.com', '$2y$10$g48lpFyFBdumgvZr44YQV.NIZU7PgDzvbJbi878SkAUSl/lB0c4d2', 'user', NULL, 'profile.png', NULL, '2019-08-26 00:01:02', '2019-08-26 00:01:02'),
(6, 'moe moe', 'moe@gmail.com', '$2y$10$AjNO2AdGsphPq42GshRaG.sJ2.1LZ8vzLpnNr7PvKVvHSpHBnhLNW', 'member', 'a member of the blog', '1566802518.png', NULL, '2019-08-26 00:01:44', '2019-08-26 00:25:18'),
(7, 'soe gyi', 'soegyi@gmail.com', '$2y$10$Qa3GpbkXlaTOmKniFJv22.BWtAvz80CktE4QXxE8tB3d/oV466WFC', 'member', 'core member', '1566802986.png', NULL, '2019-08-26 00:02:14', '2019-08-26 00:33:06'),
(8, 'kaung myant', 'kaung@gmail.com', '$2y$10$uXua9gtitKktx7QgETsQkO3gJKH5C2Adolf/zcaGRbfkn.ljz6fTe', 'member', NULL, '1566803380.png', NULL, '2019-08-26 00:02:47', '2019-08-26 00:39:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
