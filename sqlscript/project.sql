-- MySQL dump 10.10
--
-- Host: 192.168.137.101    Database: project
-- ------------------------------------------------------
-- Server version	5.0.18-nt

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
-- Table structure for table `expect_train`
--

DROP TABLE IF EXISTS `expect_train`;
CREATE TABLE `expect_train` (
  `id` int(11) NOT NULL auto_increment,
  `time` datetime default NULL,
  `type` varchar(255) default NULL,
  `site` varchar(255) default NULL,
  `content` varchar(255) default NULL,
  `pattern` varchar(255) default NULL,
  `emphasis` varchar(255) default NULL,
  `ausbilder` varchar(255) default NULL,
  `detail` varchar(255) default NULL,
  `id_card` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK86DAA2DAD1C3CA` (`id_card`),
  CONSTRAINT `expect_train_ibfk_1` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`),
  CONSTRAINT `FK86DAA2DAD1C3CA` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `expect_train`
--


/*!40000 ALTER TABLE `expect_train` DISABLE KEYS */;
LOCK TABLES `expect_train` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `expect_train` ENABLE KEYS */;

--
-- Table structure for table `odtbinfo`
--

DROP TABLE IF EXISTS `odtbinfo`;
CREATE TABLE `odtbinfo` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `specialty` varchar(255) default NULL,
  `content` varchar(255) default NULL,
  `base_code` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK801A26319E21BEC8` (`base_code`),
  CONSTRAINT `FK801A26319E21BEC8` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`),
  CONSTRAINT `odtbinfo_ibfk_1` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `odtbinfo`
--


/*!40000 ALTER TABLE `odtbinfo` DISABLE KEYS */;
LOCK TABLES `odtbinfo` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `odtbinfo` ENABLE KEYS */;

--
-- Table structure for table `offer_info`
--

DROP TABLE IF EXISTS `offer_info`;
CREATE TABLE `offer_info` (
  `id` int(11) NOT NULL auto_increment,
  `office` varchar(255) default NULL,
  `enterprise` varchar(255) default NULL,
  `teacher_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `teacher_id` (`teacher_id`),
  KEY `FK99E1CB1313426AE` (`teacher_id`),
  CONSTRAINT `FK99E1CB1313426AE` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`),
  CONSTRAINT `offer_info_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `offer_info`
--


/*!40000 ALTER TABLE `offer_info` DISABLE KEYS */;
LOCK TABLES `offer_info` WRITE;
INSERT INTO `offer_info` VALUES (1,'农大计信院 ','华为',1);
UNLOCK TABLES;
/*!40000 ALTER TABLE `offer_info` ENABLE KEYS */;

--
-- Table structure for table `part_time_job`
--

DROP TABLE IF EXISTS `part_time_job`;
CREATE TABLE `part_time_job` (
  `id` int(11) NOT NULL auto_increment,
  `organization` varchar(255) default NULL,
  `course` varchar(255) default NULL,
  `condition` varchar(255) default NULL,
  `teacher_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `teacher_id` (`teacher_id`),
  KEY `FKCC597E17313426AE` (`teacher_id`),
  CONSTRAINT `FKCC597E17313426AE` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`),
  CONSTRAINT `part_time_job_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `part_time_job`
--


