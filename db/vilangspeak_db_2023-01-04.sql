# ************************************************************
# Sequel Ace SQL dump
# Version 20044
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.31)
# Database: vilangspeak_db
# Generation Time: 2023-01-03 18:59:17 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `username` varchar(255) NOT NULL,
  `role` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;

INSERT INTO `account` (`id`, `name`, `birthday`, `username`, `role`)
VALUES
	(1,'Tuan','2001-02-28','nbtt',0),
	(2,'Toai Tran','2001-12-30','toaitran2001',1);

/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table achievement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `achievement`;

CREATE TABLE `achievement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `achievement` WRITE;
/*!40000 ALTER TABLE `achievement` DISABLE KEYS */;

INSERT INTO `achievement` (`id`, `name`, `image`)
VALUES
	(1,'Get 7 day series','http://xxxxx/upload/image/achievement-7day.jpg'),
	(2,'Get full points for 5 tests','http://xxxxx/upload/image/achievement-full-5-point.jpg'),
	(3,'Achievement 3',''),
	(4,'Achievement 4','');

/*!40000 ALTER TABLE `achievement` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table achievement_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `achievement_log`;

CREATE TABLE `achievement_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL,
  `accountId` int DEFAULT NULL,
  `achievementId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_394ec34aa9e355ef3ed68332225` (`accountId`),
  KEY `FK_ce08fe56d0bc64dd2f8a4c28561` (`achievementId`),
  CONSTRAINT `FK_394ec34aa9e355ef3ed68332225` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_ce08fe56d0bc64dd2f8a4c28561` FOREIGN KEY (`achievementId`) REFERENCES `achievement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `achievement_log` WRITE;
/*!40000 ALTER TABLE `achievement_log` DISABLE KEYS */;

INSERT INTO `achievement_log` (`id`, `date`, `accountId`, `achievementId`)
VALUES
	(1,'2023-01-01 23:49:17',1,1),
	(2,'2023-01-01 23:49:45',1,2),
	(3,'2023-01-04 00:11:41',1,3),
	(4,'2023-01-04 00:11:56',2,3),
	(5,'2023-01-04 00:12:04',2,1),
	(6,'2023-01-04 00:12:35',2,4);

/*!40000 ALTER TABLE `achievement_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table card
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card`;

CREATE TABLE `card` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL,
  `audioUrl` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `translation` varchar(255) NOT NULL,
  `lessonId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cfa0c24059e7685221fdfa6829a` (`lessonId`),
  CONSTRAINT `FK_cfa0c24059e7685221fdfa6829a` FOREIGN KEY (`lessonId`) REFERENCES `lesson` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;

INSERT INTO `card` (`id`, `type`, `audioUrl`, `content`, `translation`, `lessonId`)
VALUES
	(1,0,'','tôi','I, me',1),
	(2,0,'','bạn','you, friend',1),
	(3,0,'','xin chào','hello, hi',1),
	(4,0,'','mọi người','everyone',1),
	(5,1,'','xin chào mọi người','hello everyone',1),
	(6,1,'','chào bạn','hello, hi (same age)',1),
	(7,0,'','là','to be',1),
	(8,0,'','tên','name',1),
	(9,1,'','tên tôi là An','my name is An',1),
	(10,0,'','đến','come, arrive',1),
	(11,0,'','Hà Nội','Hanoi',1),
	(12,1,'','tôi đến từ Hà Nội','I come from Ha Noi',1),
	(13,0,'','đang','to be doing something',1),
	(14,0,'','học','study, learn',1),
	(15,0,'','Tiếng Việt','Vietnamese',1),
	(16,1,'','tôi đang học Tiếng Việt','I am learning Vietnamese',1),
	(17,0,'','gì','what',1),
	(18,1,'','bạn tên gì','what is your name',1),
	(19,0,'','đâu','where',1),
	(20,1,'','bạn đến từ đâu','where are you from',1);

/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table card_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card_item`;

CREATE TABLE `card_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL,
  `order` tinyint NOT NULL,
  `content` varchar(255) NOT NULL,
  `cardId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_9aad4342b4d6d1cbe0604bbd284` (`cardId`),
  CONSTRAINT `FK_9aad4342b4d6d1cbe0604bbd284` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `card_item` WRITE;
/*!40000 ALTER TABLE `card_item` DISABLE KEYS */;

