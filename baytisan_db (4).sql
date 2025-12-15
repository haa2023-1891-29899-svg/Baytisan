-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2025 at 02:30 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `baytisan_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 3, '2025-09-23 20:46:47', '2025-09-23 20:46:47'),
(2, 4, '2025-09-23 21:13:39', '2025-09-23 21:13:39'),
(3, 5, '2025-09-24 14:36:04', '2025-09-24 14:36:04'),
(4, 14, '2025-11-02 20:15:39', '2025-11-02 20:15:39'),
(5, 7, '2025-11-17 15:31:35', '2025-11-17 15:31:35'),
(6, 16, '2025-11-17 15:40:31', '2025-11-17 15:40:31');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `added_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `cart_id`, `product_id`, `quantity`, `added_at`) VALUES
(13, 3, 56, 1, '2025-09-24 14:36:20'),
(14, 3, 1, 7, '2025-09-24 14:36:20'),
(15, 3, 16, 1, '2025-09-24 14:36:20'),
(65, 1, 1, 1, '2025-11-21 15:10:08');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(4, 'Abaca Bags'),
(5, 'Abaca Baskets'),
(2, 'Abaca Placemats'),
(3, 'Abaca Slippers'),
(6, 'Pili Sweets'),
(1, 'Pots');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`) VALUES
(1, 'Bacacay'),
(2, 'Camalig'),
(3, 'Daraga'),
(4, 'Guinobatan'),
(5, 'Jovellar'),
(6, 'Legazpi'),
(7, 'Libon'),
(8, 'Ligao'),
(9, 'Malilipot'),
(10, 'Malinao'),
(11, 'Manito'),
(12, 'Oas'),
(19, 'Other'),
(13, 'Pio Duran'),
(14, 'Polangui'),
(15, 'Rapu-Rapu'),
(16, 'Santo Domingo'),
(17, 'Tabaco'),
(18, 'Tiwi');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `shipping_address` text DEFAULT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  `placed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_amount`, `shipping_address`, `status`, `placed_at`) VALUES
(1, 3, '450.00', 'alnay', 'delivered', '2025-09-23 13:09:21'),
(2, 3, '600.00', 'alnay', 'delivered', '2025-09-23 13:53:29'),
(3, 4, '300.00', 'polangui', 'delivered', '2025-09-23 21:13:49'),
(4, 4, '150.00', 'dasdasdasdas', 'delivered', '2025-09-23 21:13:58'),
(5, 5, '1270.00', 'adasdasdsad', 'delivered', '2025-09-24 14:36:31'),
(6, 5, '1270.00', 'asdsad', 'delivered', '2025-09-24 20:44:45'),
(7, 3, '450.00', 'dasdasdasd', 'delivered', '2025-10-26 18:01:29'),
(8, 6, '450.00', 'my add', 'delivered', '2025-10-26 18:10:07'),
(9, 7, '1200.00', 'my add', 'delivered', '2025-10-26 18:14:25'),
(10, 7, '150.00', 'my add', 'delivered', '2025-10-26 18:17:53'),
(11, 7, '100.00', 'my add', 'delivered', '2025-10-26 18:24:58'),
(12, 8, '450.00', 'add', 'delivered', '2025-10-26 18:40:32'),
(13, 8, '3000.00', 'add', 'delivered', '2025-10-26 18:43:07'),
(14, 8, '300.00', 'add', 'delivered', '2025-10-26 18:58:21'),
(15, 3, '750.00', 'asdasdsadas', 'delivered', '2025-10-27 19:15:46'),
(16, 3, '450.00', 'weqweqwe', 'delivered', '2025-10-27 19:35:58'),
(17, 3, '450.00', 'dasdsad', 'delivered', '2025-10-27 19:46:48'),
(18, 3, '450.00', 'dasdasdasdasd', 'delivered', '2025-10-27 19:51:34'),
(19, 3, '1350.00', 'sadasd', 'pending', '2025-10-28 08:23:52'),
(20, 14, '450.00', 'add', 'pending', '2025-11-02 20:16:00'),
(21, 7, '600.00', 'add', 'delivered', '2025-11-17 15:31:53'),
(22, 7, '150.00', 'add', 'pending', '2025-11-17 15:33:40'),
(23, 16, '150.00', 'add', 'pending', '2025-11-17 15:40:39'),
(24, 16, '550.00', 'add', 'pending', '2025-11-17 15:44:53'),
(25, 16, '400.00', 'add', 'delivered', '2025-11-17 15:45:29'),
(26, 3, '750.00', 'asdasdasdsadasda', 'delivered', '2025-11-21 13:24:34'),
(27, 4, '650.00', 'asdasdasdasd', 'pending', '2025-11-21 13:33:08'),
(28, 4, '300.00', 'asdasdas', 'pending', '2025-11-21 13:34:08'),
(29, 3, '300.00', 'asdasdasd', 'pending', '2025-11-21 13:37:37'),
(30, 3, '300.00', 'dfgdgfd', 'pending', '2025-11-21 13:46:20'),
(31, 4, '300.00', 'asdasdasd', 'pending', '2025-11-21 15:07:30'),
(32, 4, '150.00', 'sdasdasdasd', 'pending', '2025-11-21 15:09:37'),
(33, 3, '150.00', 'asdasdasd', 'pending', '2025-11-21 15:10:08'),
(34, 4, '150.00', 'dasdasdsa', 'pending', '2025-12-01 15:02:31'),
(35, 4, '150.00', 'asdasdasdasasdasd', 'delivered', '2025-12-01 15:32:57'),
(36, 4, '600.00', 'sadasdasdasdda', 'pending', '2025-12-01 15:34:19'),
(37, 4, '800.00', 'dasdasdasda', 'pending', '2025-12-01 15:36:23');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `unit_price`, `quantity`, `subtotal`) VALUES
(1, 1, 1, '150.00', 2, '300.00'),
(2, 1, 2, '150.00', 1, '150.00'),
(3, 2, 1, '150.00', 2, '300.00'),
(4, 2, 2, '150.00', 1, '150.00'),
(5, 2, 8, '150.00', 1, '150.00'),
(6, 3, 1, '150.00', 2, '300.00'),
(7, 4, 2, '150.00', 1, '150.00'),
(8, 5, 56, '120.00', 1, '120.00'),
(9, 5, 1, '150.00', 7, '1050.00'),
(10, 5, 16, '100.00', 1, '100.00'),
(11, 6, 56, '120.00', 1, '120.00'),
(12, 6, 1, '150.00', 7, '1050.00'),
(13, 6, 16, '100.00', 1, '100.00'),
(14, 7, 2, '150.00', 1, '150.00'),
(15, 7, 5, '150.00', 1, '150.00'),
(16, 7, 1, '150.00', 1, '150.00'),
(17, 8, 1, '150.00', 1, '150.00'),
(18, 8, 2, '150.00', 1, '150.00'),
(19, 8, 3, '150.00', 1, '150.00'),
(20, 9, 1, '150.00', 1, '150.00'),
(21, 9, 2, '150.00', 1, '150.00'),
(22, 9, 3, '150.00', 3, '450.00'),
(23, 9, 11, '150.00', 3, '450.00'),
(24, 10, 2, '150.00', 1, '150.00'),
(25, 11, 16, '100.00', 1, '100.00'),
(26, 12, 2, '150.00', 2, '300.00'),
(27, 12, 7, '150.00', 1, '150.00'),
(28, 13, 65, '120.00', 25, '3000.00'),
(29, 14, 2, '150.00', 1, '150.00'),
(30, 14, 3, '150.00', 1, '150.00'),
(31, 15, 2, '150.00', 1, '150.00'),
(32, 15, 5, '150.00', 1, '150.00'),
(33, 15, 1, '150.00', 1, '150.00'),
(35, 16, 2, '150.00', 1, '150.00'),
(36, 16, 5, '150.00', 1, '150.00'),
(37, 16, 1, '150.00', 1, '150.00'),
(38, 17, 2, '150.00', 1, '150.00'),
(39, 17, 5, '150.00', 1, '150.00'),
(40, 17, 1, '150.00', 1, '150.00'),
(41, 18, 2, '150.00', 1, '150.00'),
(42, 18, 5, '150.00', 1, '150.00'),
(43, 18, 1, '150.00', 1, '150.00'),
(44, 19, 1, '150.00', 7, '1050.00'),
(45, 19, 2, '150.00', 1, '150.00'),
(46, 19, 3, '150.00', 1, '150.00'),
(47, 20, 2, '150.00', 1, '150.00'),
(48, 20, 3, '150.00', 2, '300.00'),
(49, 21, 1, '150.00', 1, '150.00'),
(50, 21, 2, '150.00', 3, '450.00'),
(51, 22, 4, '150.00', 1, '150.00'),
(52, 23, 2, '150.00', 1, '150.00'),
(53, 24, 2, '150.00', 1, '150.00'),
(54, 24, 88, '100.00', 4, '400.00'),
(55, 25, 88, '100.00', 4, '400.00'),
(56, 26, 1, '150.00', 5, '750.00'),
(57, 27, 2, '150.00', 1, '150.00'),
(58, 27, 90, '500.00', 1, '500.00'),
(59, 28, 1, '150.00', 1, '150.00'),
(60, 28, 2, '150.00', 1, '150.00'),
(61, 29, 1, '150.00', 1, '150.00'),
(62, 29, 2, '150.00', 1, '150.00'),
(63, 30, 1, '150.00', 1, '150.00'),
(64, 30, 2, '150.00', 1, '150.00'),
(65, 31, 1, '150.00', 1, '150.00'),
(66, 31, 2, '150.00', 1, '150.00'),
(67, 32, 1, '150.00', 1, '150.00'),
(68, 33, 4, '150.00', 1, '150.00'),
(69, 34, 3, '150.00', 1, '150.00'),
(70, 35, 8, '150.00', 1, '150.00'),
(71, 36, 1, '150.00', 2, '300.00'),
(72, 36, 2, '150.00', 1, '150.00'),
(73, 36, 3, '150.00', 1, '150.00'),
(74, 37, 92, '100.00', 8, '800.00');

-- --------------------------------------------------------

--
-- Table structure for table `order_tracking`
--

CREATE TABLE `order_tracking` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled') NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_tracking`
--