/*!40000 ALTER TABLE `part_time_job` DISABLE KEYS */;
LOCK TABLES `part_time_job` WRITE;
INSERT INTO `part_time_job` VALUES (1,'江西省教育厅','证券分析','本校专职教师',1);
UNLOCK TABLES;
/*!40000 ALTER TABLE `part_time_job` ENABLE KEYS */;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `date` datetime default NULL,
  `office` varchar(255) default NULL,
  `teacher_id` int(11) default NULL,
  `type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `teacher_id` (`teacher_id`),
  KEY `FK2C929929313426AE` (`teacher_id`),
  CONSTRAINT `FK2C929929313426AE` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`),
  CONSTRAINT `position_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `position`
--


/*!40000 ALTER TABLE `position` DISABLE KEYS */;
LOCK TABLES `position` WRITE;
INSERT INTO `position` VALUES (1,'高级','2008-05-04 00:00:00','国家级',1,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `position` ENABLE KEYS */;

--
-- Table structure for table `pre_spe`
--

DROP TABLE IF EXISTS `pre_spe`;
CREATE TABLE `pre_spe` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `type` varchar(255) default NULL,
  `time` varchar(255) default NULL,
  `base_code` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKECFE960C9E21BEC8` (`base_code`),
  CONSTRAINT `FKECFE960C9E21BEC8` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`),
  CONSTRAINT `pre_spe_ibfk_1` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `pre_spe`
--


/*!40000 ALTER TABLE `pre_spe` DISABLE KEYS */;
LOCK TABLES `pre_spe` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `pre_spe` ENABLE KEYS */;

--
-- Table structure for table `prize`
--

DROP TABLE IF EXISTS `prize`;
CREATE TABLE `prize` (
  `id` int(11) NOT NULL auto_increment,
  `rank` varchar(255) default NULL,
  `intro` varchar(255) default NULL,
  `time` datetime default NULL,
  `issuer` varchar(255) default NULL,
  `id_card` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK65FB412DAD1C3CA` (`id_card`),
  CONSTRAINT `FK65FB412DAD1C3CA` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `prize`
--


/*!40000 ALTER TABLE `prize` DISABLE KEYS */;
LOCK TABLES `prize` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `prize` ENABLE KEYS */;

--
-- Table structure for table `profession`
--

DROP TABLE IF EXISTS `profession`;
CREATE TABLE `profession` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `type` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `profession`
--


/*!40000 ALTER TABLE `profession` DISABLE KEYS */;
LOCK TABLES `profession` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `profession` ENABLE KEYS */;

--
-- Table structure for table `sch_pro`
--