INSERT INTO `card_item` (`id`, `type`, `order`, `content`, `cardId`)
VALUES
	(1,0,0,'Examples',1),
	(2,1,1,'*Tôi* là một bác sĩ.\n*I* am a doctor.\n\nNgười phụ trách là *tôi*.\nThe person in charge is *me*.',1),
	(3,0,0,'Examples',2),
	(4,1,1,'*Bạn* là ai?\nWho are *you*?\n\nAnh ấy là *bạn* của tôi.\nHe is my *friend*.',2),
	(5,0,2,'Pronunciation tips',2),
	(6,0,3,'Vietnamese have 6 *tones*. Please pay attention to the tone when you pronounce the word. This word have *Heavy Tone* (Thanh Nặng), which is marked as a dot under the word.',2),
	(7,0,0,'Usage',3),
	(8,1,1,'This word can be use as a sentence to greet people formally.\nIt can be use as \"*chào*\", but it can have different meaning depending on context.',3),
	(9,0,2,'Examples',3),
	(10,1,3,'*Xin chào* mọi người.\n*Hello* everyone.\n\n*Chào* mọi người, em vừa đến đây.\n*Hello* everyone, I have just came here.\n\n*Chào* anh, giờ em về nhà.\n*Good bye*, I am going home.',3),
	(11,0,4,'Pronunciation tips',3),
	(12,1,5,'*xin* has Mid-Level Tone (Thanh Ngang) (no mark) and *chào* have Low Falling Tone (Thanh Huyền) (mark as *`* above the word)',3);

/*!40000 ALTER TABLE `card_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;

INSERT INTO `category` (`id`, `name`, `image`)
VALUES
	(1,'Greeting','img/g.png'),
	(2,'Vehicles','img/c2.png'),
	(3,'Animals',''),
	(4,'Category 4',''),
	(5,'Category 5',''),
	(6,'Category 6',''),
	(7,'Category 7','');

/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table lesson
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lesson`;

CREATE TABLE `lesson` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `visible` tinyint NOT NULL DEFAULT '1',
  `categoryId` int DEFAULT NULL,
  `linkedTestId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `REL_676b734c9ec39a5099a506a893` (`linkedTestId`),
  KEY `FK_2c0dc097e2efa8f724904826eef` (`categoryId`),
  CONSTRAINT `FK_2c0dc097e2efa8f724904826eef` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_676b734c9ec39a5099a506a893d` FOREIGN KEY (`linkedTestId`) REFERENCES `testx` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `lesson` WRITE;
/*!40000 ALTER TABLE `lesson` DISABLE KEYS */;

INSERT INTO `lesson` (`id`, `name`, `visible`, `categoryId`, `linkedTestId`)
VALUES
	(1,'Get to know',1,1,1),
	(2,'Vehicles',1,2,2),
	(3,'Lesson 3',1,3,3),
	(4,'Lesson 4',1,4,4),
	(5,'Lesson 5',1,5,5),
	(6,'Lesson 6',1,6,6),
	(7,'Lesson 7',1,7,7);

/*!40000 ALTER TABLE `lesson` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table lesson_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lesson_log`;

CREATE TABLE `lesson_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accountId` int DEFAULT NULL,
  `lessonId` int DEFAULT NULL,
  `date` timestamp NOT NULL,
  `progress` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_aac90ad3b9d66483bdcb9db9d87` (`accountId`),
  KEY `FK_2a00caddfdf1cf3f2236f6c82f5` (`lessonId`),
  CONSTRAINT `FK_2a00caddfdf1cf3f2236f6c82f5` FOREIGN KEY (`lessonId`) REFERENCES `lesson` (`id`),
  CONSTRAINT `FK_aac90ad3b9d66483bdcb9db9d87` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `lesson_log` WRITE;
/*!40000 ALTER TABLE `lesson_log` DISABLE KEYS */;

INSERT INTO `lesson_log` (`id`, `accountId`, `lessonId`, `date`, `progress`)
VALUES
	(1,1,1,'2023-01-02 20:49:01',100),
	(2,1,2,'2023-01-02 20:56:21',50),
	(3,1,3,'2023-01-02 20:56:32',50);

/*!40000 ALTER TABLE `lesson_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table testx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `testx`;

CREATE TABLE `testx` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `visible` tinyint NOT NULL DEFAULT '1',
  `categoryId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_9be8d7edfbce04d75e3a69b7421` (`categoryId`),
  CONSTRAINT `FK_9be8d7edfbce04d75e3a69b7421` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `testx` WRITE;
/*!40000 ALTER TABLE `testx` DISABLE KEYS */;

INSERT INTO `testx` (`id`, `name`, `visible`, `categoryId`)
VALUES
	(1,'Hello',1,1),
	(2,'Test 2',1,2),
	(3,'Test 3',1,3),
	(4,'Test 4',1,4),
	(5,'Test 5',1,5),
	(6,'Test 6',1,6),
	(7,'Test 7',1,7);

/*!40000 ALTER TABLE `testx` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
