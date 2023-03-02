# ************************************************************
# Sequel Ace SQL dump
# Version 20046
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.31)
# Database: vilangspeak_db
# Generation Time: 2023-03-02 19:13:04 +0000
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
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;

INSERT INTO `account` (`id`, `name`, `birthday`, `username`, `role`, `password`)
VALUES
	(1,'Tuan','2001-02-28','nbtt',0,'123456'),
	(2,'Toai Tran','2001-12-30','toaitran2001',1,'124356');

/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table account_login
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_login`;

CREATE TABLE `account_login` (
  `accountId` int NOT NULL,
  `role` tinyint NOT NULL,
  `date` timestamp NOT NULL,
  PRIMARY KEY (`accountId`,`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `account_login` WRITE;
/*!40000 ALTER TABLE `account_login` DISABLE KEYS */;

INSERT INTO `account_login` (`accountId`, `role`, `date`)
VALUES
	(1,1,'2023-03-03 01:58:17'),
	(2,1,'2023-02-20 10:00:42');

/*!40000 ALTER TABLE `account_login` ENABLE KEYS */;
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
	(1,'Get 7 day series','/public/image/achievement-7-days.png'),
	(2,'Get full points for 5 tests','/public/image/achievement-full-5-tests.png'),
	(3,'Achievement 3',''),
	(4,'Achievement 4',''),
	(5,'Achievement 5',''),
	(6,'Achievement 6',''),
	(7,'Achievement 7',''),
	(8,'Achievement 8',''),
	(9,'Achievement 9',''),
	(10,'Achievement 10','');

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
	(6,'2023-01-04 00:12:35',2,4),
	(7,'2023-01-07 17:52:41',2,5),
	(8,'2023-01-07 17:52:55',1,6),
	(9,'2023-01-07 17:52:59',1,7),
	(10,'2023-01-07 17:53:34',1,8),
	(11,'2023-01-07 17:54:11',2,9),
	(12,'2023-01-07 17:54:14',1,10);

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
	(1,0,'/public/audio/toi.wav','tôi','I, me',1),
	(2,0,'/public/audio/ban.wav','bạn','you, friend',1),
	(3,0,'/public/audio/xinchao.wav','xin chào','hello, hi',1),
	(4,0,'/public/audio/moinguoi.wav','mọi người','everyone',1),
	(5,1,'/public/audio/xinchaomoinguoi.wav','xin chào mọi người','hello everyone',1),
	(6,1,'/public/audio/chaoban.wav','chào bạn','hello, hi (same age)',1),
	(7,0,'/public/audio/la.wav','là','to be',1),
	(8,0,'/public/audio/ten.wav','tên','name',1),
	(9,1,'/public/audio/toitenlaan.wav','tôi tên là An','my name is An',1),
	(10,0,'/public/audio/den.wav','đến','come, arrive',1),
	(11,0,'/public/audio/hanoi.wav','Hà Nội','Hanoi',1),
	(12,1,'/public/audio/toidentuhanoi.wav','tôi đến từ Hà Nội','I come from Ha Noi',1),
	(13,0,'/public/audio/dang.wav','đang','to be doing something',1),
	(14,0,'/public/audio/hoc.wav','học','study, learn',1),
	(15,0,'/public/audio/tiengviet.wav','Tiếng Việt','Vietnamese',1),
	(16,1,'/public/audio/toidanghoctiengviet.wav','tôi đang học Tiếng Việt','I am learning Vietnamese',1),
	(17,0,'/public/audio/gi.wav','gì','what',1),
	(18,1,'/public/audio/bantengi.wav','bạn tên gì','what is your name',1),
	(19,0,'/public/audio/dau.wav','đâu','where',1),
	(20,1,'/public/audio/bandentudau.wav','bạn đến từ đâu','where are you from',1);

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
	(6,1,3,'This word have *Heavy Tone* (Thanh Nặng), which is marked as a dot under the word.',2),
	(7,0,0,'Usage',3),
	(8,1,1,'This word can be use as a sentence to greet people formally.',3),
	(9,0,2,'Examples',3),
	(10,1,3,'*Xin chào* mọi người.\n*Hello* everyone.\n\n*Chào* mọi người, em vừa đến đây.\n*Hello* everyone, I have just came here.',3),
	(13,1,0,'*mọi* means \"all\", \"every\".\n\"người\" means \"man\", \"person\", \"people\", \"individual\"',4),
	(14,0,0,'Examples',7),
	(15,1,1,'Thời gian *là* tiền bạc.\nTime *is* money.',7),
	(16,0,0,'Pronounciation tips',10),
	(17,1,1,'This word has High Rising Tone (Thanh Sắc). It is mark as */* above the word.',10),
	(18,1,0,'Hanoi is the capital of Viet Nam',11),
	(19,1,0,'In this context, *từ* means *from*',12),
	(20,0,0,'Examples',13),
	(21,1,1,'Tôi *đang* ra ngoài.\nI am going out.\n\nCô ấy *đang* bận.\nShe is busy now.',13),
	(22,1,0,'Wonderful! You are learning Vietnamese.',15),
	(23,1,0,'*gì* means *what* but the order of it in the sentence is different to *what*',18),
	(24,1,0,'*đâu* means *where* but the order of it in the sentence is different to *where*',20);

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
	(1,'Greeting','/public/image/category-greeting.png'),
	(2,'Vehicles','/public/image/category-vehicles.png'),
	(3,'Animals','/public/image/category-animals.png'),
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
	(1,1,1,'2023-01-07 10:57:02',50),
	(2,1,2,'2023-01-07 10:34:06',100),
	(3,1,3,'2023-01-02 20:56:32',50);

/*!40000 ALTER TABLE `lesson_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table test_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `test_log`;

CREATE TABLE `test_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL,
  `times` int NOT NULL,
  `scoreHighest` int NOT NULL,
  `scoreLowest` int NOT NULL,
  `scoreSum` int NOT NULL,
  `accountId` int DEFAULT NULL,
  `testId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_0351b75994b61c0333b22dbac03` (`accountId`),
  KEY `FK_89cb32eeeeb4359f3cb3e41692a` (`testId`),
  CONSTRAINT `FK_0351b75994b61c0333b22dbac03` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_89cb32eeeeb4359f3cb3e41692a` FOREIGN KEY (`testId`) REFERENCES `testx` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `test_log` WRITE;
/*!40000 ALTER TABLE `test_log` DISABLE KEYS */;

INSERT INTO `test_log` (`id`, `date`, `times`, `scoreHighest`, `scoreLowest`, `scoreSum`, `accountId`, `testId`)
VALUES
	(3,'2023-01-07 11:10:53',5,10,8,45,1,2),
	(4,'2023-01-07 11:12:57',3,9,8,26,1,1);

/*!40000 ALTER TABLE `test_log` ENABLE KEYS */;
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
