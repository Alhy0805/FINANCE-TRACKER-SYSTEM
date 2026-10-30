-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: finance_db
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `account_name` varchar(100) NOT NULL,
  `account_type` enum('Cash','Bank','E-Wallet','Other') NOT NULL,
  `initial_balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`account_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,1,'Alex GCash','E-Wallet',10000.00,'2026-10-29 11:48:09'),(2,2,'Jamie Cash Wallet','Cash',5000.00,'2026-10-29 11:48:09'),(3,3,'Admin Wallet','Cash',10000.00,'2026-10-30 02:26:46');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `bill_name` varchar(150) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `due_date` date NOT NULL,
  `status` enum('Pending','Paid','Overdue','Cancelled') NOT NULL DEFAULT 'Pending',
  `paid_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`bill_id`),
  KEY `user_id` (`user_id`),
  KEY `account_id` (`account_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `bills_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE SET NULL,
  CONSTRAINT `bills_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (`amount` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,1,1,2,'Monthly Groceries',1200.00,'2026-10-30','Pending',NULL,'2026-10-29 11:48:11'),(2,2,2,2,'Food Expenses',800.00,'2026-10-31','Pending',NULL,'2026-10-29 11:48:11'),(3,3,NULL,NULL,'Electricity Bill',1800.00,'2026-11-05','Pending',NULL,'2026-10-30 03:29:55'),(4,3,NULL,NULL,'Internet Bill',1500.00,'2026-11-10','Pending',NULL,'2026-10-30 03:29:55'),(5,3,NULL,NULL,'Water Bill',450.00,'2026-10-25','Paid',NULL,'2026-10-30 03:29:55'),(6,3,NULL,NULL,'Mobile Subscription',599.00,'2026-11-15','Pending',NULL,'2026-10-30 03:29:55'),(7,3,NULL,NULL,'Streaming Subscription',299.00,'2026-11-20','Pending',NULL,'2026-10-30 03:29:55');
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budgets`
--

DROP TABLE IF EXISTS `budgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `budgets` (
  `budget_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `budget_name` varchar(100) NOT NULL,
  `budget_amount` decimal(12,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`budget_id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `budgets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `budgets_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`budget_amount` > 0),
  CONSTRAINT `CONSTRAINT_2` CHECK (`end_date` >= `start_date`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budgets`
--

LOCK TABLES `budgets` WRITE;
/*!40000 ALTER TABLE `budgets` DISABLE KEYS */;
INSERT INTO `budgets` VALUES (1,1,2,'October Food Budget',3000.00,'2026-10-01','2026-10-31','2026-10-29 11:48:09'),(2,2,2,'October Food Budget',2000.00,'2026-10-01','2026-10-31','2026-10-29 11:48:09'),(3,3,4,'Monthly Food Budget',5000.00,'2026-10-01','2026-10-31','2026-10-30 03:29:55'),(4,3,6,'Transportation Budget',2000.00,'2026-10-01','2026-10-31','2026-10-30 03:29:55'),(5,3,7,'Entertainment Budget',1500.00,'2026-10-01','2026-10-31','2026-10-30 03:29:55'),(6,3,10,'Utilities Budget',3000.00,'2026-10-01','2026-10-31','2026-10-30 03:29:55');
/*!40000 ALTER TABLE `budgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `category_name` varchar(100) NOT NULL,
  `category_type` enum('Income','Expense') NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,NULL,'Salary','Income','wallet','#16A34A','2026-10-29 11:48:09'),(2,NULL,'Food','Expense','utensils','#F59E0B','2026-10-29 11:48:09'),(3,3,'Salary','Income','wallet','#16A34A','2026-10-30 02:26:46'),(4,3,'Food','Expense','utensils','#F59E0B','2026-10-30 02:26:47'),(5,3,'Food','Expense','restaurant','#FF5733','2026-10-30 03:29:55'),(6,3,'Transportation','Expense','car','#3498DB','2026-10-30 03:29:55'),(7,3,'Entertainment','Expense','gamepad','#9B59B6','2026-10-30 03:29:55'),(8,3,'Salary','Income','wallet','#2ECC71','2026-10-30 03:29:55'),(9,3,'Freelance','Income','laptop','#F1C40F','2026-10-30 03:29:55'),(10,3,'Utilities','Expense','bolt','#E67E22','2026-10-30 03:29:55'),(11,3,'Healthcare','Expense','heart','#E84393','2026-10-30 03:29:55');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goal_contributions`
--

DROP TABLE IF EXISTS `goal_contributions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goal_contributions` (
  `contribution_id` int(11) NOT NULL AUTO_INCREMENT,
  `goal_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `contribution_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`contribution_id`),
  KEY `goal_id` (`goal_id`),
  CONSTRAINT `goal_contributions_ibfk_1` FOREIGN KEY (`goal_id`) REFERENCES `savings_goals` (`goal_id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`amount` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goal_contributions`
--

LOCK TABLES `goal_contributions` WRITE;
/*!40000 ALTER TABLE `goal_contributions` DISABLE KEYS */;
INSERT INTO `goal_contributions` VALUES (1,1,2000.00,'2026-10-25','First laptop savings'),(2,2,1000.00,'2026-10-26','Emergency fund deposit'),(3,3,1000.00,'2026-10-20','Monthly savings contribution'),(4,4,2000.00,'2026-10-22','Laptop savings'),(5,5,500.00,'2026-10-25','Travel savings'),(6,6,1500.00,'2026-10-28','Phone savings');
/*!40000 ALTER TABLE `goal_contributions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `notification_type` enum('Budget Alert','Savings Update','Bill Reminder','System') NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,'Budget Reminder','You have used part of your October food budget.','Budget Alert',0,'2026-10-29 11:48:09'),(2,2,'Savings Update','Your emergency fund savings have been updated.','Savings Update',0,'2026-10-29 11:48:09'),(3,3,'Upcoming Bill','Your electricity bill is due soon.','Bill Reminder',0,'2026-10-30 03:29:56'),(4,3,'Budget Alert','You have used a portion of your food budget.','Budget Alert',0,'2026-10-30 03:29:56'),(5,3,'Savings Update','Keep saving towards your emergency fund!','Savings Update',0,'2026-10-30 03:29:56'),(6,3,'System Update','Your finance dashboard is ready.','System',1,'2026-10-30 03:29:56');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurring_transactions`
--

DROP TABLE IF EXISTS `recurring_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurring_transactions` (
  `recurring_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `transaction_type` enum('Income','Expense') NOT NULL,
  `description` varchar(255) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `frequency` enum('Daily','Weekly','Monthly','Yearly') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `next_due_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recurring_id`),
  KEY `user_id` (`user_id`),
  KEY `account_id` (`account_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `recurring_transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `recurring_transactions_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  CONSTRAINT `recurring_transactions_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (`amount` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurring_transactions`
--

LOCK TABLES `recurring_transactions` WRITE;
/*!40000 ALTER TABLE `recurring_transactions` DISABLE KEYS */;
INSERT INTO `recurring_transactions` VALUES (1,1,1,1,'Income','Monthly Salary',15000.00,'Monthly','2026-10-01',NULL,'2026-11-01',1,'2026-10-29 11:48:09'),(2,2,2,2,'Expense','Weekly Food Allowance',500.00,'Weekly','2026-10-01',NULL,'2026-11-02',1,'2026-10-29 11:48:09'),(3,3,3,3,'Income','Monthly Salary',15000.00,'Monthly','2026-10-01',NULL,'2026-11-01',1,'2026-10-30 03:30:15'),(4,3,3,4,'Expense','Monthly Grocery Allowance',3000.00,'Monthly','2026-10-01',NULL,'2026-11-01',1,'2026-10-30 03:30:15'),(5,3,3,10,'Expense','Monthly Internet Payment',1500.00,'Monthly','2026-10-01',NULL,'2026-11-01',1,'2026-10-30 03:30:15');
/*!40000 ALTER TABLE `recurring_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_goals`
--

DROP TABLE IF EXISTS `savings_goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savings_goals` (
  `goal_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `goal_name` varchar(100) NOT NULL,
  `target_amount` decimal(12,2) NOT NULL,
  `target_date` date DEFAULT NULL,
  `status` enum('Active','Completed','Cancelled') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`goal_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `savings_goals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`target_amount` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savings_goals`
--

LOCK TABLES `savings_goals` WRITE;
/*!40000 ALTER TABLE `savings_goals` DISABLE KEYS */;
INSERT INTO `savings_goals` VALUES (1,1,'New Laptop',40000.00,'2027-06-30','Active','2026-10-29 11:48:09'),(2,2,'Emergency Fund',20000.00,'2027-12-31','Active','2026-10-29 11:48:09'),(3,3,'Emergency Fund',20000.00,'2027-03-30','Active','2026-10-30 03:29:55'),(4,3,'New Laptop',45000.00,'2027-06-30','Active','2026-10-30 03:29:55'),(5,3,'Travel Fund',15000.00,'2027-12-30','Active','2026-10-30 03:29:55'),(6,3,'New Phone',25000.00,'2027-05-30','Active','2026-10-30 03:29:55');
/*!40000 ALTER TABLE `savings_goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `transaction_type` enum('Income','Expense','Transfer In','Transfer Out') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `description` varchar(255) NOT NULL,
  `transaction_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`transaction_id`),
  KEY `account_id` (`account_id`),
  KEY `category_id` (`category_id`),
  KEY `idx_transactions_date` (`user_id`,`transaction_date`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (`amount` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,1,2,'Expense',250.00,'Lunch','2026-10-28','Lunch at school','2026-10-29 11:48:09'),(2,2,2,1,'Income',1500.00,'Salary','2026-10-28','Part-time earnings','2026-10-29 11:48:09'),(3,3,3,3,'Income',15000.00,'Monthly Salary','2026-10-01','Monthly salary payment','2026-10-30 03:30:45'),(4,3,3,9,'Income',5000.00,'Freelance Project','2026-10-10','Website development project','2026-10-30 03:30:45'),(5,3,3,4,'Expense',350.00,'Lunch','2026-10-15','Lunch with friends','2026-10-30 03:30:45'),(6,3,3,6,'Expense',150.00,'Transportation','2026-10-16','Daily transportation','2026-10-30 03:30:45'),(7,3,3,7,'Expense',500.00,'Movie Tickets','2026-10-18','Weekend entertainment','2026-10-30 03:30:45'),(8,3,3,10,'Expense',1800.00,'Electricity Payment','2026-10-20','Monthly electricity bill','2026-10-30 03:30:45'),(9,3,3,11,'Expense',750.00,'Medicine','2026-10-22','Healthcare expenses','2026-10-30 03:30:45'),(10,3,3,4,'Expense',1200.00,'Grocery Shopping','2026-10-25','Weekly groceries','2026-10-30 03:30:45');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `currency` char(3) NOT NULL DEFAULT 'PHP',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `role` enum('admin','user') DEFAULT 'user',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alex Santos','alex@example.com','DEMO_HASH_ALEX',NULL,'PHP','2026-10-29 11:48:09','2026-10-29 11:48:09','user'),(2,'Jamie Reyes','jamie@example.com','DEMO_HASH_JAMIE',NULL,'PHP','2026-10-29 11:48:09','2026-10-29 11:48:09','user'),(3,'Admin','admin@gmail.com','admin123',NULL,'PHP','2026-10-30 02:26:38','2026-10-30 02:30:36','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-30 13:05:59
