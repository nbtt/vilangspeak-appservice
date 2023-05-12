# ************************************************************
# Sequel Ace SQL dump
# Version 20046
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.32)
# Database: vilangspeak_db
# Generation Time: 2023-05-12 03:47:50 +0000
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_41dfcb70af895ddf9a53094515` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;

INSERT INTO `account` (`id`, `name`, `birthday`, `username`, `role`, `password`)
VALUES
	(1,'Tuan Trinh','2001-02-28','nbtt',0,'$2b$10$ncQvABUT5To64wgUQ6i5ZuSSXtzjQIBoyJjzSyLT7xqXoELueR0a.'),
	(2,'Toai Tran HCt','2001-12-30','toaitran2001',1,'$2b$10$PZgptBIGO47nFJQt1dBBheuFtrLta42gmtG0qt/c9DGq7/d./quna');

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
	(1,1,'2023-04-17 18:38:23'),
	(2,1,'2023-05-12 10:47:23'),
	(30,1,'2023-04-17 17:44:18'),
	(36,1,'2023-04-17 17:35:27');

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
  PRIMARY KEY (`id`)
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
  PRIMARY KEY (`id`)
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
	(20,1,'/public/audio/bandentudau.wav','bạn đến từ đâu','where are you from',1),
	(21,0,'public/audio/chao.wav','Chào','',8),
	(22,0,'public/audio/ban.wav','Bạn','',8),
	(23,0,'public/audio/xin_chao.wav','Xin chào','',8),
	(24,0,'public/audio/rat_vui_duoc_gap.wav','rất vui được gặp','',8),
	(25,0,'public/audio/rat_vui_duoc_lam_quen_voi.wav','rất vui được làm quen với','',8),
	(26,0,'public/audio/tam_biet.wav','Tạm biệt','',8),
	(27,0,'public/audio/toi_ten_la.wav','Tôi tên là','',8),
	(28,0,'public/audio/cai_gi.wav','Cái gì','',8),
	(29,0,'public/audio/ban_ten_gi.wav','Bạn tên gì?','',8),
	(30,0,'public/audio/xin_loi.wav','Xin lỗi','',8),
	(31,0,'public/audio/ban_la_nguoi_nuoc_nao.wav','Bạn là người nước nào?','',8),
	(32,0,'public/audio/toi_la_nguoi_viet_nam.wav','Tôi là người Việt Nam','',8),
	(33,0,'','Tôi đến từ Nhật Bản','',8),
	(34,0,'public/audio/một.wav','Một','',9),
	(35,0,'public/audio/hai.wav','Hai','',9),
	(36,0,'public/audio/ba.wav','Ba','',9),
	(37,0,'public/audio/bon.wav','Bốn','',9),
	(38,0,'public/audio/nam.wav','Năm','',9),
	(39,0,'public/audio/sau.wav','Sáu','',9),
	(40,0,'public/audio/bay.wav','Bảy','',9),
	(41,0,'public/audio/tam.wav','Tám','',9),
	(42,0,'public/audio/chin.wav','Chín','',9),
	(43,0,'public/audio/muoi.wav','Mười','',9),
	(44,0,'public/audio/muoi_một.wav','Mười một','',9),
	(45,0,'public/audio/muoi_hai.wav','Mười hai','',9),
	(46,0,'public/audio/hai_muoi.wav','Hai mươi','',9),
	(47,0,'public/audio/hai_muoi_bay.wav','Hai mươi bảy','',9),
	(97,0,'','Năm trăm','',9),
	(98,0,'','Ba nghìn','',9),
	(99,0,'','Một triệu','',9),
	(100,0,'','Hai tỉ','',9),
	(101,0,'','Hai trăm rưỡi','',9),
	(102,0,'','Bốn trăm linh bốn','',9),
	(103,0,'public/audio/thich.wav','Thích','',10),
	(104,0,'public/audio/mau.wav','màu','',10),
	(105,0,'public/audio/do.wav','đỏ','',10),
	(106,0,'public/audio/xanh_duong.wav','xanh dương','',10),
	(107,0,'public/audio/xanh_la_cay.wav','xanh lá cây','',10),
	(108,0,'public/audio/hong.wav','hồng','',10),
	(109,0,'public/audio/tim.wav','tím','',10),
	(110,0,'public/audio/xam.wav','xám','',10),
	(111,0,'public/audio/den.wav','đen','',10),
	(112,0,'public/audio/trang.wav','trắng','',10),
	(113,0,'public/audio/cam.wav','cam','',10),
	(114,0,'public/audio/vang.wav','vàng','',10),
	(115,0,'public/audio/toi.wav','Tôi','',11),
	(116,0,'public/audio/ong.wav','Ông','',11),
	(117,0,'public/audio/ba_2.wav','Bà','',11),
	(118,0,'public/audio/bac.wav','Bác','',11),
	(119,0,'public/audio/chu.wav','Chú','',11),
	(120,0,'public/audio/co.wav','Cô','',11),
	(121,0,'public/audio/anh.wav','Anh','',11),
	(122,0,'public/audio/chi.wav','Chị','',11),
	(123,0,'public/audio/em.wav','Em','',11),
	(124,0,'','Chú ấy','',11),
	(125,0,'','Rất vui được gặp bà','',11),
	(126,0,'','Chào cô','',11),
	(127,0,'public/audio/o_dau.wav','Ở đâu','',12),
	(128,0,'public/audio/lam.wav','làm','',12),
	(129,0,'public/audio/cong_viec.wav','công việc','',12),
	(130,0,'public/audio/lam_viec.wav','làm việc','',12),
	(131,0,'public/audio/giao_vien.wav','giáo viên','',12),
	(132,0,'public/audio/bac_si.wav','bác sĩ','',12),
	(133,0,'public/audio/ca_si.wav','ca sĩ','',12),
	(134,0,'public/audio/sinh_vien.wav','sinh viên','',12),
	(135,0,'public/audio/lai_xe.wav','lái xe','',12),
	(136,0,'public/audio/hoa_si.wav','họa sĩ','',12),
	(137,0,'public/audio/ki_su.wav','kĩ sư','',12),
	(138,0,'public/audio/ban_khoe_khong.wav','Bạn khỏe không','',13),
	(139,0,'public/audio/khoe.wav','Khỏe','',13),
	(140,0,'public/audio/cam_on.wav','Cảm ơn','',13),
	(141,0,'public/audio/khong.wav','Không','',13),
	(142,0,'public/audio/day_la.wav','Đây là','',13),
	(143,0,'public/audio/ban_cua_toi.wav','bạn của tôi','',13),
	(144,0,'public/audio/nghe.wav','nghề','',13),
	(145,0,'public/audio/ban_lam_nghe_gi.wav','bạn làm nghề gì?','',13),
	(146,0,'public/audio/cong_viec_cua_ban_la_gi.wav','công việc của bạn là gì?','',13),
	(147,0,'public/audio/toi_la.wav','Tôi là','',13),
	(148,0,'public/audio/toi_lam.wav','Tôi làm','',13),
	(149,0,'public/audio/toi_lam_bac_si.wav','Tôi làm bác sĩ','',13),
	(150,0,'public/audio/tuoi.wav','Tuổi','',14),
	(151,0,'public/audio/so_thich.wav','Sở thích','',14),
	(152,0,'public/audio/doc_sach.wav','Đọc sách','',14),
	(153,0,'public/audio/nghe_nhac.wav','Nghe nhạc','',14),
	(154,0,'public/audio/ve_tranh.wav','Vẽ tranh','',14),
	(155,0,'public/audio/ca_hat.wav','Ca hát','',14),
	(156,0,'public/audio/bao_nhieu.wav','Bao nhiêu','',14),
	(157,0,'public/audio/ban_thich_mau_gi.wav','Bạn thích màu gì?','',14),
	(158,0,'public/audio/so_thich_cua_ban_la_gi.wav','Sở thích của bạn là gì?','',14),
	(159,0,'','Anh bao nhiêu tuổi?','',14),
	(160,0,'','Cô ấy hai mươi ba tuổi','',14),
	(161,0,'public/audio/cam_thay.wav','Cảm thấy','',15),
	(162,0,'public/audio/met.wav','Mệt','',15),
	(163,0,'public/audio/vui_ve.wav','Vui vẻ','',15),
	(164,0,'public/audio/hanh_phuc.wav','hạnh phúc','',15),
	(165,0,'public/audio/buon.wav','Buồn','',15),
	(166,0,'public/audio/no_bung.wav','No bụng','',15),
	(167,0,'public/audio/doi_bung.wav','Đói bụng','',15),
	(168,0,'public/audio/buon_ngu.wav','buồn ngủ','',15),
	(169,0,'public/audio/chong_mat.wav','chóng mặt','',15),
	(170,0,'public/audio/ban_cam_thay_nhu_the_nao.wav','Bạn cảm thấy như thế nào?','',15),
	(171,0,'','Tôi cảm thấy vui vẻ','',15),
	(172,0,'public/audio/muon.wav','Muốn','',16),
	(173,0,'public/audio/an.wav','Ăn','',16),
	(174,0,'public/audio/uong.wav','Uống','',16),
	(175,0,'public/audio/com.wav','cơm','',16),
	(176,0,'public/audio/bia.wav','bia','',16),
	(177,0,'public/audio/ruou.wav','rượu','',16),
	(178,0,'public/audio/sua.wav','sữa','',16),
	(179,0,'public/audio/nuoc_ngot.wav','nước ngọt','',16),
	(180,0,'public/audio/tra_da.wav','trà đá','',16),
	(181,0,'public/audio/tra_duong.wav','Trà đường','',16),
	(182,0,'public/audio/toi_thich_uong_bia.wav','Tôi thích uống bia','',16);

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
  PRIMARY KEY (`id`)
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `lesson` WRITE;
/*!40000 ALTER TABLE `lesson` DISABLE KEYS */;

INSERT INTO `lesson` (`id`, `name`, `visible`, `categoryId`, `linkedTestId`)
VALUES
	(1,'Get to know',1,1,1),
	(8,'Greetings',1,1,1),
	(9,'Counting',1,1,1),
	(10,'Favorite colors',1,1,1),
	(11,'Personal Pronounce',1,1,1),
	(12,'Occupation',1,1,1),
	(13,'How are you',1,1,1),
	(14,'Age and hobby',1,1,1),
	(15,'How do I feel?',1,1,1),
	(16,'Eating and drinking',1,1,1);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `lesson_log` WRITE;
/*!40000 ALTER TABLE `lesson_log` DISABLE KEYS */;

INSERT INTO `lesson_log` (`id`, `accountId`, `lessonId`, `date`, `progress`)
VALUES
	(1,1,1,'2023-02-26 17:04:03',50);

/*!40000 ALTER TABLE `lesson_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table question
# ------------------------------------------------------------

