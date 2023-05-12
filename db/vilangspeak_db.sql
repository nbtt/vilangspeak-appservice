# ************************************************************
# Sequel Ace SQL dump
# Version 20046
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.32)
# Database: vilangspeak_db
# Generation Time: 2023-05-12 15:57:40 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


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
	(710,0,0,'Examples',200),
	(711,1,1,'*Chào* bạn\n*Hello/hi*',200),
	(712,0,0,'Examples',201),
	(713,1,1,'Chào *bạn*\nHello (to *you*)\n\nRất vui được gặp *bạn*\nNice to meet *you*',201),
	(714,0,0,'Examples',202),
	(715,1,1,'*Xin chào* mọi người \n*Hello* everyone',202),
	(716,0,0,'Examples',203),
	(717,1,1,'*Rất vui được gặp* bạn\n*Nice to meet* you',203),
	(718,0,0,'Examples',204),
	(719,1,1,'*Rất vui được làm quen với* bạn\nIt\'s *glad to know* you',204),
	(720,0,0,'Examples',205),
	(721,1,1,'*Tạm biệt* bạn\n*Goodbye*',205),
	(722,0,0,'Examples',206),
	(723,1,1,'*Tên tôi là* David\n*My name is* David',206),
	(724,1,0,'Synonym: *gì*',207),
	(725,0,1,'Examples',207),
	(726,1,2,'*What* is your name?\nBạn tên *gì*?',207),
	(727,0,0,'Examples',209),
	(728,1,1,'*Xin lỗi*, bạn tên gì?\n*Excuse me*, what is your name? \n\n*Xin lỗi*, tôi bận rồi\n*Sorry*, I\'m busy ',209),
	(729,1,0,'Introduce your nationality:\n*Tôi là người* + nationality',211),
	(730,0,1,'Examples',211),
	(731,1,2,'*Tôi là người* Anh\nI am British',211),
	(732,1,0,'Introduce your country:\n*Tôi đến từ* + country',212),
	(733,0,1,'Examples',212),
	(734,1,2,'*Tôi đến từ* Hoa Kỳ\n*I come from* the USA',212),
	(735,1,0,'Change into *mốt* when it follows *mươi*',214),
	(736,0,1,'Examples',214),
	(737,1,2,'Tôi có *một* con mèo\nI have *one* cat \n\nTôi có hai *mươi mốt* con mèo\nI have twenty *one* cat ',214),
	(738,0,0,'Examples',215),
	(739,1,1,'Tôi có *hai* con chó\nI have *two* dogs',215),
	(740,0,0,'Examples',216),
	(741,1,1,'Tôi có *ba* cái xe \nI have *three* cars',216),
	(742,1,0,'Can be changed into *tư* when it follows *mươi*',217),
	(743,0,1,'Examples',217),
	(744,1,2,'Tôi có *bốn* con cá \nI have *four* fishes\n\nTôi có ba mươi *bốn* con cá/ Tôi có ba *mươi tư* con cá \nI have thirty *four* fishes',217),
	(745,1,0,'Change to *lăm* when counting by tens',218),
	(746,0,1,'Examples',218),
	(747,1,2,'Tôi có *năm* cái xe \nI have *five* cars\n\nTôi có mười *lăm* cái xe\nI have *fifteen* cars ',218),
	(748,1,0,'Change to *mươi* when it\'s followed by a number ',223),
	(749,0,1,'Examples',223),
	(750,1,2,'Tôi có *mười* cây bút\nI have *ten* pens\n\nTôi có hai *mươi* cây bút \nI have *twenty* pens',223),
	(751,0,0,'Examples',228),
	(752,1,1,'Tôi có năm *trăm* năm \nI have five *hundred* years',228),
	(753,0,0,'Examples',229),
	(754,1,1,'Tôi có ba *nghìn* đồng\n I have three *thousand* dong',229),
	(755,0,0,'Examples',230),
	(756,1,1,'Tôi có một *triệu* đồng \n I have one *million* dong ',230),
	(757,0,0,'Examples',231),
	(758,1,1,'Tôi có 2 *tỷ* đô\nI have two *billion* dollar',231),
	(759,1,0,'*rưỡi* can be used as a short for *half* when it comes to hundred and more',232),
	(760,0,1,'Examples',232),
	(761,1,2,'Tôi có hai trăm *rưỡi* đô \nI have two hundred fifty dollar (two hundred and *a half* of hundred)',232),
	(762,1,0,'*linh* means zero, and is used when hundred goes with numbers that smaller than ten',233),
	(763,0,1,'Examples',233),
	(764,1,2,'Bốn trăm linh bốn chiếc tàu\nFour hundred and four ships',233),
	(765,0,0,'Examples: ',238),
	(766,1,1,'Tôi *thích* mèo \nI *like* cats',238),
	(767,0,0,'Examples: ',239),
	(768,1,1,'*màu* tôi ưa thích là hồng \nMy favorite *color* is pink ',239),
	(769,0,0,'Examples: ',240),
	(770,1,1,'Tôi thích màu đỏ \nI like red',240),
	(771,1,0,'used when you\'re talking to a stranger or in daily conversations',251),
	(772,0,1,'Examples:',251),
	(773,1,2,'*Tôi* tên là Jim\n*I* am Jim\n\nJim is *me*\nJim là *tôi*',251),
	(774,1,0,'used to show politeness and respect or closeness to an elder man',252),
	(775,0,1,'Examples:',252),
	(776,1,2,'Chào *ông*, tôi tên là Minh\nHi *sir*, my name is Minh\n\n*Ông* cụ trông vui vẻ \nThe *grandpa* seems happy',252),
	(777,1,0,'*ấy* is used as *that* ',253),
	(778,0,1,'Examples:',253),
	(779,1,2,'Chú *ấy* đang buồn\n*That* man is sad',253),
	(780,1,0,'used to show politeness and respect or closeness to an elder woman',254),
	(781,0,1,'Examples:',254),
	(782,1,2,'Chào *bà*, tôi tên là My \nHi *m\'am*, my name is My \n\n*Bà* cụ trông rất vui vẻ\nThe *grandma* seems happy ',254),
	(783,1,0,'used to show politeness and respect or closeness to a middle-aged man or woman',255),
	(784,0,1,'Examples:',255),
	(785,1,2,'*Bác ấy* rất tốt bụng \nThat uncle/aunt is very nice ',255),
	(786,1,0,'used to show politeness and respect or closeness a middle-aged man',256),
	(787,0,1,'Examples:',256),
	(788,1,2,'*Chú* ấy thích màu xanh lá\nThat *uncle/man* likes green',256),
	(789,1,0,'used to show politeness and respect or closeness to a middle-aged woman',257),
	(790,0,1,'Examples:',257),
	(791,1,2,'*Cô* ấy thích màu đen \nThat *aunt/woman* likes black',257),
	(792,1,0,'used in daily conversations with an older man or about your age',258),
	(793,0,1,'Examples:',258),
	(794,1,2,'*Anh* ấy cho tôi kẹo\nThat *brother/bro/man* gives me candy ',258),
	(795,1,0,'used in daily conversations with an older woman or about your age',259),
	(796,0,1,'Examples:',259),
	(797,1,2,'*Chị* ấy xinh đẹp \nThat *sister/sis/woman* is beautiful ',259),
	(798,1,0,'used in daily conversations with a person who is about your age',260),
	(799,0,1,'Examples:',260),
	(800,1,2,'*Em* ấy thích màu đỏ \n*He/She* likes red ',260),
	(801,0,0,'Examples: ',261),
	(802,1,1,'Xin chào, *rất vui được gặp bà* \nHi, *nice to meet you, m\'am*',261),
	(803,0,0,'Examples: ',264),
	(804,1,1,'Bạn *ở đâu*?\n*Where* are you?',264),
	(805,0,0,'Examples: ',265),
	(806,1,1,'Tôi *làm* bài tập\nI *do* my homework ',265),
	(807,0,0,'Examples: ',266),
	(808,1,1,'*Công việc* của bạn là gì?\nWhat is your *job*?',266),
	(809,0,0,'Examples: ',267),
	(810,1,1,'Where do you *work*? \nBạn *làm việc* ở đâu?',267),
	(811,0,0,'Examples: ',268),
	(812,1,1,'Tôi là *giáo viên*\nI am a *teacher*',268),
	(813,0,0,'Examples: ',269),
	(814,1,1,'Tôi là *bác sĩ*\nI am a *doctor ',269),
	(815,0,0,'Examples: ',279),
	(816,1,1,'Tôi *khỏe*, cảm ơn\nI am *good/well/fine*, thank you',279),
	(817,0,0,'Examples: ',280),
	(818,1,1,'*Cảm ơn* bạn\n*Thank* you',280),
	(819,0,0,'Examples: ',281),
	(820,1,1,'*Không*, tôi *không* khỏe \n*No*, I am *not* good',281),
	(821,0,0,'Examples: ',282),
	(822,1,1,'*Đây là* Jim\n*This is* Jim',282),
	(823,0,0,'Examples: ',283),
	(824,1,1,'Đây là *bạn của tôi*, Tim\nThis is *my friend*, Tim',283),
	(825,0,0,'Examples: ',287),
	(826,1,1,'*Tôi là* bác sĩ\n*I am* a doctor',287),
	(827,0,0,'Examples: ',291),
	(828,1,1,'Tôi hai mươi *tuổi*\nI am twenty *years old*\n\nBạn bao nhiêu *tuổi*?\nHow *old* are you?',291),
	(829,0,0,'Examples: ',292),
	(830,1,1,'*Sở thích* của tôi là ca hát\nMy *hobby* is singing',292),
	(831,0,0,'Examples: ',293),
	(832,1,1,'Tôi *thích* đọc sách\nI like *reading books*',293),
	(833,0,0,'Examples: ',297),
	(834,1,1,'Cái đó *bao nhiêu* tiền?\n*How much* money is it?',297),
	(835,1,0,'(talking to an older man)',300),
	(836,0,0,'Examples: ',303),
	(837,1,1,'Tôi *cảm thấy* vui vẻ\nI *feel* happy',303),
	(838,0,0,'Examples: ',304),
	(839,1,1,'Tôi cảm thấy *mệt*\nI feel *tired*',304),
	(840,0,0,'Examples: ',305),
	(841,1,1,'Bạn đang cảm thấy *vui vẻ* không?\nDo you feel *happy*?',305),
	(842,0,0,'Examples: ',315),
	(843,1,1,'Tôi *muốn* ăn bánh\nI *want* to eat cakes',315),
	(844,0,0,'Examples: ',316),
	(845,1,1,'Tôi *ăn* cơm\nI *eat* rice',316),
	(846,0,0,'Examples: ',317),
	(847,1,1,'Tôi *uống* nước\nI *drink* water',317),
	(848,0,0,'Examples: ',318),
	(849,1,1,'Tôi thích ăn *cơm*\nI like to eat *rice*',318),
	(850,0,0,'Examples: ',319),
	(851,1,1,'Tôi thích uống *bia*\nI like to drink *beer* ',319);

/*!40000 ALTER TABLE `card_item` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
