# ************************************************************
# Sequel Ace SQL dump
# Version 20046
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.32)
# Database: vilangspeak_db
# Generation Time: 2023-05-12 15:25:58 +0000
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
	(31,'Tuan Admin','2001-01-01','admin',0,'$2b$10$YkxV9.r/JqHCZ11HP9PzReJkZFvxDVTMQVm3X1kZH0ALgLQwWTKrC');

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
	(1,1,'2023-05-12 22:23:47'),
	(2,1,'2023-05-12 22:18:34'),
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
	(212,0,'','Tôi đến từ Nhật Bản','I come from Japan',8),
	(214,0,'public/audio/một.wav','Một','one',9),
	(215,0,'public/audio/hai.wav','Hai','two',9),
	(216,0,'public/audio/ba.wav','Ba','three',9),
	(217,0,'public/audio/bon.wav','Bốn','four',9),
	(218,0,'public/audio/nam.wav','Năm','five',9),
	(219,0,'public/audio/sau.wav','Sáu','six',9),
	(220,0,'public/audio/bay.wav','Bảy','seven',9),
	(221,0,'public/audio/tam.wav','Tám','eight',9),
	(222,0,'public/audio/chin.wav','Chín','nine',9),
	(223,0,'public/audio/muoi.wav','Mười','ten',9),
	(224,0,'public/audio/muoi_một.wav','Mười một','eleven',9),
	(225,0,'public/audio/muoi_hai.wav','Mười hai','twelve',9),
	(226,0,'public/audio/hai_muoi.wav','Hai mươi','twenty',9),
	(227,0,'public/audio/hai_muoi_bay.wav','Hai mươi bảy','twenty seven',9),
	(228,0,'','Năm trăm','five hundred',9),
	(229,0,'','Ba nghìn','three thousand',9),
	(230,0,'','Một triệu','one million',9),
	(231,0,'','Hai tỉ','two billion',9),
	(232,0,'','Hai trăm rưỡi','two hundred fifty',9),
	(233,0,'','Bốn trăm linh bốn','',9),
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
	(253,0,'','Chú ấy','',11),
	(254,0,'public/audio/ba_2.wav','Bà','grandma, m\'am (formal)',11),
	(255,0,'public/audio/bac.wav','Bác','Uncle/ aunt',11),
	(256,0,'public/audio/chu.wav','Chú','Uncle/man',11),
	(257,0,'public/audio/co.wav','Cô','Aunt/woman',11),
	(258,0,'public/audio/anh.wav','Anh','Brother/ bro/man',11),
	(259,0,'public/audio/chi.wav','Chị','Sister/sis/woman',11),
	(260,0,'public/audio/em.wav','Em','younger brother/sister',11),
	(261,0,'','Rất vui được gặp bà','Nice to meet you/ Glad to see you',11),
	(262,0,'','Chào cô','Hello (to an aunt/woman)',11),
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
	(300,0,'','Anh bao nhiêu tuổi?','How old are you?',14),
	(301,0,'','Cô ấy hai mươi ba tuổi','She is twenty three',14),
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
	(313,0,'','Tôi cảm thấy vui vẻ','I feel happy',15),
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
	(574,0,0,'Examples',200),
	(575,1,1,'*Chào* bạn\n*Hello/hi*',200),
	(576,0,0,'Examples',201),
	(577,1,1,'Chào *bạn*\nHello (to *you*)\n\nRất vui được gặp *bạn*\nNice to meet *you*',201),
	(578,0,0,'Examples',202),
	(579,1,1,'*Xin chào* mọi người \n*Hello* everyone',202),
	(580,0,0,'Examples',203),
	(581,1,1,'*Rất vui được gặp* bạn\n*Nice to meet* you',203),
	(582,0,0,'Examples',204),
	(583,1,1,'*Rất vui được làm quen với* bạn\nIt\'s *glad to know* you',204),
	(584,0,0,'Examples',205),
	(585,1,1,'*Tạm biệt* bạn\n*Goodbye*',205),
	(586,0,0,'Examples',206),
	(587,1,1,'*Tên tôi là* David\n*My name is* David',206),
	(588,1,0,'Synonym: *gì*',207),
	(589,0,1,'Examples',207),
	(590,1,2,'*What* is your name?\nBạn tên *gì*?',207),
	(591,0,0,'Examples',209),
	(592,1,1,'*Xin lỗi*, bạn tên gì?\n*Excuse me*, what is your name? \n\n*Xin lỗi*, tôi bận rồi\n*Sorry*, I\'m busy ',209),
	(593,1,0,'Introduce your nationality:\n*Tôi là người* + nationality',211),
	(594,0,1,'Examples',211),
	(595,1,2,'*Tôi là người* Anh\nI am British',211),
	(596,1,0,'Introduce your country:\n*Tôi đến từ* + country',212),
	(597,0,1,'Examples',212),
	(598,1,2,'*Tôi đến từ* Hoa Kỳ\n*I come from* the USA',212),
	(599,1,0,'Change into *mốt* when it follows *mươi*',214),
	(600,0,1,'Examples',214),
	(601,1,2,'Tôi có *một* con mèo\nI have *one* cat \n\nTôi có hai *mươi mốt* con mèo\nI have twenty *one* cat ',214),
	(602,0,0,'Examples',215),
	(603,1,1,'Tôi có *hai* con chó\nI have *two* dogs',215),
	(604,0,0,'Examples',216),
	(605,1,1,'Tôi có *ba* cái xe \nI have *three* cars',216),
	(606,1,0,'Can be changed into *tư* when it follows *mươi*',217),
	(607,0,1,'Examples',217),
	(608,1,2,'Tôi có *bốn* con cá \nI have *four* fishes\n\nTôi có ba mươi *bốn* con cá/ Tôi có ba *mươi tư* con cá \nI have thirty *four* fishes',217),
	(609,1,0,'Change to *lăm* when counting by tens',218),
	(610,0,1,'Examples',218),
	(611,1,2,'Tôi có *năm* cái xe \nI have *five* cars\n\nTôi có mười *lăm* cái xe\nI have *fifteen* cars ',218),
	(612,1,0,'Change to *mươi* when it\'s followed by a number ',223),
	(613,0,1,'Examples',223),
	(614,1,2,'Tôi có *mười* cây bút\nI have *ten* pens\n\nTôi có hai *mươi* cây bút \nI have *twenty* pens',223),
	(615,0,0,'Examples',228),
	(616,1,1,'Tôi có năm *trăm* năm \nI have five *hundred* years',228),
	(617,0,0,'Examples',229),
	(618,1,1,'Tôi có ba *nghìn* đồng\n I have three *thousand* dong',229),
	(619,0,0,'Examples',230),
	(620,1,1,'Tôi có một *triệu* đồng \n I have one *million* dong ',230),
	(621,0,0,'Examples',231),
	(622,1,1,'Tôi có 2 *tỷ* đô\nI have two *billion* dollar',231),
	(623,1,0,'*rưỡi* can be used as a short for *half* when it comes to hundred and more',232),
	(624,0,1,'Examples',232),
	(625,1,2,'Tôi có hai trăm *rưỡi* đô \nI have two hundred fifty dollar (two hundred and *a half* of hundred)',232),
	(626,0,0,'Examples: ',238),
	(627,1,1,'Tôi *thích* mèo \nI *like* cats',238),
	(628,0,0,'Examples: ',239),
	(629,1,1,'*màu* tôi ưa thích là hồng \nMy favorite *color* is pink ',239),
	(630,0,0,'Examples: ',240),
	(631,1,1,'Tôi thích màu đỏ \nI like red',240),
	(632,1,0,'used when you\'re talking to a stranger or in daily conversations',251),
	(633,0,1,'Examples:',251),
	(634,1,2,'Chào *ông*, tôi tên là Minh\nHi *sir*, my name is Minh\n\n*Ông* cụ trông vui vẻ \nThe *grandpa* seems happy',251),
	(635,1,0,'used to show politeness and respect or closeness to an elder man',252),
	(636,0,1,'Examples:',252),
	(637,1,2,'',252),
	(638,1,0,'used to show politeness and respect or closeness to an elder woman',254),
	(639,0,1,'Examples:',254),
	(640,1,2,'Chào *bà*, tôi tên là My \nHi *m\'am*, my name is My \n\n*Bà* cụ trông rất vui vẻ\nThe *grandma* seems happy ',254),
	(641,1,0,'used to show politeness and respect or closeness to a middle-aged man or woman',255),
	(642,0,1,'Examples:',255),
	(643,1,2,'*Bác ấy* rất tốt bụng \nThat uncle/aunt is very nice ',255),
	(644,1,0,'used to show politeness and respect or closeness a middle-aged man',256),
	(645,0,1,'Examples:',256),
	(646,1,2,'*Chú* ấy thích màu xanh lá\nThat *uncle/man* likes green',256),
	(647,1,0,'used to show politeness and respect or closeness to a middle-aged woman',257),
	(648,0,1,'Examples:',257),
	(649,1,2,'*Cô* ấy thích màu đen \nThat *aunt/woman* likes black',257),
	(650,1,0,'used in daily conversations with an older man or about your age',258),
	(651,0,1,'Examples:',258),
	(652,1,2,'*Anh* ấy cho tôi kẹo\nThat *brother/bro/man* gives me candy ',258),
	(653,1,0,'used in daily conversations with an older woman or about your age',259),
	(654,0,1,'Examples:',259),
	(655,1,2,'*Chị* ấy xinh đẹp \nThat *sister/sis/woman* is beautiful ',259),
	(656,1,0,'used in daily conversations with a person who is about your age',260),
	(657,0,1,'Examples:',260),
	(658,1,2,'*Em* ấy thích màu đỏ \n*He/She* likes red ',260),
	(659,0,0,'Examples: ',261),
	(660,1,1,'Xin chào, *rất vui được gặp bà* \nHi, *nice to meet you, m\'am*',261),
	(661,0,0,'Examples: ',264),
	(662,1,1,'Bạn *ở đâu*?\n*Where* are you?',264),
	(663,0,0,'Examples: ',265),
	(664,1,1,'Tôi *làm* bài tập\nI *do* my homework ',265),
	(665,0,0,'Examples: ',266),
	(666,1,1,'*Công việc* của bạn là gì?\nWhat is your *job*?',266),
	(667,0,0,'Examples: ',267),
	(668,1,1,'Where do you *work*? \nBạn *làm việc* ở đâu?',267),
	(669,0,0,'Examples: ',268),
	(670,1,1,'Tôi là *giáo viên*\nI am a *teacher*',268),
	(671,0,0,'Examples: ',269),
	(672,1,1,'Tôi là *bác sĩ*\nI am a *doctor ',269),
	(673,0,0,'Examples: ',279),
	(674,1,1,'Tôi *khỏe*, cảm ơn\nI am *good/well/fine*, thank you',279),
	(675,0,0,'Examples: ',280),
	(676,1,1,'*Cảm ơn* bạn\n*Thank* you',280),
	(677,0,0,'Examples: ',281),
	(678,1,1,'*Không*, tôi *không* khỏe \n*No*, I am *not* good',281),
	(679,0,0,'Examples: ',282),
	(680,1,1,'*Đây là* Jim\n*This is* Jim',282),
	(681,0,0,'Examples: ',283),
	(682,1,1,'Đây là *bạn của tôi*, Tim\nThis is *my friend*, Tim',283),
	(683,0,0,'Examples: ',287),
	(684,1,1,'*Tôi là* bác sĩ\n*I am* a doctor',287),
	(685,0,0,'Examples: ',291),
	(686,1,1,'Tôi hai mươi *tuổi*\nI am twenty *years old*\n\nBạn bao nhiêu *tuổi*?\nHow *old* are you?',291),
	(687,0,0,'Examples: ',292),
	(688,1,1,'*Sở thích* của tôi là ca hát\nMy *hobby* is singing',292),
	(689,0,0,'Examples: ',293),
	(690,1,1,'Tôi *thích* đọc sách\nI like *reading books*',293),
	(691,0,0,'Examples: ',297),
	(692,1,1,'Cái đó *bao nhiêu* tiền?\n*How much* money is it?',297),
	(693,1,0,'(talking to an older man)',300),
	(694,0,0,'Examples: ',303),
	(695,1,1,'Tôi *cảm thấy* vui vẻ\nI *feel* happy',303),
	(696,0,0,'Examples: ',304),
	(697,1,1,'Tôi cảm thấy *mệt*\nI feel *tired*',304),
	(698,0,0,'Examples: ',305),
	(699,1,1,'Bạn đang cảm thấy *vui vẻ* không?\nDo you feel *happy*?',305),
	(700,0,0,'Examples: ',315),
	(701,1,1,'Tôi *muốn* ăn bánh\nI *want* to eat cakes',315),
	(702,0,0,'Examples: ',316),
	(703,1,1,'Tôi *ăn* cơm\nI *eat* rice',316),
	(704,0,0,'Examples: ',317),
	(705,1,1,'Tôi *uống* nước\nI *drink* water',317),
	(706,0,0,'Examples: ',318),
	(707,1,1,'Tôi thích ăn *cơm*\nI like to eat *rice*',318),
	(708,0,0,'Examples: ',319),
	(709,1,1,'Tôi thích uống *bia*\nI like to drink *beer* ',319);

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