DROP TABLE IF EXISTS `question`;

CREATE TABLE `question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_type` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `content` varchar(255) NOT NULL,
  `testId` int DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;

INSERT INTO `question` (`id`, `question_type`, `type`, `content`, `testId`, `description`)
VALUES
	(1,1,1,'tôi',1,''),
	(2,0,1,'Bạn là ai',1,''),
	(3,0,4,'/public/audio/ten.wav',1,'');

/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table question_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `question_item`;

CREATE TABLE `question_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL,
  `content` varchar(255) NOT NULL,
  `answer` int NOT NULL,
  `questionId` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `question_item` WRITE;
/*!40000 ALTER TABLE `question_item` DISABLE KEYS */;

INSERT INTO `question_item` (`id`, `type`, `content`, `answer`, `questionId`)
VALUES
	(1,1,'I',1,1),
	(2,1,'am',0,1),
	(3,1,'me',1,1),
	(4,1,'who',0,1),
	(5,1,'This is me',0,2),
	(6,1,'Who are you',1,2),
	(7,1,'Hello everyone',0,2),
	(8,1,'What is your name',0,2),
	(9,1,'tên',1,3),
	(10,1,'tôi',0,3),
	(11,1,'đang',0,3),
	(12,1,'là',0,3);

/*!40000 ALTER TABLE `question_item` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `test_log` WRITE;
/*!40000 ALTER TABLE `test_log` DISABLE KEYS */;

INSERT INTO `test_log` (`id`, `date`, `times`, `scoreHighest`, `scoreLowest`, `scoreSum`, `accountId`, `testId`)
VALUES
	(3,'2023-01-07 11:10:53',5,10,8,45,1,2),
	(4,'2023-02-26 17:11:19',7,9,8,62,1,1);

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
  PRIMARY KEY (`id`)
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
