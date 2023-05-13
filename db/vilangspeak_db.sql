# ************************************************************
# Sequel Ace SQL dump
# Version 20046
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.32)
# Database: vilangspeak_db
# Generation Time: 2023-05-13 10:02:33 +0000
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
	(2,'Toai Tran HCt','2001-12-30','toaitran2001',1,'$2b$10$PZgptBIGO47nFJQt1dBBheuFtrLta42gmtG0qt/c9DGq7/d./quna'),
	(30,'Tuan Admin','2001-01-01','admin-abcafde',0,'$2b$10$Dj0NaWEjRk1Zm/dTVsPLXed5lEwgoYEqaYDDmWSabUwArYEV8Qhfa'),
	(31,'Tuan Admin','2001-01-01','admin',0,'$2b$10$oBU54SMx6vz2osas0TmzjeAtD3BN8EPwfpHxF3r7DNG6qwF.cRUb6'),
	(47,'Tuan Trinh 2','2001-03-01','testaccount',1,'$2b$10$o7cji1oo6eSMyweLNuVXNOydhgylJM6FoWPsqSZsOE0FUpMzpztwa');

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
	(1,1,'2023-05-12 22:27:35'),
	(2,1,'2023-05-12 23:52:08'),
	(30,1,'2023-04-17 17:44:18'),
	(36,1,'2023-04-17 17:35:27'),
	(47,1,'2023-05-13 03:15:04');

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
	(200,0,'public/audio/chao.wav','Chào','Hello, hi, bye (informal)',8),
	(201,0,'public/audio/ban.wav','Bạn','You',8),
	(202,0,'public/audio/xin_chao.wav','Xin chào','Hello, hi (formal)',8),
	(203,0,'public/audio/rat_vui_duoc_gap.wav','Rất vui được gặp','Nice to meet/glad to meet',8),
	(204,0,'public/audio/rat_vui_duoc_lam_quen_voi.wav','Rất vui được làm quen với','Nice to know/glad to know',8),
	(205,0,'public/audio/tam_biet.wav','Tạm biệt','Goodbye',8),
	(206,0,'public/audio/toi_ten_la.wav','Tôi tên là','My name is',8),
	(207,0,'public/audio/cai_gi.wav','Cái gì','What',8),
	(208,0,'public/audio/ban_ten_gi.wav','Bạn tên gì?','What is your name?',8),
	(209,0,'public/audio/xin_loi.wav','Xin lỗi','Sorry, excuse me (in formal situations)',8),
	(210,0,'public/audio/ban_la_nguoi_nuoc_nao.wav','Bạn là người nước nào?','What is your nationality?',8),
	(211,0,'public/audio/toi_la_nguoi_viet_nam.wav','Tôi là người Việt Nam','I am Vietnamese',8),
	(212,0,'public/audio/toi_den_tu_nhat_ban.wav','Tôi đến từ Nhật Bản','I come from Japan',8),
	(214,0,'public/audio/mot.wav','Một','one',9),
	(215,0,'public/audio/hai.wav','Hai','two',9),
	(216,0,'public/audio/ba.wav','Ba','three',9),
	(217,0,'public/audio/bon.wav','Bốn','four',9),
	(218,0,'public/audio/nam.wav','Năm','five',9),
	(219,0,'public/audio/sau.wav','Sáu','six',9),
	(220,0,'public/audio/bay.wav','Bảy','seven',9),
	(221,0,'public/audio/tam.wav','Tám','eight',9),
	(222,0,'public/audio/chin.wav','Chín','nine',9),
	(223,0,'public/audio/muoi.wav','Mười','ten',9),
	(224,0,'public/audio/muoi_mot.wav','Mười một','eleven',9),
	(225,0,'public/audio/muoi_hai.wav','Mười hai','twelve',9),
	(226,0,'public/audio/hai_muoi.wav','Hai mươi','twenty',9),
	(227,0,'public/audio/hai_muoi_bay.wav','Hai mươi bảy','twenty seven',9),
	(228,0,'public/audio/nam_tram.wav','Năm trăm','five hundred',9),
	(229,0,'public/audio/ba_nghin.wav','Ba nghìn','three thousand',9),
	(230,0,'public/audio/mot_trieu.wav','Một triệu','one million',9),
	(231,0,'public/audio/hai_ti.wav','Hai tỉ','two billion',9),
	(232,0,'public/audio/hai_tram_ruoi.wav','Hai trăm rưỡi','two hundred fifty',9),
	(233,0,'public/audio/bon_tram_linh_bon.wav','Bốn trăm linh bốn','Four hundred and four',9),
	(238,0,'public/audio/thich.wav','Thích','like/favorite',10),
	(239,0,'public/audio/mau.wav','màu','color',10),
	(240,0,'public/audio/do.wav','đỏ','red',10),
	(241,0,'public/audio/xanh_duong.wav','xanh dương','blue',10),
	(242,0,'public/audio/xanh_la_cay.wav','xanh lá cây','green',10),
	(243,0,'public/audio/hong.wav','hồng','pink',10),
	(244,0,'public/audio/tim.wav','tím','purple',10),
	(245,0,'public/audio/xam.wav','xám','gray',10),
	(246,0,'public/audio/den.wav','đen','black',10),
	(247,0,'public/audio/trang.wav','trắng','white',10),
	(248,0,'public/audio/cam.wav','cam','orange',10),
	(249,0,'public/audio/vang.wav','vàng','yellow',10),
	(251,0,'public/audio/toi.wav','Tôi','I, me',11),
	(252,0,'public/audio/ong.wav','Ông','grandpa, sir (formal)',11),
	(253,0,'public/audio/chu_ay.wav','Chú ấy','That man/uncle',11),
	(254,0,'public/audio/ba_2.wav','Bà','grandma, m\'am (formal)',11),
	(255,0,'public/audio/bac.wav','Bác','Uncle/ aunt',11),
	(256,0,'public/audio/chu.wav','Chú','Uncle/man',11),
	(257,0,'public/audio/co.wav','Cô','Aunt/woman',11),
	(258,0,'public/audio/anh.wav','Anh','Brother/ bro/man',11),
	(259,0,'public/audio/chi.wav','Chị','Sister/sis/woman',11),
	(260,0,'public/audio/em.wav','Em','younger brother/sister',11),
	(261,0,'public/audio/rat_vui_duoc_gap_ba.wav','Rất vui được gặp bà','Nice to meet you/ Glad to see you',11),
	(262,0,'public/audio/chao_co.wav','Chào cô','Hello (to an aunt/woman)',11),
	(264,0,'public/audio/o_dau.wav','Ở đâu','Where?',12),
	(265,0,'public/audio/lam.wav','làm','to do',12),
	(266,0,'public/audio/cong_viec.wav','công việc','job/occupation',12),
	(267,0,'public/audio/lam_viec.wav','làm việc','to work',12),
	(268,0,'public/audio/giao_vien.wav','giáo viên','teacher',12),
	(269,0,'public/audio/bac_si.wav','bác sĩ','doctor',12),
	(270,0,'public/audio/ca_si.wav','ca sĩ','singer',12),
	(271,0,'public/audio/sinh_vien.wav','sinh viên','student',12),
	(272,0,'public/audio/lai_xe.wav','lái xe','driver/to drive',12),
	(273,0,'public/audio/hoa_si.wav','họa sĩ','artist',12),
	(274,0,'public/audio/ki_su.wav','kĩ sư','engineer',12),
	(278,0,'public/audio/ban_khoe_khong.wav','Bạn khỏe không','How are you?',13),
	(279,0,'public/audio/khoe.wav','Khỏe','Good/Well/Fine (Health)',13),
	(280,0,'public/audio/cam_on.wav','Cảm ơn','Thanks',13),
	(281,0,'public/audio/khong.wav','Không','No/ Not',13),
	(282,0,'public/audio/day_la.wav','Đây là','This is',13),
	(283,0,'public/audio/ban_cua_toi.wav','bạn của tôi','My friend',13),
	(284,0,'public/audio/nghe.wav','nghề','job/occupation',13),
	(285,0,'public/audio/ban_lam_nghe_gi.wav','bạn làm nghề gì?','What is your occupation?',13),
	(286,0,'public/audio/cong_viec_cua_ban_la_gi.wav','công việc của bạn là gì?','What is your job?',13),
	(287,0,'public/audio/toi_la.wav','Tôi là','I am',13),
	(288,0,'public/audio/toi_lam.wav','Tôi làm','I am',13),
	(289,0,'public/audio/toi_lam_bac_si.wav','Tôi làm bác sĩ','I am a doctor',13),
	(291,0,'public/audio/tuoi.wav','Tuổi','age, year old',14),
	(292,0,'public/audio/so_thich.wav','Sở thích','hobby',14),
	(293,0,'public/audio/doc_sach.wav','Đọc sách','reading books',14),
	(294,0,'public/audio/nghe_nhac.wav','Nghe nhạc','listening to music',14),
	(295,0,'public/audio/ve_tranh.wav','Vẽ tranh','drawing',14),
	(296,0,'public/audio/ca_hat.wav','Ca hát','singing',14),
	(297,0,'public/audio/bao_nhieu.wav','Bao nhiêu','How much?',14),
	(298,0,'public/audio/ban_thich_mau_gi.wav','Bạn thích màu gì?','What color do you like?',14),
	(299,0,'public/audio/so_thich_cua_ban_la_gi.wav','Sở thích của bạn là gì?','What is your hobby?',14),
	(300,0,'public/audio/anh_bao_nhieu_tuoi.wav','Anh bao nhiêu tuổi?','How old are you?',14),
	(301,0,'public/audio/co_ay_hai_muoi_ba_tuoi.wav','Cô ấy hai mươi ba tuổi','She is twenty three',14),
	(303,0,'public/audio/cam_thay.wav','Cảm thấy','feel, to feel',15),
	(304,0,'public/audio/met.wav','Mệt','tired',15),
	(305,0,'public/audio/vui_ve.wav','Vui vẻ','happy',15),
	(306,0,'public/audio/hanh_phuc.wav','hạnh phúc','happy',15),
	(307,0,'public/audio/buon.wav','Buồn','sad',15),
	(308,0,'public/audio/no_bung.wav','No bụng','full',15),
	(309,0,'public/audio/doi_bung.wav','Đói bụng','Hungry',15),
	(310,0,'public/audio/buon_ngu.wav','buồn ngủ','Sleepy',15),
	(311,0,'public/audio/chong_mat.wav','chóng mặt','Dizzy',15),
	(312,0,'public/audio/ban_cam_thay_nhu_the_nao.wav','Bạn cảm thấy như thế nào?','How do you feel?',15),
	(313,0,'public/audio/toi_cam_thay_vui_ve.wav','Tôi cảm thấy vui vẻ','I feel happy',15),
	(315,0,'public/audio/muon.wav','Muốn','want',16),
	(316,0,'public/audio/an.wav','Ăn','to eat',16),
	(317,0,'public/audio/uong.wav','Uống','to drink',16),
	(318,0,'public/audio/com.wav','cơm','rice',16),
	(319,0,'public/audio/bia.wav','bia','beer',16),
	(320,0,'public/audio/ruou.wav','rượu','wine',16),
	(321,0,'public/audio/sua.wav','sữa','milk',16),
	(322,0,'public/audio/nuoc_ngot.wav','nước ngọt','soft drinks',16),
	(323,0,'public/audio/tra_da.wav','trà đá','ice tea',16),
	(324,0,'public/audio/tra_duong.wav','Trà đường','ice tea with sugar',16),
	(325,0,'public/audio/toi_thich_uong_bia.wav','Tôi thích uống bia','I like to drink bear',16);

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
	(24,1,0,'*đâu* means *where* but the order of it in the sentence is different to *where*',20),
	(28,0,0,'Examples',8),
	(29,1,0,'*chào* bạn\n*Hello/hi*',8),
	(30,0,0,'Examples',8),
	(31,1,0,'chào *bạn*\nHello (to *you*)\nRất vui được gặp *bạn*\nNice to meet *you*',8),
	(32,0,0,'Examples',8),
	(33,1,0,'*xin chào* mọi người \n*Hello* everyone',8),
	(1136,0,0,'Examples',200),
	(1137,1,1,'*Chào* bạn\n*Hello/hi*',200),
	(1138,0,0,'Examples',201),
	(1139,1,1,'Chào *bạn*\nHello (to *you*)\n\nRất vui được gặp *bạn*\nNice to meet *you*',201),
	(1140,0,0,'Examples',202),
	(1141,1,1,'*Xin chào* mọi người \n*Hello* everyone',202),
	(1142,0,0,'Examples',203),
	(1143,1,1,'*Rất vui được gặp* bạn\n*Nice to meet* you',203),
	(1144,0,0,'Examples',204),
	(1145,1,1,'*Rất vui được làm quen với* bạn\nIt\'s *glad to know* you',204),
	(1146,0,0,'Examples',205),
	(1147,1,1,'*Tạm biệt* bạn\n*Goodbye*',205),
	(1148,0,0,'Examples',206),
	(1149,1,1,'*Tên tôi là* David\n*My name is* David',206),
	(1150,1,0,'Synonym: *gì*',207),
	(1151,0,1,'Examples',207),
	(1152,1,2,'*What* is your name?\nBạn tên *gì*?',207),
	(1153,0,0,'Examples',209),
	(1154,1,1,'*Xin lỗi*, bạn tên gì?\n*Excuse me*, what is your name? \n\n*Xin lỗi*, tôi bận rồi\n*Sorry*, I\'m busy ',209),
	(1155,1,0,'Introduce your nationality:\n*Tôi là người* + nationality',211),
	(1156,0,1,'Examples',211),
	(1157,1,2,'*Tôi là người* Anh\nI am British',211),
	(1158,1,0,'Introduce your country:\n*Tôi đến từ* + country',212),
	(1159,0,1,'Examples',212),
	(1160,1,2,'*Tôi đến từ* Hoa Kỳ\n*I come from* the USA',212),
	(1161,1,0,'Change into *mốt* when it follows *mươi*',214),
	(1162,0,1,'Examples',214),
	(1163,1,2,'Tôi có *một* con mèo\nI have *one* cat \n\nTôi có hai *mươi mốt* con mèo\nI have twenty *one* cat ',214),
	(1164,0,0,'Examples',215),
	(1165,1,1,'Tôi có *hai* con chó\nI have *two* dogs',215),
	(1166,0,0,'Examples',216),
	(1167,1,1,'Tôi có *ba* cái xe \nI have *three* cars',216),
	(1168,1,0,'Can be changed into *tư* when it follows *mươi*',217),
	(1169,0,1,'Examples',217),
	(1170,1,2,'Tôi có *bốn* con cá \nI have *four* fishes\n\nTôi có ba mươi *bốn* con cá/ Tôi có ba *mươi tư* con cá \nI have thirty *four* fishes',217),
	(1171,1,0,'Change to *lăm* when counting by tens',218),
	(1172,0,1,'Examples',218),
	(1173,1,2,'Tôi có *năm* cái xe \nI have *five* cars\n\nTôi có mười *lăm* cái xe\nI have *fifteen* cars ',218),
	(1174,1,0,'Change to *mươi* when it\'s followed by a number ',223),
	(1175,0,1,'Examples',223),
	(1176,1,2,'Tôi có *mười* cây bút\nI have *ten* pens\n\nTôi có hai *mươi* cây bút \nI have *twenty* pens',223),
	(1177,0,0,'Examples',228),
	(1178,1,1,'Tôi có năm *trăm* năm \nI have five *hundred* years',228),
	(1179,0,0,'Examples',229),
	(1180,1,1,'Tôi có ba *nghìn* đồng\n I have three *thousand* dong',229),
	(1181,0,0,'Examples',230),
	(1182,1,1,'Tôi có một *triệu* đồng \n I have one *million* dong ',230),
	(1183,0,0,'Examples',231),
	(1184,1,1,'Tôi có 2 *tỷ* đô\nI have two *billion* dollar',231),
	(1185,1,0,'*rưỡi* can be used as a short for *half* when it comes to hundred and more',232),
	(1186,0,1,'Examples',232),
	(1187,1,2,'Tôi có hai trăm *rưỡi* đô \nI have two hundred fifty dollar (two hundred and *a half* of hundred)',232),
	(1188,1,0,'*linh* means zero, and is used when hundred goes with numbers that smaller than ten',233),
	(1189,0,1,'Examples',233),
	(1190,1,2,'Bốn trăm linh bốn chiếc tàu\nFour hundred and four ships',233),
	(1191,0,0,'Examples: ',238),
	(1192,1,1,'Tôi *thích* mèo \nI *like* cats',238),
	(1193,0,0,'Examples: ',239),
	(1194,1,1,'*màu* tôi ưa thích là hồng \nMy favorite *color* is pink ',239),
	(1195,0,0,'Examples: ',240),
	(1196,1,1,'Tôi thích màu đỏ \nI like red',240),
	(1197,1,0,'used when you\'re talking to a stranger or in daily conversations',251),
	(1198,0,1,'Examples:',251),
	(1199,1,2,'*Tôi* tên là Jim\n*I* am Jim\n\nJim is *me*\nJim là *tôi*',251),
	(1200,1,0,'used to show politeness and respect or closeness to an elder man',252),
	(1201,0,1,'Examples:',252),
	(1202,1,2,'Chào *ông*, tôi tên là Minh\nHi *sir*, my name is Minh\n\n*Ông* cụ trông vui vẻ \nThe *grandpa* seems happy',252),
	(1203,1,0,'*ấy* is used as *that* ',253),
	(1204,0,1,'Examples:',253),
	(1205,1,2,'Chú *ấy* đang buồn\n*That* man is sad',253),
	(1206,1,0,'used to show politeness and respect or closeness to an elder woman',254),
	(1207,0,1,'Examples:',254),
	(1208,1,2,'Chào *bà*, tôi tên là My \nHi *m\'am*, my name is My \n\n*Bà* cụ trông rất vui vẻ\nThe *grandma* seems happy ',254),
	(1209,1,0,'used to show politeness and respect or closeness to a middle-aged man or woman',255),
	(1210,0,1,'Examples:',255),
	(1211,1,2,'*Bác ấy* rất tốt bụng \nThat uncle/aunt is very nice ',255),
	(1212,1,0,'used to show politeness and respect or closeness a middle-aged man',256),
	(1213,0,1,'Examples:',256),
	(1214,1,2,'*Chú* ấy thích màu xanh lá\nThat *uncle/man* likes green',256),
	(1215,1,0,'used to show politeness and respect or closeness to a middle-aged woman',257),
	(1216,0,1,'Examples:',257),
	(1217,1,2,'*Cô* ấy thích màu đen \nThat *aunt/woman* likes black',257),
	(1218,1,0,'used in daily conversations with an older man or about your age',258),
	(1219,0,1,'Examples:',258),
	(1220,1,2,'*Anh* ấy cho tôi kẹo\nThat *brother/bro/man* gives me candy ',258),
	(1221,1,0,'used in daily conversations with an older woman or about your age',259),
	(1222,0,1,'Examples:',259),
	(1223,1,2,'*Chị* ấy xinh đẹp \nThat *sister/sis/woman* is beautiful ',259),
	(1224,1,0,'used in daily conversations with a person who is about your age',260),
	(1225,0,1,'Examples:',260),
	(1226,1,2,'*Em* ấy thích màu đỏ \n*He/She* likes red ',260),
	(1227,0,0,'Examples: ',261),
	(1228,1,1,'Xin chào, *rất vui được gặp bà* \nHi, *nice to meet you, m\'am*',261),
	(1229,0,0,'Examples: ',264),
	(1230,1,1,'Bạn *ở đâu*?\n*Where* are you?',264),
	(1231,0,0,'Examples: ',265),
	(1232,1,1,'Tôi *làm* bài tập\nI *do* my homework ',265),
	(1233,0,0,'Examples: ',266),
	(1234,1,1,'*Công việc* của bạn là gì?\nWhat is your *job*?',266),
	(1235,0,0,'Examples: ',267),
	(1236,1,1,'Where do you *work*? \nBạn *làm việc* ở đâu?',267),
	(1237,0,0,'Examples: ',268),
	(1238,1,1,'Tôi là *giáo viên*\nI am a *teacher*',268),
	(1239,0,0,'Examples: ',269),
	(1240,1,1,'Tôi là *bác sĩ*\nI am a *doctor ',269),
	(1241,0,0,'Examples: ',279),
	(1242,1,1,'Tôi *khỏe*, cảm ơn\nI am *good/well/fine*, thank you',279),
	(1243,0,0,'Examples: ',280),
	(1244,1,1,'*Cảm ơn* bạn\n*Thank* you',280),
	(1245,0,0,'Examples: ',281),
	(1246,1,1,'*Không*, tôi *không* khỏe \n*No*, I am *not* good',281),
	(1247,0,0,'Examples: ',282),
	(1248,1,1,'*Đây là* Jim\n*This is* Jim',282),
	(1249,0,0,'Examples: ',283),
	(1250,1,1,'Đây là *bạn của tôi*, Tim\nThis is *my friend*, Tim',283),
	(1251,0,0,'Examples: ',287),
	(1252,1,1,'*Tôi là* bác sĩ\n*I am* a doctor',287),
	(1253,0,0,'Examples: ',291),
	(1254,1,1,'Tôi hai mươi *tuổi*\nI am twenty *years old*\n\nBạn bao nhiêu *tuổi*?\nHow *old* are you?',291),
	(1255,0,0,'Examples: ',292),
	(1256,1,1,'*Sở thích* của tôi là ca hát\nMy *hobby* is singing',292),
	(1257,0,0,'Examples: ',293),
	(1258,1,1,'Tôi *thích* đọc sách\nI like *reading books*',293),
	(1259,0,0,'Examples: ',297),
	(1260,1,1,'Cái đó *bao nhiêu* tiền?\n*How much* money is it?',297),
	(1261,1,0,'(talking to an older man)',300),
	(1262,0,0,'Examples: ',303),
	(1263,1,1,'Tôi *cảm thấy* vui vẻ\nI *feel* happy',303),
	(1264,0,0,'Examples: ',304),
	(1265,1,1,'Tôi cảm thấy *mệt*\nI feel *tired*',304),
	(1266,0,0,'Examples: ',305),
	(1267,1,1,'Bạn đang cảm thấy *vui vẻ* không?\nDo you feel *happy*?',305),
	(1268,0,0,'Examples: ',315),
	(1269,1,1,'Tôi *muốn* ăn bánh\nI *want* to eat cakes',315),
	(1270,0,0,'Examples: ',316),
	(1271,1,1,'Tôi *ăn* cơm\nI *eat* rice',316),
	(1272,0,0,'Examples: ',317),
	(1273,1,1,'Tôi *uống* nước\nI *drink* water',317),
	(1274,0,0,'Examples: ',318),
	(1275,1,1,'Tôi thích ăn *cơm*\nI like to eat *rice*',318),
	(1276,0,0,'Examples: ',319),
	(1277,1,1,'Tôi thích uống *bia*\nI like to drink *beer* ',319);

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
	(8,'Get to know','/public/image/category-get-to-know.png'),
	(9,'Number','/public/image/category-number.png'),
	(10,'Colors','/public/image/category-colors.png'),
	(11,'Work','/public/image/category-work.png'),
	(12,'Leisure','/public/image/category-leisure.png'),
	(13,'Emotion','/public/image/category-emotion.png'),
	(14,'Shopping','/public/image/category-shopping.png');

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
	(8,'Greetings',1,8,8),
	(9,'Counting',1,9,9),
	(10,'Favorite colors',1,10,10),
	(11,'Personal Pronounce',1,8,11),
	(12,'Occupation',1,11,12),
	(13,'How are you',1,8,13),
	(14,'Age and hobby',1,12,NULL),
	(15,'How do I feel?',1,13,15),
	(16,'Eating and drinking',1,14,NULL);

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
	(1,1,1,'2023-02-26 17:04:03',50),
	(4,2,1,'2023-05-12 21:20:07',10),
	(5,2,8,'2023-05-12 21:22:08',100),
	(6,1,8,'2023-05-12 22:24:03',100),
	(7,1,9,'2023-05-12 21:49:59',95),
	(8,1,10,'2023-05-12 21:52:22',100),
	(9,1,13,'2023-05-12 22:04:48',100),
	(10,1,15,'2023-05-12 22:16:41',100);

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
	(101,0,1,'Hello/Hi',8,''),
	(102,1,1,'Chào',8,'public/audio/chao.wav'),
	(103,0,2,'public/image/hello.png',8,'Hello'),
	(104,1,4,'public/audio/tam_biet.wav',8,''),
	(105,1,1,'Rất vui được gặp bạn',8,'Rất vui được gặp bạn'),
	(106,0,1,'What?',8,''),
	(107,0,1,'Bạn tên gì?',8,'public/audio/ban_ten_gi.wav'),
	(108,0,2,'public/image/sorry.png',8,'Sorry'),
	(109,0,1,'Bạn là người nước nào?',8,'public/audio/ban_la_nguoi_nuoc_nao.wav'),
	(110,0,1,'Bye',8,''),
	(130,1,2,'public/image/thirty-four.png',9,''),
	(131,0,2,'public/image/fifty-one.png',9,''),
	(132,0,4,'public/audio/hai_muoi_lam.wav',9,''),
	(133,0,4,'public/audio/muoi_mot.wav',9,''),
	(134,0,1,'Ba triệu',9,''),
	(135,0,1,'Sáu tỉ',9,''),
	(136,0,4,'public/audio/chin_tram_bay_muoi.wav',9,''),
	(137,0,4,'public/audio/mot_nghin_hai_tram.wav',9,''),
	(138,0,1,'Một trăm bốn mươi tám nghìn',9,'public/audio/Mot_tram_bon_muoi_tam_nghin.wav'),
	(139,0,4,'public/audio/sau_nghin_linh_ba.wav',9,''),
	(146,1,4,'public/audio/Toi_thich_mau_xanh.wav',10,''),
	(147,1,4,'public/audio/thich.wav',10,''),
	(148,0,1,'màu đỏ ',10,'public/audio/do.wav'),
	(149,0,2,'public/image/blue-whale.png',10,''),
	(150,0,4,'public/audio/cam.wav',10,''),
	(151,0,2,'public/image/purple-onion.png',10,''),
	(152,0,2,'public/image/pink-cosmos.png',10,''),
	(153,0,2,'public/image/black.png',10,''),
	(154,0,1,'Vàng',10,'public/audio/vang.wav'),
	(155,0,2,'public/image/yellow.png',10,''),
	(169,1,4,'public/audio/rat_vui_duoc_lam_quen_voi_chi.wav',11,''),
	(170,1,4,'public/audio/tam_biet_em.wav',11,''),
	(171,0,4,'public/audio/ong_ay_den_tu_hoa_ky.wav',11,''),
	(172,1,4,'Tôi',11,'public/audio/toi.wav'),
	(173,1,1,'Ông',11,'public/audio/ong.wav'),
	(174,1,1,'Bác',11,'public/audio/bac.wav'),
	(175,0,1,'Hello (to old woman)',11,''),
	(176,1,1,'Hello (to young woman)',11,''),
	(177,0,1,'Hello (to a younger person)',11,''),
	(178,1,4,'public/audio/ba_2.wav',11,''),
	(179,1,1,'Rất vui được gặp bác',11,'public/audio/Rat_vui_duoc_gap_bac.wav'),
	(180,1,4,'public/audio/Chao_chi.wav',11,''),
	(189,0,1,'',12,'public/audio/Anh_ay_la_hoa_si.wav'),
	(190,1,1,'',12,'public/audio/Em_ay_la_sinh_vien.wav'),
	(191,1,2,'public/image/classroom.png',12,''),
	(192,0,2,'public/image/engineer.png',12,''),
	(193,0,1,'Bác sĩ',12,'public/audio/bac_si.wav'),
	(194,0,4,'public/audio/lam_viec.wav',12,''),
	(195,1,2,'public/image/job.png',12,''),
	(196,0,4,'public/audio/lai_xe.wav',12,''),
	(197,0,2,'public/image/what.png',12,''),
	(198,0,4,'public/audio/o_dau.wav',12,''),
	(199,0,1,'Chú làm việc ở đâu?',12,'public/audio/Chu_lam_viec_o_dau.wav'),
	(211,0,1,'Anh khỏe không',13,'lesson/audio/anh_khoe_khong.wav'),
	(212,1,4,'public/audio/Toi_khoe.wav',13,''),
	(213,0,4,'public/audio/cam_on.wav',13,''),
	(214,0,1,'Tôi là giáo viên',13,'public/audio/Toi_la_giao_vien.wav'),
	(215,1,1,'Công việc của em là gì?',13,'public/audio/Cong_viec_cua_em_la_gi.wav'),
	(216,0,1,'Cô ấy là kĩ sư',13,'public/audio/Co_ay_la_ky_su.wav'),
	(217,1,4,'public/audio/Anh_lam_nghe_gi.wav',13,''),
	(218,0,4,'public/audio/Day_la_ban_cua_toi.wav',13,''),
	(219,0,4,'public/audio/Toi_la_hoa_si.wav',13,''),
	(254,1,1,'',15,'public/audio/Toi_cam_thay_doi_bung.wav'),
	(255,1,1,'',15,'public/audio/Chi_cam_thay_nhu_the_nao.wav'),
	(256,0,2,'public/image/dizziness.png',15,''),
	(257,0,4,'public/audio/buon_ngu.wav',15,''),
	(258,0,4,'public/audio/buon.wav',15,''),
	(259,0,2,'public/image/hunger.png',15,''),
	(260,1,2,'public/image/happy.png',15,''),
	(261,1,4,'public/audio/hanh_phuc.wav',15,''),
	(262,0,1,'Buồn',15,'public/audio/buon.wav'),
	(263,0,1,'No bụng ',15,'public/audio/no_bung.wav');

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
	(335,1,'Xin chào',1,101),
	(336,1,'Tạm biệt',0,101),
	(337,1,'Cái gì',0,101),
	(338,1,'Tên gì',0,101),
	(339,1,'Hello',1,102),
	(340,1,'Bye ',1,102),
	(341,1,'Nice',0,102),
	(342,1,'Hi',1,102),
	(343,1,'Tạm biệt',0,103),
	(344,1,'Xin chào',1,103),
	(345,1,'Cái gì',0,103),
	(346,1,'Tên',0,103),
	(347,1,'Goodbye',1,104),
	(348,1,'Hi',0,104),
	(349,1,'Bye',1,104),
	(350,1,'Nice',0,104),
	(351,1,'Nice to meet you',1,105),
	(352,1,'Nice to know your age',0,105),
	(353,1,'Nice to have you ',0,105),
	(354,1,'Nice to know you ',1,105),
	(355,4,'public/audio/cai_gi.wav',1,106),
	(356,4,'public/audio/The_nao.wav',0,106),
	(357,4,'public/audio/bao_nhieu.wav',0,106),
	(358,4,'public/audio/Khi_nao.wav',0,106),
	(359,1,'What\'s your name?',1,107),
	(360,1,'What\'s your age?',0,107),
	(361,1,'What\'s your nationality?',0,107),
	(362,1,'What\'s your color?',0,107),
	(363,1,'Xin lỗi',1,108),
	(364,1,'Cảm ơn',0,108),
	(365,1,'Tạm biệt',0,108),
	(366,1,'Chào',0,108),
	(367,1,'What\'s your nationality?',1,109),
	(368,1,'What\'s your name?',0,109),
	(369,1,'What\'s wrong?',0,109),
	(370,1,'What\'s your age?',0,109),
	(371,4,'public/audio/chao.wav',0,110),
	(372,4,'public/audio/tam_biet.wav',1,110),
	(373,4,'public/audio/xin_loi.wav',0,110),
	(374,4,'public/audio/Ten.wav',0,110),
	(375,1,'Ba mươi tư',1,130),
	(376,1,'Bốn mươi ba',0,130),
	(377,1,'Ba mươi bốn',1,130),
	(378,1,'Tư mươi ba',0,130),
	(379,1,'Năm mươi một',0,131),
	(380,1,'Năm mươi mốt',1,131),
	(381,1,'Mười lăm',0,131),
	(382,1,'Năm mười một',0,131),
	(383,2,'public/image/52.png',0,132),
	(384,2,'public/image/number-12.png',0,132),
	(385,2,'public/image/number-15.png',0,132),
	(386,2,'public/image/number-25.png',1,132),
	(387,1,'Eleven',1,133),
	(388,1,'Ten',0,133),
	(389,1,'twenty one',0,133),
	(390,1,'one ten',0,133),
	(391,4,'public/audio/ba_tram.wav',0,134),
	(392,4,'public/audio/Ba_trieu.wav',1,134),
	(393,4,'public/audio/Ba_ti.wav',0,134),
	(394,4,'public/audio/Ba_nghin.wav',0,134),
	(395,4,'public/audio/sau_nghin.wav',0,135),
	(396,4,'public/audio/sau_trieu.wav',0,135),
	(397,4,'public/audio/Sau_ti.wav',1,135),
	(398,4,'public/audio/Sau_tram.wav',0,135),
	(399,1,'907',0,136),
	(400,1,'790',0,136),
	(401,1,'970',1,136),
	(402,1,'920',0,136),
	(403,1,'1200',1,137),
	(404,1,'1002',0,137),
	(405,1,'2100',0,137),
	(406,1,'1020',0,137),
	(407,1,'184000',0,138),
	(408,1,'148000',1,138),
	(409,1,'148',0,138),
	(410,1,'1840',0,138),
	(411,1,'6300',0,139),
	(412,1,'3600',0,139),
	(413,1,'6003',1,139),
	(414,1,'603000',0,139),
	(415,1,'I like blue ',1,146),
	(416,1,'I like green',1,146),
	(417,1,'I like red',0,146),
	(418,1,'I like purple',0,146),
	(419,1,'Pink',0,147),
	(420,1,'color',0,147),
	(421,1,'favorite',1,147),
	(422,1,'like',1,147),
	(423,2,'public/image/red.png',1,148),
	(424,2,'public/image/orange.png',0,148),
	(425,2,'public/image/blue.png',0,148),
	(426,2,'public/image/green.png',0,148),
	(427,1,'green',0,149),
	(428,1,'blue',1,149),
	(429,1,'red',0,149),
	(430,1,'orange',0,149),
	(431,2,'public/image/red.png',0,150),
	(432,2,'public/image/blue.png',0,150),
	(433,2,'public/image/orange.png',1,150),
	(434,2,'public/image/green.png',0,150),
	(435,1,'màu đỏ',0,151),
	(436,1,'Màu tím',1,151),
	(437,1,'Xanh',0,151),
	(438,1,'Cam',0,151),
	(439,4,'public/audio/do.wav',0,152),
	(440,4,'public/audio/cam.wav',0,152),
	(441,4,'public/audio/hong.wav',1,152),
	(442,4,'public/audio/xanh_duong.wav',0,152),
	(443,4,'public/audio/cam.wav',0,153),
	(444,4,'public/audio/trang.wav',0,153),
	(445,4,'public/audio/den.wav',1,153),
	(446,4,'public/audio/vang.wav',0,153),
	(447,2,'public/image/pink-cosmos.png',0,154),
	(448,2,'public/image/red.png',0,154),
	(449,2,'public/image/orange.png',0,154),
	(450,2,'public/image/yellow.png',1,154),
	(451,4,'public/audio/do.wav',0,155),
	(452,4,'public/audio/cam.wav',0,155),
	(453,4,'public/audio/xanh_duong.wav',1,155),
	(454,4,'public/audio/xam.wav',0,155),
	(455,1,'It\'s nice to know you',1,169),
	(456,1,'Nice to have you ',0,169),
	(457,1,'Glad to meet you ',1,169),
	(458,1,'Glad you hear from you',0,169),
	(459,1,'Hi',0,170),
	(460,1,'Bye',1,170),
	(461,1,'See you later',0,170),
	(462,1,'Goodbye',1,170),
	(463,1,'He is from USA',0,171),
	(464,1,'He comes from the oversea',0,171),
	(465,1,'He\'s from Europe',0,171),
	(466,1,'He comes from The UK',1,171),
	(467,1,'I ',1,172),
	(468,1,'He',0,172),
	(469,1,'Me',1,172),
	(470,1,'You',0,172),
	(471,4,'Grandpa',1,173),
	(472,4,'Grandma',0,173),
	(473,4,'Sir',1,173),
	(474,4,'You',0,173),
	(475,4,'Uncle',1,174),
	(476,4,'Brother',0,174),
	(477,4,'Sister',0,174),
	(478,4,'Aunt',1,174),
	(479,1,'Chào chị',0,175),
	(480,1,'Chào cô',0,175),
	(481,1,'Chào bà',1,175),
	(482,1,'Chào bác',0,175),
	(483,1,'Chào cô',0,176),
	(484,1,'Chào chị',1,176),
	(485,1,'Chào anh',0,176),
	(486,1,'Chào em',1,176),
	(487,1,'Chào em ',1,177),
	(488,1,'Chào chị',0,177),
	(489,1,'Chào bác',0,177),
	(490,1,'Chào chú',0,177),
	(491,1,'Sir',0,178),
	(492,1,'M\'am',1,178),
	(493,1,'Grandma',1,178),
	(494,1,'Grandpa',0,178),
	(495,1,'Nice to meet you (to young woman)',0,179),
	(496,1,'Nice to meet you (to younger person)',0,179),
	(497,1,'Nice to meet you (to an uncle)',1,179),
	(498,1,'Nice to meet you (to an aunt)',1,179),
	(499,1,'Hello (to a sister)',1,180),
	(500,1,'Hello (to a brother)',0,180),
	(501,1,'Hello (to a woman)',1,180),
	(502,1,'Hello (to an aunt)',0,180),
	(503,1,'He is an artist',1,189),
	(504,1,'She is a singer',0,189),
	(505,1,'He is a singer',0,189),
	(506,1,'She is an artist',0,189),
	(507,1,'She is a student',1,190),
	(508,1,'He is a teacher',0,190),
	(509,1,'He is a student',1,190),
	(510,1,'She is a singer',0,190),
	(511,1,'Học sinh',1,191),
	(512,1,'Giáo viên',1,191),
	(513,1,'Ca sĩ',0,191),
	(514,1,'Kỹ sư',0,191),
	(515,1,'Giáo viên',0,192),
	(516,1,'Học sinh',0,192),
	(517,1,'Kỹ sư',1,192),
	(518,1,'Ca sĩ',0,192),
	(519,2,'public/image/students.png',0,193),
	(520,2,'public/image/classroom.png',0,193),
	(521,2,'public/image/singer.png',1,193),
	(522,2,'public/image/engineer.png',0,193),
	(523,1,'job',0,194),
	(524,1,'to work',1,194),
	(525,1,'occupation',0,194),
	(526,1,'singer',0,194),
	(527,4,'public/audio/lam_viec.wav',0,195),
	(528,4,'public/audio/cong_viec.wav',1,195),
	(529,4,'public/audio/nghe.wav',1,195),
	(530,4,'public/audio/lam.wav',0,195),
	(531,2,'public/image/driver.png',1,196),
	(532,2,'public/image/classroom.png',0,196),
	(533,2,'public/image/singer.png',0,196),
	(534,2,'public/image/engineer.png',0,196),
	(535,4,'public/audio/o_dau.wav',0,197),
	(536,4,'public/audio/lam_viec.wav',0,197),
	(537,4,'public/audio/cai_gi.wav',1,197),
	(538,4,'public/audio/bao_nhieu.wav',0,197),
	(539,2,'public/image/what.png',0,198),
	(540,2,'public/image/when.png',0,198),
	(541,2,'public/image/how.png',0,198),
	(542,2,'public/image/where.png',1,198),
	(543,1,'Where do you work?',1,199),
	(544,1,'When do you work?',0,199),
	(545,1,'What do you do?',0,199),
	(546,1,'Where do you live?',0,199),
	(547,1,'What is your occupation?',0,211),
	(548,1,'How are you?',1,211),
	(549,1,'How old are you?',0,211),
	(550,1,'What do you like?',0,211),
	(551,1,'I\'m good',1,212),
	(552,1,'I\'m bad',0,212),
	(553,1,'I am feeling good',0,212),
	(554,1,'I am fine',1,212),
	(555,2,'public/image/sorry.png',0,213),
	(556,2,'public/image/thank-you.png',1,213),
	(557,2,'public/image/happy.png',0,213),
	(558,2,'public/image/sad.png',0,213),
	(559,1,'I am an engineer',0,214),
	(560,1,'I am an artist',0,214),
	(561,1,'I am a teacher',1,214),
	(562,1,'I am a student',0,214),
	(563,1,'What is your job? (asking an older man)',0,215),
	(564,1,'What is your job? (asking a younger man)',1,215),
	(565,1,'What is your occupation? (asking younger woman)',1,215),
	(566,1,'What is your occupation? (asking an older woman)',0,215),
	(567,1,'She is a doctor',0,216),
	(568,1,'He is a doctor',0,216),
	(569,1,'She is an engineer',1,216),
	(570,1,'He is a singer',0,216),
	(571,1,'What is your job? (asking a man)',1,217),
	(572,1,'What is your job? (asking a brother)',1,217),
	(573,1,'What is your occupation? (asking a man)',1,217),
	(574,1,'What is your occupation? (asking a brother)',1,217),
	(575,1,'She is my friend',0,218),
	(576,1,'He is my friend',0,218),
	(577,1,'He is a driver',0,218),
	(578,1,'This is my friend',1,218),
	(579,1,'I am an engineer',0,219),
	(580,1,'I am an artist',1,219),
	(581,1,'I am a singer',0,219),
	(582,1,'I am a driver',0,219),
	(583,1,'I feel hungry',1,254),
	(584,1,'I feel thirsty',0,254),
	(585,1,'I\'m hungry',1,254),
	(586,1,'I feel tired',0,254),
	(587,1,'How do you feel?',1,255),
	(588,1,'How do you do?',0,255),
	(589,1,'How much is it?',0,255),
	(590,1,'Are you feeling good?',1,255),
	(591,4,'public/audio/met.wav',0,256),
	(592,4,'public/audio/chong_mat.wav',1,256),
	(593,4,'public/audio/buon.wav',0,256),
	(594,4,'public/audio/buon_ngu.wav',0,256),
	(595,2,'public/image/sad.png',0,257),
	(596,2,'public/image/tired.png',1,257),
	(597,2,'public/image/weakness.png',0,257),
	(598,2,'public/image/smiley.png',0,257),
	(599,2,'public/image/smiley.png',0,258),
	(600,2,'public/image/sad.png',1,258),
	(601,2,'public/image/tired.png',0,258),
	(602,2,'public/image/weakness.png',0,258),
	(603,4,'public/audio/doi_bung.wav',1,259),
	(604,4,'public/audio/no_bung.wav',0,259),
	(605,4,'public/audio/buon_ngu.wav',0,259),
	(606,4,'public/audio/buon.wav',0,259),
	(607,4,'public/audio/vui_ve.wav',1,260),
	(608,4,'public/audio/chong_mat.wav',0,260),
	(609,4,'public/audio/hanh_phuc.wav',1,260),
	(610,4,'public/audio/buon.wav',0,260),
	(611,2,'public/image/sad.png',0,261),
	(612,2,'public/image/happy.png',1,261),
	(613,2,'public/image/tired.png',0,261),
	(614,2,'public/image/smiley.png',1,261),
	(615,2,'public/image/happy.png',0,262),
	(616,2,'public/image/tired.png',0,262),
	(617,2,'public/image/sad.png',1,262),
	(618,2,'public/image/dizziness.png',0,262),
	(619,2,'public/image/hunger.png',0,263),
	(620,2,'public/image/happy.png',0,263),
	(621,2,'public/image/tired.png',0,263),
	(622,2,'public/image/full.png',1,263);

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
	(1,'Hello',0,1),
	(8,'Greetings',1,8),
	(9,'Counting',1,9),
	(10,'Favorite colors',1,10),
	(11,'Personal Pronounce',1,8),
	(12,'Occupation',1,11),
	(13,'How are you',1,8),
	(15,'How do I feel?',1,13);

/*!40000 ALTER TABLE `testx` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
