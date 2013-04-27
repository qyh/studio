-- MySQL dump 10.13  Distrib 5.5.18, for Win64 (x86)
--
-- Host: localhost    Database: dormitory
-- ------------------------------------------------------
-- Server version	5.5.18-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_dormitory`
--

DROP TABLE IF EXISTS `tbl_dormitory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_dormitory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `d_no` varchar(50) DEFAULT NULL,
  `last_grade_time` int(15) DEFAULT '0',
  `d_stu_num` int(11) DEFAULT '0',
  `f_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_fid` (`f_id`),
  CONSTRAINT `fk_fid` FOREIGN KEY (`f_id`) REFERENCES `tbl_floor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_dormitory`
--

LOCK TABLES `tbl_dormitory` WRITE;
/*!40000 ALTER TABLE `tbl_dormitory` DISABLE KEYS */;
INSERT INTO `tbl_dormitory` VALUES (1,'408',1361546228,9,1),(2,'102',1,2,1),(3,'509',0,5,2),(5,'606',0,0,1),(6,'407',0,0,1),(7,'409',0,0,1),(8,'410',0,0,1),(9,'611',0,0,2),(10,'610',0,0,2),(11,'601',0,0,2),(12,'602',0,0,2);
/*!40000 ALTER TABLE `tbl_dormitory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_electric_fee`
--

DROP TABLE IF EXISTS `tbl_electric_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_electric_fee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `degree` float DEFAULT NULL,
  `money` float DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `d_id` int(11) NOT NULL,
  `surplus_money` float DEFAULT NULL,
  `surplus_degree` float DEFAULT NULL,
  `f_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ele` (`d_id`),
  KEY `Pk_f_e` (`f_id`),
  CONSTRAINT `fk_ele` FOREIGN KEY (`d_id`) REFERENCES `tbl_dormitory` (`id`),
  CONSTRAINT `Pk_f_e` FOREIGN KEY (`f_id`) REFERENCES `tbl_floor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_electric_fee`
--

LOCK TABLES `tbl_electric_fee` WRITE;
/*!40000 ALTER TABLE `tbl_electric_fee` DISABLE KEYS */;
INSERT INTO `tbl_electric_fee` VALUES (52,100,50,'2013-04-08 00:00:00',1,20,10,1),(53,101,51,'2013-04-09 00:00:00',7,21,11,1),(54,102,52,'2013-04-13 00:00:00',8,22,12,1);
/*!40000 ALTER TABLE `tbl_electric_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_floor`
--

DROP TABLE IF EXISTS `tbl_floor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `f_no` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `f_no` (`f_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_floor`
--

LOCK TABLES `tbl_floor` WRITE;
/*!40000 ALTER TABLE `tbl_floor` DISABLE KEYS */;
INSERT INTO `tbl_floor` VALUES (2,'14#'),(1,'15#');
/*!40000 ALTER TABLE `tbl_floor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_msg`
--

DROP TABLE IF EXISTS `tbl_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` text,
  `resp` text,
  `msg_time` datetime DEFAULT NULL,
  `resp_time` datetime DEFAULT NULL,
  `m_id` int(11) DEFAULT NULL,
  `u_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stumsg` (`u_id`),
  CONSTRAINT `fk_stumsg` FOREIGN KEY (`u_id`) REFERENCES `tbl_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_msg`
--

LOCK TABLES `tbl_msg` WRITE;
/*!40000 ALTER TABLE `tbl_msg` DISABLE KEYS */;
INSERT INTO `tbl_msg` VALUES (1,'sdfsd','hello world 在枯','2013-02-22 00:07:19','2013-04-06 22:24:56',7,19),(99,'顶替','22222','2013-04-07 22:03:03','2013-04-07 22:03:24',7,7),(100,'月额',NULL,'2013-04-07 22:33:38',NULL,NULL,7),(101,'木',NULL,'2013-04-07 22:35:54',NULL,NULL,7),(102,'木枯',NULL,'2013-04-07 22:35:54',NULL,NULL,7),(103,'444444444444',NULL,'2013-04-07 22:36:38',NULL,NULL,7),(104,'顶起',NULL,'2013-04-07 22:38:41',NULL,NULL,7),(105,'2222222222222',NULL,'2013-04-07 22:40:21',NULL,NULL,7),(106,'2222222222222 顶替',NULL,'2013-04-07 22:40:21',NULL,NULL,7),(107,'人',NULL,'2013-04-07 22:41:07',NULL,NULL,7);
/*!40000 ALTER TABLE `tbl_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_news`
--

DROP TABLE IF EXISTS `tbl_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_news` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `created_on` int(11) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_news`
--

LOCK TABLES `tbl_news` WRITE;
/*!40000 ALTER TABLE `tbl_news` DISABLE KEYS */;
INSERT INTO `tbl_news` VALUES (1,132123,'item1'),(2,1363255011,'Item #814'),(3,1363256028,'Item #1651');
/*!40000 ALTER TABLE `tbl_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_notice`
--

DROP TABLE IF EXISTS `tbl_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `public_time` datetime DEFAULT NULL,
  `owner_id` int(11) NOT NULL,
  `f_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_u_notice` (`owner_id`),
  KEY `pk_f_notice` (`f_id`),
  CONSTRAINT `pk_f_notice` FOREIGN KEY (`f_id`) REFERENCES `tbl_floor` (`id`),
  CONSTRAINT `pk_u_notice` FOREIGN KEY (`owner_id`) REFERENCES `tbl_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_notice`
--

LOCK TABLES `tbl_notice` WRITE;
/*!40000 ALTER TABLE `tbl_notice` DISABLE KEYS */;
INSERT INTO `tbl_notice` VALUES (1,'关于清明放假的通知','清明放假2天','2013-04-10 19:57:21',7,1),(2,'放暑假通知','今年暑假从6月30号\r\n到8月15号\r\n特此通知','2013-04-10 20:14:45',7,1),(3,'停电通知','明天 下午将停电 2 小时\r\n请各位同学做好准备','2013-04-10 20:35:02',7,1),(4,'文艺晚会','2013届文艺晚会\r\n将在5月底举行','2013-04-10 20:36:36',7,1),(5,'hello world','hello world hello world','2013-04-10 20:38:55',7,1),(6,'Test','可悲吉一 霜在霜','2013-04-10 20:39:10',7,1),(7,'水卡到货通知','水卡已到货，有需要的同学可到\r\n管理员处购买','2013-04-10 20:39:33',7,1);
/*!40000 ALTER TABLE `tbl_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_repairs`
--

DROP TABLE IF EXISTS `tbl_repairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_repairs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `report_time` datetime DEFAULT NULL,
  `accept_time` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `u_id` int(11) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dr` (`d_id`),
  CONSTRAINT `fk_dr` FOREIGN KEY (`d_id`) REFERENCES `tbl_dormitory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_repairs`
--

LOCK TABLES `tbl_repairs` WRITE;
/*!40000 ALTER TABLE `tbl_repairs` DISABLE KEYS */;
INSERT INTO `tbl_repairs` VALUES (7,'电灯','坏了','2013-04-09 08:36:00','2013-04-09 08:57:38',1,7,2),(8,'电灯','都可','2013-04-09 08:38:13','2013-04-09 09:40:43',0,7,1),(9,'电灯','枯干','2013-04-09 09:29:58',NULL,0,2,1),(10,'电灯','工','2013-04-09 09:30:47',NULL,0,7,2);
/*!40000 ALTER TABLE `tbl_repairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_score`
--

DROP TABLE IF EXISTS `tbl_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) DEFAULT NULL,
  `deduction_reason` varchar(256) DEFAULT NULL,
  `grade_time` date DEFAULT NULL,
  `grade_id` int(11) NOT NULL,
  `d_id` int(11) NOT NULL,
  `f_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dscore` (`d_id`),
  KEY `f_id` (`f_id`),
  KEY `pk_user_score` (`grade_id`),
  CONSTRAINT `fk_dscore` FOREIGN KEY (`d_id`) REFERENCES `tbl_dormitory` (`id`),
  CONSTRAINT `pk_user_score` FOREIGN KEY (`grade_id`) REFERENCES `tbl_user` (`id`),
  CONSTRAINT `tbl_score_ibfk_1` FOREIGN KEY (`f_id`) REFERENCES `tbl_floor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_score`
--

LOCK TABLES `tbl_score` WRITE;
/*!40000 ALTER TABLE `tbl_score` DISABLE KEYS */;
INSERT INTO `tbl_score` VALUES (8,9,NULL,'2013-04-09',7,1,1);
/*!40000 ALTER TABLE `tbl_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userno` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` varchar(64) DEFAULT NULL,
  `class` varchar(256) DEFAULT NULL,
  `department` varchar(256) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `length_of_schooling` int(11) DEFAULT '4',
  `create_time` datetime DEFAULT NULL,
  `leave_date` date DEFAULT NULL,
  `is_in_school` int(11) DEFAULT '1',
  `last_login_time` datetime DEFAULT NULL,
  `auth` int(11) DEFAULT '0',
  `image_path` varchar(255) DEFAULT NULL,
  `d_id` int(11) NOT NULL,
  `f_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userno` (`userno`),
  KEY `fk_sd` (`d_id`),
  KEY `fk_sf` (`f_id`),
  CONSTRAINT `fk_sd` FOREIGN KEY (`d_id`) REFERENCES `tbl_dormitory` (`id`),
  CONSTRAINT `fk_sf` FOREIGN KEY (`f_id`) REFERENCES `tbl_floor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES (2,'123456','123456','e10adc3949ba59abbe56e057f20f883e','男',NULL,NULL,NULL,NULL,4,'2013-02-20 00:00:00',NULL,1,'2013-04-09 09:31:30',0,NULL,1,1),(5,'20092215','username','c12e01f2a13ff5587e1e9e4aedb8242d','男',NULL,NULL,NULL,NULL,4,'2013-02-20 00:00:00',NULL,1,'2013-02-20 00:00:00',0,NULL,1,1),(7,'2013','admin','21232f297a57a5a743894a0e4a801fc3','男',NULL,NULL,NULL,NULL,4,'2013-02-20 00:00:00',NULL,1,'2013-04-12 14:01:19',1,NULL,2,1),(8,'1000','1000','a9b7ba70783b617e9998dc4dd82eb3c5','男',NULL,NULL,NULL,NULL,4,'2013-02-20 00:00:00',NULL,1,'2013-04-08 11:30:10',1,NULL,2,1),(9,'456','123','202cb962ac59075b964b07152d234b70','男',NULL,NULL,NULL,NULL,4,'2013-02-20 00:00:00','2013-04-10',0,'2013-02-20 00:00:00',0,NULL,1,1),(19,'1111','1111','b59c67bf196a4758191e42f76670ceba','男',NULL,NULL,NULL,NULL,4,'2013-02-20 21:45:11',NULL,1,'2013-04-12 15:52:37',0,NULL,1,1),(20,'2222','2222','934b535800b1cba8f96a5d72f72f1611','男',NULL,NULL,NULL,NULL,4,'2013-02-20 21:47:21','2013-04-10',0,'2013-02-20 21:47:21',0,NULL,1,1),(21,'3333','3333','2be9bd7a3434f7038ca27d1918de58bd','男',NULL,NULL,NULL,NULL,4,'2013-02-20 21:54:22',NULL,1,'2013-02-20 21:54:22',0,NULL,3,2),(22,'5555','5555','6074c6aa3488f3c2dddff2a7ca821aab','男',NULL,NULL,NULL,NULL,4,'2013-02-20 22:41:47',NULL,1,'2013-02-20 22:41:47',0,NULL,1,1),(24,'7777','7777','d79c8788088c2193f0244d8f1f36d2db','男',NULL,NULL,NULL,NULL,4,'2013-02-20 23:18:42',NULL,1,'2013-02-20 23:18:42',0,NULL,3,2),(26,'6666','5555','6074c6aa3488f3c2dddff2a7ca821aab','男',NULL,NULL,NULL,NULL,4,'2013-02-22 20:44:06',NULL,1,'2013-02-22 20:44:06',0,NULL,1,1),(27,'1231234','ssss','8f60c8102d29fcd525162d02eed4566b','男',NULL,NULL,NULL,NULL,4,'2013-02-22 20:45:35',NULL,1,'2013-02-22 20:45:35',0,NULL,1,1),(28,'8888','8888','cf79ae6addba60ad018347359bd144d2','男',NULL,NULL,NULL,NULL,4,'2013-02-22 20:48:31',NULL,1,'2013-02-22 20:48:31',1,NULL,1,1),(29,'23456','23456','202cb962ac59075b964b07152d234b70','男',NULL,NULL,NULL,NULL,4,'2013-04-04 11:21:28',NULL,1,'2013-04-04 11:21:28',0,NULL,3,2),(31,'258','258','502e4a16930e414107ee22b6198c578f','男',NULL,NULL,NULL,NULL,4,'2013-04-04 21:04:45',NULL,1,'2013-04-04 21:04:45',0,NULL,3,2),(32,'123','123','202cb962ac59075b964b07152d234b70','男',NULL,NULL,NULL,NULL,4,'2013-04-05 17:24:41',NULL,1,'2013-04-05 17:24:41',0,NULL,1,1),(55,'999','999','b706835de79a2b4e80506f582af3676a','女',NULL,NULL,NULL,NULL,4,'2013-04-05 22:15:32',NULL,1,'2013-04-05 22:15:32',0,NULL,3,2),(59,'10000','10000','b7a782741f667201b54880c925faec4b','女',NULL,NULL,NULL,NULL,4,'2013-04-05 22:17:26',NULL,1,'2013-04-08 11:29:59',0,NULL,1,1);
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger dor_user_trigger after insert on tbl_user
    for each row begin
    update tbl_dormitory set d_stu_num=d_stu_num+1 where id=new.d_id;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger dor_user_del_trigger before delete on tbl_user
    for each row begin
    update tbl_dormitory set d_stu_num=d_stu_num-1 where id=old.d_id;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbl_visit_record`
--

DROP TABLE IF EXISTS `tbl_visit_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_visit_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `identity` varchar(256) NOT NULL,
  `sex` varchar(12) NOT NULL,
  `reason` varchar(256) NOT NULL,
  `visit_time` datetime DEFAULT NULL,
  `leave_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_visit_record`
--

LOCK TABLES `tbl_visit_record` WRITE;
/*!40000 ALTER TABLE `tbl_visit_record` DISABLE KEYS */;
INSERT INTO `tbl_visit_record` VALUES (1,'asdf','sdfsd','男','sdfsd','2013-02-24 16:17:03','2013-02-24 16:38:58'),(2,'张三','123456','男','无','2013-04-09 21:23:12','2013-04-09 21:46:57'),(3,'李四','45613','男','都可以','2013-04-09 21:47:34','2013-04-09 21:47:56'),(4,'五直','3534543534','男','企望','2013-04-09 22:00:42',NULL);
/*!40000 ALTER TABLE `tbl_visit_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-12 19:35:20