DROP TABLE IF EXISTS `sch_pro`;
CREATE TABLE `sch_pro` (
  `school_code` varchar(255) NOT NULL,
  `profession_id` int(11) NOT NULL,
  PRIMARY KEY  (`profession_id`,`school_code`),
  KEY `FK7242D206C60CCB86` (`profession_id`),
  KEY `FK7242D2061FA2C098` (`school_code`),
  CONSTRAINT `FK7242D2061FA2C098` FOREIGN KEY (`school_code`) REFERENCES `school` (`code`),
  CONSTRAINT `FK7242D206C60CCB86` FOREIGN KEY (`profession_id`) REFERENCES `profession` (`id`),
  CONSTRAINT `sch_pro_ibfk_1` FOREIGN KEY (`school_code`) REFERENCES `school` (`code`),
  CONSTRAINT `sch_pro_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `profession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sch_pro`
--


/*!40000 ALTER TABLE `sch_pro` DISABLE KEYS */;
LOCK TABLES `sch_pro` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `sch_pro` ENABLE KEYS */;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
CREATE TABLE `school` (
  `code` varchar(255) NOT NULL,
  `name` varchar(255) default NULL,
  `property` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `postcode` varchar(255) default NULL,
  `fax` varchar(255) default NULL,
  `superior_depart` varchar(255) default NULL,
  `stu_num` int(11) default NULL,
  `staff` int(11) default NULL,
  `teacher_num` int(11) default NULL,
  `managers` int(11) default NULL,
  `ss_ratio` float default NULL,
  `st_ratio` float default NULL,
  `area` float default NULL,
  `build_sides` float default NULL,
  `province` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `county` varchar(255) default NULL,
  `town` varchar(255) default NULL,
  `sch_property` varchar(255) default NULL,
  `sch_rank` varchar(255) default NULL,
  `sch_depart` varchar(255) default NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `school`
--


/*!40000 ALTER TABLE `school` DISABLE KEYS */;
LOCK TABLES `school` WRITE;
INSERT INTO `school` VALUES ('1111111','江西农业大学','公办','13319406847','www.jxau.cn','330045','0791-33333333','省教育厅',20000,2000,1800,200,1,2,12000,3000,'江西省','南昌','昌北','志敏','职业中专','3','不知道');
UNLOCK TABLES;
/*!40000 ALTER TABLE `school` ENABLE KEYS */;

--
-- Table structure for table `sotb`
--

DROP TABLE IF EXISTS `sotb`;
CREATE TABLE `sotb` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `type` varchar(255) default NULL,
  `time` varchar(255) default NULL,
  `days` int(11) default NULL,
  `nop` int(11) default NULL,
  `base_code` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK35F5CA9E21BEC8` (`base_code`),
  CONSTRAINT `FK35F5CA9E21BEC8` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`),
  CONSTRAINT `sotb_ibfk_1` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `sotb`
--


/*!40000 ALTER TABLE `sotb` DISABLE KEYS */;
LOCK TABLES `sotb` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `sotb` ENABLE KEYS */;

--
-- Table structure for table `teach_course`
--

DROP TABLE IF EXISTS `teach_course`;
CREATE TABLE `teach_course` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `time` int(11) default NULL,
  `teacher_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKA5315725313426AE` (`teacher_id`),
  CONSTRAINT `FKA5315725313426AE` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`),
  CONSTRAINT `teach_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `teach_course`
--


/*!40000 ALTER TABLE `teach_course` DISABLE KEYS */;
LOCK TABLES `teach_course` WRITE;
INSERT INTO `teach_course` VALUES (1,'数据库',2001,1),(2,'计算机网络',2003,1),(3,'网页设计',2004,1),(4,'java程序设计',2005,1);
UNLOCK TABLES;
/*!40000 ALTER TABLE `teach_course` ENABLE KEYS */;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id` int(11) NOT NULL auto_increment,
  `id_card` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `sex` varchar(255) default NULL,
  `age` int(11) default NULL,
  `birthday` datetime default NULL,
  `depart` varchar(255) default NULL,
  `search_section` varchar(255) default NULL,
  `administrative` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `native_place` varchar(255) default NULL,
  `nation` varchar(255) default NULL,
  `polity` varchar(255) default NULL,
  `first_educat` varchar(255) default NULL,
  `last_educat` varchar(255) default NULL,
  `major` varchar(255) default NULL,
  `power` int(11) NOT NULL,
  `get_double_teacher_time` datetime default NULL,
  `graduate_sch_name` varchar(255) default NULL,
  `graduate_sch_type` varchar(255) default NULL,
  `obtain_offer_time` datetime default NULL,
  `teach_date` datetime default NULL,
  `teach_this_major_time` int(11) default NULL,
  `training_time` int(11) default NULL,
  `subject` varchar(255) default NULL,
  `cer_profesion` varchar(255) default NULL,
  `cer_major` varchar(255) default NULL,
  `status` int(11) default NULL,
  `checkRemarks` varchar(255) default NULL,
  `school_code` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id_card` (`id_card`),
  KEY `FKAA31CBE21FA2C098` (`school_code`),
  CONSTRAINT `FKAA31CBE21FA2C098` FOREIGN KEY (`school_code`) REFERENCES `school` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `teacher`
--


/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
LOCK TABLES `teacher` WRITE;
INSERT INTO `teacher` VALUES (1,'360421199004052438','052438','wuge','male         ',32,'2044-09-30 00:00:00','计信院        ','临淄         ','秦始皇         ','88888888         ','www.baidu.com         ','中国         ','汉         ','党员         ','本科         ','博士     , 博士','网络工和         ',0,'2012-05-04 00:00:00','南京大学         ','重点大学','2012-04-02 00:00:00','2008-04-03 00:00:00',24,NULL,'不知道','高级','国家',0,NULL,'1111111'),(3,'360421199004052430','052430','钱枫',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,'1111111');
UNLOCK TABLES;
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;

--
-- Table structure for table `train_base`
--

DROP TABLE IF EXISTS `train_base`;
CREATE TABLE `train_base` (
  `code` varchar(255) NOT NULL,
  `name` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `postcode` varchar(255) default NULL,
  `fax` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `property` varchar(255) default NULL,
  `school` varchar(255) default NULL,
  `type` varchar(255) default NULL,
  `manager_number` int(11) default NULL,
  `bed_number` int(11) default NULL,
  `principal` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `train_base`
--


/*!40000 ALTER TABLE `train_base` DISABLE KEYS */;
LOCK TABLES `train_base` WRITE;
INSERT INTO `train_base` VALUES ('2012','水漫庭','133','www.jxau.cn','330045','34567890','www.gmail@.com','国家','共产主义劳动大学',NULL,48,32,'校长','志敏大道');
UNLOCK TABLES;
/*!40000 ALTER TABLE `train_base` ENABLE KEYS */;

--
-- Table structure for table `trained`
--

DROP TABLE IF EXISTS `trained`;
CREATE TABLE `trained` (
  `id` int(11) NOT NULL auto_increment,
  `grade` varchar(255) default NULL,
  `time` datetime default NULL,
  `major` varchar(255) default NULL,
  `course` varchar(255) default NULL,
  `addr` varchar(255) default NULL,
  `dispatch` varchar(255) default NULL,
  `practice_time` datetime default NULL,
  `practice_name` varchar(255) default NULL,
  `practice_content` varchar(255) default NULL,
  `id_card` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKC0639CA7DAD1C3CA` (`id_card`),
  CONSTRAINT `FKC0639CA7DAD1C3CA` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`),
  CONSTRAINT `trained_ibfk_1` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `trained`
--


/*!40000 ALTER TABLE `trained` DISABLE KEYS */;
LOCK TABLES `trained` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `trained` ENABLE KEYS */;

--
-- Table structure for table `training_info`
--

DROP TABLE IF EXISTS `training_info`;
CREATE TABLE `training_info` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `nation` varchar(255) default NULL,
  `sex` varchar(255) default NULL,
  `id_card` varchar(255) default NULL,
  `school` varchar(255) default NULL,
  `specialty` varchar(255) default NULL,
  `training_course` varchar(255) default NULL,
  `training_time` datetime default NULL,
  `training_type` varchar(255) default NULL,
  `major` varchar(255) default NULL,
  `graduate_time` datetime default NULL,
  `educate` varchar(255) default NULL,
  `position_name` varchar(255) default NULL,
  `teach_course1` varchar(255) default NULL,
  `teach_course2` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `training_info`
--


/*!40000 ALTER TABLE `training_info` DISABLE KEYS */;
LOCK TABLES `training_info` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `training_info` ENABLE KEYS */;

--
-- Table structure for table `ttinfo`
--

DROP TABLE IF EXISTS `ttinfo`;
CREATE TABLE `ttinfo` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `id_card` varchar(255) NOT NULL,
  `sex` varchar(255) default NULL,
  `birthday` datetime default NULL,
  `school` varchar(255) default NULL,
  `graduate_school` varchar(255) default NULL,
  `major` varchar(255) default NULL,
  `teach_major` varchar(255) default NULL,
  `teach_course` varchar(255) default NULL,
  `position` varchar(255) default NULL,
  `degree` varchar(255) default NULL,
  `edubg` varchar(255) default NULL,
  `postcode` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `qq` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKCC86332EDAD1C3CA` (`id_card`),
  CONSTRAINT `FKCC86332EDAD1C3CA` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`),
  CONSTRAINT `ttinfo_ibfk_1` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `ttinfo`
--


/*!40000 ALTER TABLE `ttinfo` DISABLE KEYS */;
LOCK TABLES `ttinfo` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `ttinfo` ENABLE KEYS */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `power` int(11) default NULL,
  `code` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';

--
-- Dumping data for table `user`
--


/*!40000 ALTER TABLE `user` DISABLE KEYS */;
LOCK TABLES `user` WRITE;
INSERT INTO `user` VALUES (1,'dong','dong',1,NULL),(2,'nan','nan',2,NULL),(3,'xi','xi',3,'2012'),(4,'bei','bei',4,'1111111'),(5,'东哥','dongge',1,NULL),(6,'南哥','dongge',2,NULL),(7,'西哥','dongge',3,NULL),(8,'北哥','dongge',4,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