INSERT INTO `order_tracking` (`id`, `order_id`, `status`, `note`, `created_at`) VALUES
(1, 1, 'pending', 'Order placed', '2025-09-23 13:09:21'),
(2, 2, 'pending', 'Order placed', '2025-09-23 13:53:29'),
(3, 3, 'pending', 'Order placed', '2025-09-23 21:13:49'),
(4, 4, 'pending', 'Order placed', '2025-09-23 21:13:58'),
(5, 5, 'pending', 'Order placed', '2025-09-24 14:36:31'),
(6, 6, 'pending', 'Order placed', '2025-09-24 20:44:45'),
(7, 6, 'delivered', 'Order marked delivered by customer', '2025-09-24 21:02:59'),
(8, 4, 'delivered', 'Order marked delivered by customer', '2025-09-24 22:02:59'),
(9, 5, 'delivered', 'Order marked delivered by admin', '2025-09-24 22:10:22'),
(10, 2, 'delivered', 'Order marked delivered by admin', '2025-09-24 22:11:27'),
(11, 7, 'pending', 'Order placed', '2025-10-26 18:01:29'),
(12, 8, 'pending', 'Order placed', '2025-10-26 18:10:07'),
(13, 9, 'pending', 'Order placed', '2025-10-26 18:14:25'),
(14, 9, 'delivered', 'Order marked delivered by customer', '2025-10-26 18:14:41'),
(15, 10, 'pending', 'Order placed', '2025-10-26 18:17:53'),
(16, 11, 'pending', 'Order placed', '2025-10-26 18:24:58'),
(17, 12, 'pending', 'Order placed', '2025-10-26 18:40:32'),
(18, 13, 'pending', 'Order placed', '2025-10-26 18:43:07'),
(19, 13, 'delivered', 'Order marked delivered by customer', '2025-10-26 18:43:21'),
(20, 12, 'delivered', 'Order marked delivered by admin', '2025-10-26 18:57:42'),
(21, 14, 'pending', 'Order placed', '2025-10-26 18:58:21'),
(22, 14, 'delivered', 'Order marked delivered by admin', '2025-10-27 18:32:09'),
(23, 11, 'delivered', 'Order marked delivered by admin', '2025-10-27 18:32:15'),
(24, 10, 'delivered', 'Order marked delivered by admin', '2025-10-27 18:32:21'),
(25, 8, 'delivered', 'Order marked delivered by admin', '2025-10-27 19:11:16'),
(26, 7, 'delivered', 'Order marked delivered by admin', '2025-10-27 19:11:25'),
(27, 3, 'delivered', 'Order marked delivered by admin', '2025-10-27 19:11:28'),
(28, 1, 'delivered', 'Order marked delivered by admin', '2025-10-27 19:11:31'),
(29, 15, 'pending', 'Order placed', '2025-10-27 19:15:46'),
(30, 15, 'delivered', 'Order marked delivered by admin', '2025-10-27 19:17:09'),
(31, 16, 'pending', 'Order placed', '2025-10-27 19:35:58'),
(32, 16, 'delivered', 'Order marked delivered by customer', '2025-10-27 19:39:30'),
(33, 17, 'pending', 'Order placed', '2025-10-27 19:46:48'),
(34, 18, 'pending', 'Order placed', '2025-10-27 19:51:34'),
(35, 18, 'delivered', 'Order marked delivered by admin', '2025-10-27 20:27:26'),
(36, 17, 'delivered', 'Order marked delivered by customer', '2025-10-27 20:28:03'),
(37, 19, 'pending', 'Order placed', '2025-10-28 08:23:52'),
(38, 20, 'pending', 'Order placed', '2025-11-02 20:16:00'),
(39, 21, 'pending', 'Order placed', '2025-11-17 15:31:53'),
(40, 21, 'delivered', 'Order marked delivered by customer', '2025-11-17 15:33:24'),
(41, 22, 'pending', 'Order placed', '2025-11-17 15:33:40'),
(42, 23, 'pending', 'Order placed', '2025-11-17 15:40:39'),
(43, 24, 'pending', 'Order placed', '2025-11-17 15:44:53'),
(44, 25, 'pending', 'Order placed', '2025-11-17 15:45:29'),
(45, 26, 'pending', 'Order placed', '2025-11-21 13:24:34'),
(46, 26, 'delivered', 'Order marked delivered by customer', '2025-11-21 13:24:51'),
(47, 25, 'delivered', 'Order marked delivered by admin', '2025-11-21 13:30:39'),
(48, 27, 'pending', 'Order placed', '2025-11-21 13:33:08'),
(49, 28, 'pending', 'Order placed', '2025-11-21 13:34:08'),
(50, 29, 'pending', 'Order placed', '2025-11-21 13:37:37'),
(51, 30, 'pending', 'Order placed', '2025-11-21 13:46:20'),
(52, 31, 'pending', 'Order placed', '2025-11-21 15:07:30'),
(53, 32, 'pending', 'Order placed', '2025-11-21 15:09:37'),
(54, 33, 'pending', 'Order placed', '2025-11-21 15:10:08'),
(55, 34, 'pending', 'Order placed', '2025-12-01 15:02:31'),
(56, 35, 'pending', 'Order placed', '2025-12-01 15:32:57'),
(57, 35, 'delivered', 'Order marked delivered by customer', '2025-12-01 15:33:28'),
(58, 36, 'pending', 'Order placed', '2025-12-01 15:34:19'),
(59, 37, 'pending', 'Order placed', '2025-12-01 15:36:23');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `origin_location_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `image_filename` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `seller_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `name`, `description`, `category_id`, `origin_location_id`, `price`, `stock`, `image_filename`, `created_at`, `updated_at`, `seller_id`) VALUES
(1, 'POT001', 'Pot 1', 'Handmade clay pot.', 1, 1, '150.00', 100, 'Untitled-1.png', '2025-09-23 02:12:42', '2025-12-01 15:42:27', NULL),
(2, 'POT002', 'Pot 2', 'Handmade clay pot.', 1, 1, '150.00', -17, 'Untitled-2.png', '2025-09-23 02:12:42', '2025-12-01 15:34:19', NULL),
(3, 'POT003', 'Pot 3', 'Handmade clay pot.', 1, 1, '150.00', 0, 'Untitled-3.png', '2025-09-23 02:12:42', '2025-12-01 15:34:19', NULL),
(4, 'POT004', 'Pot 4', 'Handmade clay pot.', 1, 1, '150.00', 8, 'Untitled-4.png', '2025-09-23 02:12:42', '2025-11-21 15:10:08', NULL),
(5, 'POT005', 'Pot 5', 'Handmade clay pot.', 1, 1, '150.00', 5, 'Untitled-5.png', '2025-09-23 02:12:42', '2025-10-27 19:51:34', NULL),
(6, 'POT006', 'Pot 6', 'Handmade clay pot.', 1, 1, '150.00', 10, 'Untitled-6.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(7, 'POT007', 'Pot 7', 'Handmade clay pot.', 1, 1, '150.00', 9, 'Untitled-7.png', '2025-09-23 02:12:42', '2025-10-26 18:40:32', NULL),
(8, 'POT008', 'Pot 8', 'Handmade clay pot.', 1, 1, '150.00', 8, 'Untitled-8.png', '2025-09-23 02:12:42', '2025-12-01 15:32:57', NULL),
(9, 'POT009', 'Pot 9', 'Handmade clay pot.', 1, 1, '150.00', 10, 'Untitled-9.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(10, 'POT010', 'Pot 10', 'Handmade clay pot.', 1, 1, '150.00', 10, 'Untitled-10.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(11, 'POT011', 'Pot 11', 'Handmade clay pot.', 1, 1, '150.00', 7, 'Untitled-11.png', '2025-09-23 02:12:42', '2025-10-26 18:14:25', NULL),
(12, 'POT012', 'Pot 12', 'Handmade clay pot.', 1, 1, '150.00', 10, 'Untitled-12.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(13, 'POT013', 'Pot 13', 'Handmade clay pot.', 1, 1, '150.00', 10, 'Untitled-13.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(14, 'POT014', 'Pot 14', 'Handmade clay pot.', 1, 1, '150.00', 10, 'Untitled-14.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(15, 'POT015', 'Pot 15', 'Handmade clay pot.', 1, 1, '150.00', 10, 'Untitled-15.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(16, 'MAT001', 'Abaca Placemat 1', 'Handwoven abaca placemat.', 2, 2, '100.00', 17, 'Untitled-16.png', '2025-09-23 02:12:42', '2025-10-26 18:24:58', NULL),
(17, 'MAT002', 'Abaca Placemat 2', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-17.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(18, 'MAT003', 'Abaca Placemat 3', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-18.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(19, 'MAT004', 'Abaca Placemat 4', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-19.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(20, 'MAT005', 'Abaca Placemat 5', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-20.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(21, 'MAT006', 'Abaca Placemat 6', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-21.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(22, 'MAT007', 'Abaca Placemat 7', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-22.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(23, 'MAT008', 'Abaca Placemat 8', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-23.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(24, 'MAT009', 'Abaca Placemat 9', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-24.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(25, 'MAT010', 'Abaca Placemat 10', 'Handwoven abaca placemat.', 2, 2, '100.00', 20, 'Untitled-25.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(26, 'SLIP001', 'Abaca Slipper 1', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-26.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(27, 'SLIP002', 'Abaca Slipper 2', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-27.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(28, 'SLIP003', 'Abaca Slipper 3', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-28.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(29, 'SLIP004', 'Abaca Slipper 4', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-29.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(30, 'SLIP005', 'Abaca Slipper 5', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-30.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(31, 'SLIP006', 'Abaca Slipper 6', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-31.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(32, 'SLIP007', 'Abaca Slipper 7', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-32.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(33, 'SLIP008', 'Abaca Slipper 8', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-33.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(34, 'SLIP009', 'Abaca Slipper 9', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-34.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(35, 'SLIP010', 'Abaca Slipper 10', 'Eco-friendly abaca slippers.', 3, 3, '180.00', 15, 'Untitled-35.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(36, 'BAG001', 'Abaca Bag 1', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-36.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(37, 'BAG002', 'Abaca Bag 2', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-37.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(38, 'BAG003', 'Abaca Bag 3', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-38.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(39, 'BAG004', 'Abaca Bag 4', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-39.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(40, 'BAG005', 'Abaca Bag 5', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-40.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(41, 'BAG006', 'Abaca Bag 6', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-41.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(42, 'BAG007', 'Abaca Bag 7', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-42.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(43, 'BAG008', 'Abaca Bag 8', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-43.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(44, 'BAG009', 'Abaca Bag 9', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-44.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(45, 'BAG010', 'Abaca Bag 10', 'Stylish abaca bag.', 4, 4, '350.00', 8, 'Untitled-45.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(46, 'BASK001', 'Abaca Basket 1', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-46.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(47, 'BASK002', 'Abaca Basket 2', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-47.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(48, 'BASK003', 'Abaca Basket 3', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-48.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(49, 'BASK004', 'Abaca Basket 4', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-49.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(50, 'BASK005', 'Abaca Basket 5', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-50.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(51, 'BASK006', 'Abaca Basket 6', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-51.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(52, 'BASK007', 'Abaca Basket 7', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-52.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(53, 'BASK008', 'Abaca Basket 8', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-53.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(54, 'BASK009', 'Abaca Basket 9', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-54.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(55, 'BASK010', 'Abaca Basket 10', 'Durable abaca basket.', 5, 5, '200.00', 15, 'Untitled-55.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(56, 'PILI001', 'Pili Sweet 1', 'Sweet pili nut delicacy.', 6, 6, '120.00', 23, 'Untitled-56.png', '2025-09-23 02:12:42', '2025-09-24 20:44:45', NULL),
(57, 'PILI002', 'Pili Sweet 2', 'Sweet pili nut delicacy.', 6, 6, '120.00', 25, 'Untitled-57.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(58, 'PILI003', 'Pili Sweet 3', 'Sweet pili nut delicacy.', 6, 6, '120.00', 25, 'Untitled-58.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(59, 'PILI004', 'Pili Sweet 4', 'Sweet pili nut delicacy.', 6, 6, '120.00', 25, 'Untitled-59.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(60, 'PILI005', 'Pili Sweet 5', 'Sweet pili nut delicacy.', 6, 6, '120.00', 25, 'Untitled-60.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(61, 'PILI006', 'Pili Sweet 6', 'Sweet pili nut delicacy.', 6, 6, '120.00', 25, 'Untitled-61.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(62, 'PILI007', 'Pili Sweet 7', 'Sweet pili nut delicacy.', 6, 6, '120.00', 25, 'Untitled-62.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(63, 'PILI008', 'Pili Sweet 8', 'Sweet pili nut delicacy.', 6, 6, '120.00', 25, 'Untitled-63.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(64, 'PILI009', 'Pili Sweet 9', 'Sweet pili nut delicacy.', 6, 6, '120.00', 25, 'Untitled-64.png', '2025-09-23 02:12:42', '2025-09-23 02:20:50', NULL),
(65, 'PILI010', 'Pili Sweet 10', 'Sweet pili nut delicacy.', 6, 6, '150.00', 1, 'prod_68ff53c7a4a5b.png', '2025-09-23 02:12:42', '2025-10-27 19:13:11', NULL),
(75, NULL, 'Paso ni Mang Thomas', '', 1, 17, '300.00', 25, 'prod_68ff586d67f1a.png', '2025-10-27 19:33:01', '2025-10-27 19:33:01', NULL),
(76, NULL, 'Paso ni Benj', '', 1, 18, '500.00', 25, 'prod_68ff5885c1a90.png', '2025-10-27 19:33:25', '2025-10-27 19:33:25', NULL),
(80, '', 'Hezekiah', 'sadsadsa', 5, 2, '0.02', 2, 'prod_69006a4fafe5a.png', '2025-10-28 15:01:35', '2025-10-28 15:01:35', 13),
(81, NULL, 'Hezekiah A. Agsunod', '', 4, 1, '122.00', 23, 'prod_6903674011b09.png', '2025-10-30 21:25:20', '2025-10-30 21:25:20', NULL),
(82, 'asdasd', 'Hezekiah', '', 4, 1, '0.05', 23, 'prod_6903687c04e5e.jpg', '2025-10-30 21:30:36', '2025-10-30 21:30:36', 13),
(83, '', 'pot', 'made from the originals', 1, 18, '200.00', 30, 'prod_69074ca7efa12.png', '2025-11-02 20:15:15', '2025-11-02 20:20:55', 14),
(84, '', 'Pili Sweet 10', 'sweeets', 6, 2, '100.00', 5, 'prod_69074c976a39f.png', '2025-11-02 20:20:39', '2025-11-02 20:20:39', 14),
(85, '', 'sdasdasd', 'sadasdasdasdasdsadsadsaddasd', 4, 2, '200.00', 50, 'prod_69082f1a2a180.jpg', '2025-11-03 12:27:06', '2025-11-03 12:27:06', 13),
(88, 'asdasd', 'Exotic Pot', 'Seller', 1, 8, '100.00', 10, 'prod_691ad20bdaa2d.png', '2025-11-17 15:43:07', '2025-11-17 15:46:35', 16),
(90, NULL, 'Josh', 'dasdasdasd', 2, 8, '500.00', 29, 'prod_691ff9676b9a6.png', '2025-11-21 13:32:05', '2025-11-21 13:33:08', NULL),
(91, NULL, 'adasdasdas', 'This is a sample description', 4, 1, '100.00', 2, 'prod_692d3d40bdfca.jpg', '2025-12-01 15:01:20', '2025-12-01 15:02:03', NULL),
(92, NULL, 'adasdasdasd', 'This is a sample descrip', 5, 9, '100.00', -2, 'prod_692d4466d5297.png', '2025-12-01 15:31:50', '2025-12-01 15:36:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT '',
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('customer','admin','seller') DEFAULT 'customer',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`) VALUES
(1, 'Admin', 'User', 'admin@baytisan.local', '$2y$10$uQ6rbVtTcf6gVj6V0uln1uTlaG1nA3i9KO33pVb2xF6gk8PUyZKx2', 'admin', '2025-09-22 22:46:15'),
(2, 'Sample', 'Customer', 'customer@baytisan.local', '$2y$10$K8Y8OZQvK8l1o8G2mQ2x1.pFZ1EXAMPLEHASHX2qz', 'customer', '2025-09-22 22:46:15'),
(3, 'Dagul', 'Bornok', 'dagulbornok@yahoo.com', '$2y$10$DXCg3PxOkwTxgVZDbmbiVOr0pdwE41Kp3eANsiQROzIPOOA541Nci', 'customer', '2025-09-22 22:47:45'),
(4, 'Hezekiah', 'Agsunod', 'hezekiahagsunod1@gmail.com', '$2y$10$srdfXafnL8NuPXH8oNohIukNgaee1zyge3yODVvTdCG2hhDW2QGrS', 'admin', '2025-09-23 01:07:59'),
(5, 'dasdasd', 'asdasd', 'sdasdas@gmail.com', '$2y$10$cRyESXpNEKk7im49V5BWo.Pv2TWM1vtB9WyFGYh6.KBLqBjOjt.8C', 'customer', '2025-09-24 14:35:49'),
(6, 'Carlits', '', 'cvmier.12@gmail.com', '$2y$10$WgrhAVHSYXYZZ4DU1bVQ5u/1cXKY60VJD9x/ODcidRWvsauZnyah2', 'admin', '2025-10-26 17:55:13'),
(7, 'carlitsCus', '', 'carlitscus@gmail.com', '$2y$10$u3kLEeo094RdYUJ.1QmLH.702s2uTq/Wo205mNRUFprEgmtOJ3Z1S', 'customer', '2025-10-26 18:13:50'),
(8, 'carlitsAdm', '', 'carlitsadm@gmail.com', '$2y$10$lh3XRDfl4GseVfp2oDsQr.46/Br7O8z7vi5kbl6OwyW1tj3mORX1O', 'admin', '2025-10-26 18:16:23'),
(9, 'Zab', 'Diel', 'qwerty@gmail.com', '$2y$10$jIYfsXx93mz47dpAJmOpHOhdYQE0XBp6hYipbA.1iu6w/ubEvUDSO', 'customer', '2025-10-27 20:20:37'),
(10, 'asdfg', 'hjkl', 'asd@gmail.com', '$2y$10$9vRKkKv6VwXvntaVsTJBu./TpsODP9ph9xvOSBNqDljPPpUPOHbJW', 'admin', '2025-10-27 20:22:28'),
(13, 'Raymund', 'Tiglao', 'reytiglao@gmail.com', '$2y$10$KJ7dTq2K9sNPPLTDQ1.m4ut03RwC877wlFj8gsqupdEcgy4wrtpUm', 'seller', '2025-10-28 08:42:12'),
(14, 'Carl', 'Mier', 'carlitsell@gmail.com', '$2y$10$AHrUO72r1yT.G1C4nP9tZukoqjhArEgXr85DMR9KJZPtz8e7aiJ8K', 'seller', '2025-11-02 20:12:54'),
(15, 'Carlits', 'Mier', 'carlitssell', '$2y$10$BjRg1t8V8kaJpDD.C8u7/e1yk0hqfqOvhDsiKb3jSmPX/yYKkcUlW', 'seller', '2025-11-17 15:35:38'),
(16, 'Seller', 'Two', 'twoseller@gmail.com', '$2y$10$N2eEhbPNhI9VJh7PLCoDjOAvw9ecU2Dhhq126m7WpJFuMv05eY/Ky', 'seller', '2025-11-17 15:38:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `order_tracking`
--
ALTER TABLE `order_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_products_category` (`category_id`),
  ADD KEY `idx_products_origin` (`origin_location_id`),
  ADD KEY `fk_seller` (`seller_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `order_tracking`
--
ALTER TABLE `order_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `order_tracking`
--
ALTER TABLE `order_tracking`
  ADD CONSTRAINT `order_tracking_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_seller` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`origin_location_id`) REFERENCES `locations` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
