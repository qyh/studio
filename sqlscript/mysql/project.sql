-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	5.1.40-community

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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expect_train` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `site` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `pattern` varchar(255) DEFAULT NULL,
  `emphasis` varchar(255) DEFAULT NULL,
  `ausbilder` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK86DAA2DAD1C3CA` (`id_card`),
  CONSTRAINT `FK86DAA2DAD1C3CA` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expect_train`
--

LOCK TABLES `expect_train` WRITE;
/*!40000 ALTER TABLE `expect_train` DISABLE KEYS */;
/*!40000 ALTER TABLE `expect_train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `odtbinfo`
--

DROP TABLE IF EXISTS `odtbinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `odtbinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `base_code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK801A26319E21BEC8` (`base_code`),
  CONSTRAINT `FK801A26319E21BEC8` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `odtbinfo`
--

LOCK TABLES `odtbinfo` WRITE;
/*!40000 ALTER TABLE `odtbinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `odtbinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_info`
--

DROP TABLE IF EXISTS `offer_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `office` varchar(255) DEFAULT NULL,
  `enterprise` varchar(255) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teacher_id` (`teacher_id`),
  KEY `FK99E1CB1313426AE` (`teacher_id`),
  CONSTRAINT `FK99E1CB1313426AE` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_info`
--

LOCK TABLES `offer_info` WRITE;
/*!40000 ALTER TABLE `offer_info` DISABLE KEYS */;
INSERT INTO `offer_info` VALUES (1,NULL,'Microsft',1);
/*!40000 ALTER TABLE `offer_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_info_temp`
--

DROP TABLE IF EXISTS `offer_info_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_info_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `office` varchar(255) DEFAULT NULL,
  `enterprise` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_info_temp`
--

LOCK TABLES `offer_info_temp` WRITE;
/*!40000 ALTER TABLE `offer_info_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_info_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part_time_job`
--

DROP TABLE IF EXISTS `part_time_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `part_time_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teacher_id` (`teacher_id`),
  KEY `FKCC597E17313426AE` (`teacher_id`),
  CONSTRAINT `FKCC597E17313426AE` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part_time_job`
--

LOCK TABLES `part_time_job` WRITE;
/*!40000 ALTER TABLE `part_time_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_time_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part_time_job_temp`
--

DROP TABLE IF EXISTS `part_time_job_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `part_time_job_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part_time_job_temp`
--

LOCK TABLES `part_time_job_temp` WRITE;
/*!40000 ALTER TABLE `part_time_job_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_time_job_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `office` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teacher_id` (`teacher_id`),
  KEY `FK2C929929313426AE` (`teacher_id`),
  CONSTRAINT `FK2C929929313426AE` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES (1,'Position',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position_temp`
--

DROP TABLE IF EXISTS `position_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `office` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position_temp`
--

LOCK TABLES `position_temp` WRITE;
/*!40000 ALTER TABLE `position_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `position_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pre_spe`
--

DROP TABLE IF EXISTS `pre_spe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pre_spe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  `base_code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKECFE960C9E21BEC8` (`base_code`),
  CONSTRAINT `FKECFE960C9E21BEC8` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pre_spe`
--

LOCK TABLES `pre_spe` WRITE;
/*!40000 ALTER TABLE `pre_spe` DISABLE KEYS */;
/*!40000 ALTER TABLE `pre_spe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prize`
--

DROP TABLE IF EXISTS `prize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prize` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` varchar(255) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `issuer` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK65FB412DAD1C3CA` (`id_card`),
  CONSTRAINT `FK65FB412DAD1C3CA` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prize`
--

LOCK TABLES `prize` WRITE;
/*!40000 ALTER TABLE `prize` DISABLE KEYS */;
/*!40000 ALTER TABLE `prize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prize_temp`
--

DROP TABLE IF EXISTS `prize_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prize_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` varchar(255) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `issuer` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `original_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prize_temp`
--

LOCK TABLES `prize_temp` WRITE;
/*!40000 ALTER TABLE `prize_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `prize_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profession`
--

DROP TABLE IF EXISTS `profession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profession` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profession`
--

LOCK TABLES `profession` WRITE;
/*!40000 ALTER TABLE `profession` DISABLE KEYS */;
/*!40000 ALTER TABLE `profession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `questionnaire_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKBA823BE6A73A4C0E` (`questionnaire_id`),
  CONSTRAINT `FKBA823BE6A73A4C0E` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire`
--

DROP TABLE IF EXISTS `questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `base_code` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionnaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sch_pro`
--

DROP TABLE IF EXISTS `sch_pro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sch_pro` (
  `school_code` varchar(255) NOT NULL,
  `profession_id` int(11) NOT NULL,
  PRIMARY KEY (`profession_id`,`school_code`),
  KEY `FK7242D206C60CCB86` (`profession_id`),
  KEY `FK7242D2061FA2C098` (`school_code`),
  CONSTRAINT `FK7242D2061FA2C098` FOREIGN KEY (`school_code`) REFERENCES `school` (`code`),
  CONSTRAINT `FK7242D206C60CCB86` FOREIGN KEY (`profession_id`) REFERENCES `profession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sch_pro`
--

LOCK TABLES `sch_pro` WRITE;
/*!40000 ALTER TABLE `sch_pro` DISABLE KEYS */;
/*!40000 ALTER TABLE `sch_pro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school` (
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `property` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `superior_depart` varchar(255) DEFAULT NULL,
  `stu_num` int(11) DEFAULT NULL,
  `staff` int(11) DEFAULT NULL,
  `teacher_num` int(11) DEFAULT NULL,
  `managers` int(11) DEFAULT NULL,
  `ss_ratio` float DEFAULT NULL,
  `st_ratio` float DEFAULT NULL,
  `area` float DEFAULT NULL,
  `build_sides` float DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `county` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `sch_property` varchar(255) DEFAULT NULL,
  `sch_rank` varchar(255) DEFAULT NULL,
  `sch_depart` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` VALUES ('3306',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sotb`
--

DROP TABLE IF EXISTS `sotb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sotb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `days` int(11) DEFAULT NULL,
  `nop` int(11) DEFAULT NULL,
  `base_code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK35F5CA9E21BEC8` (`base_code`),
  CONSTRAINT `FK35F5CA9E21BEC8` FOREIGN KEY (`base_code`) REFERENCES `train_base` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sotb`
--

LOCK TABLES `sotb` WRITE;
/*!40000 ALTER TABLE `sotb` DISABLE KEYS */;
/*!40000 ALTER TABLE `sotb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teach_course`
--

DROP TABLE IF EXISTS `teach_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teach_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA5315725313426AE` (`teacher_id`),
  CONSTRAINT `FKA5315725313426AE` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teach_course`
--

LOCK TABLES `teach_course` WRITE;
/*!40000 ALTER TABLE `teach_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `teach_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teach_course_temp`
--

DROP TABLE IF EXISTS `teach_course_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teach_course_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `original_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teach_course_temp`
--

LOCK TABLES `teach_course_temp` WRITE;
/*!40000 ALTER TABLE `teach_course_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `teach_course_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_card` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `depart` varchar(255) DEFAULT NULL,
  `search_section` varchar(255) DEFAULT NULL,
  `administrative` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `native_place` varchar(255) DEFAULT NULL,
  `nation` varchar(255) DEFAULT NULL,
  `polity` varchar(255) DEFAULT NULL,
  `first_educat` varchar(255) DEFAULT NULL,
  `last_educat` varchar(255) DEFAULT NULL,
  `degree` varchar(255) DEFAULT NULL,
  `major` varchar(255) DEFAULT NULL,
  `teach_major` varchar(255) DEFAULT NULL,
  `teacher_type` varchar(255) DEFAULT NULL,
  `power` int(11) NOT NULL,
  `get_double_teacher_time` datetime DEFAULT NULL,
  `Staffing_situation` varchar(255) DEFAULT NULL,
  `pathway` varchar(255) DEFAULT NULL,
  `graduate_sch_name` varchar(255) DEFAULT NULL,
  `graduate_sch_type` varchar(255) DEFAULT NULL,
  `obtain_offer_time` datetime DEFAULT NULL,
  `teach_date` datetime DEFAULT NULL,
  `teach_this_major_time` int(11) DEFAULT NULL,
  `training_time` int(11) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `cer_profesion` varchar(255) DEFAULT NULL,
  `cer_major` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `checkRemarks` varchar(255) DEFAULT NULL,
  `school_code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_card` (`id_card`),
  KEY `FKAA31CBE21FA2C098` (`school_code`),
  CONSTRAINT `FKAA31CBE21FA2C098` FOREIGN KEY (`school_code`) REFERENCES `school` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,'123456',NULL,'Hello world',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL,'3306');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_temp`
--

DROP TABLE IF EXISTS `teacher_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_card` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `depart` varchar(255) DEFAULT NULL,
  `search_section` varchar(255) DEFAULT NULL,
  `administrative` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `native_place` varchar(255) DEFAULT NULL,
  `nation` varchar(255) DEFAULT NULL,
  `polity` varchar(255) DEFAULT NULL,
  `first_educat` varchar(255) DEFAULT NULL,
  `last_educat` varchar(255) DEFAULT NULL,
  `degree` varchar(255) DEFAULT NULL,
  `major` varchar(255) DEFAULT NULL,
  `teach_major` varchar(255) DEFAULT NULL,
  `power` int(11) NOT NULL,
  `get_double_teacher_time` datetime DEFAULT NULL,
  `graduate_sch_name` varchar(255) DEFAULT NULL,
  `graduate_sch_type` varchar(255) DEFAULT NULL,
  `obtain_offer_time` datetime DEFAULT NULL,
  `teach_date` datetime DEFAULT NULL,
  `teach_this_major_time` int(11) DEFAULT NULL,
  `training_time` int(11) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `school_code` varchar(255) DEFAULT NULL,
  `teacher_type` varchar(255) DEFAULT NULL,
  `pathway` varchar(255) DEFAULT NULL,
  `staffing_situation` varchar(255) DEFAULT NULL,
  `cer_profesion` varchar(255) DEFAULT NULL,
  `cer_major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_card` (`id_card`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_temp`
--

LOCK TABLES `teacher_temp` WRITE;
/*!40000 ALTER TABLE `teacher_temp` DISABLE KEYS */;
INSERT INTO `teacher_temp` VALUES (1,'123456',NULL,'temp',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `teacher_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_base`
--

DROP TABLE IF EXISTS `train_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `train_base` (
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `property` varchar(255) DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `manager_number` int(11) DEFAULT NULL,
  `bed_number` int(11) DEFAULT NULL,
  `principal` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_base`
--

LOCK TABLES `train_base` WRITE;
/*!40000 ALTER TABLE `train_base` DISABLE KEYS */;
/*!40000 ALTER TABLE `train_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trained`
--

DROP TABLE IF EXISTS `trained`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trained` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `major` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `dispatch` varchar(255) DEFAULT NULL,
  `practice_time` datetime DEFAULT NULL,
  `practice_name` varchar(255) DEFAULT NULL,
  `practice_content` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC0639CA7DAD1C3CA` (`id_card`),
  CONSTRAINT `FKC0639CA7DAD1C3CA` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trained`
--

LOCK TABLES `trained` WRITE;
/*!40000 ALTER TABLE `trained` DISABLE KEYS */;
/*!40000 ALTER TABLE `trained` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trained_temp`
--

DROP TABLE IF EXISTS `trained_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trained_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `major` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `dispatch` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `practice_time` datetime DEFAULT NULL,
  `practice_name` varchar(255) DEFAULT NULL,
  `practice_content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trained_temp`
--

LOCK TABLES `trained_temp` WRITE;
/*!40000 ALTER TABLE `trained_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `trained_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_info`
--

DROP TABLE IF EXISTS `training_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nation` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `training_course` varchar(255) DEFAULT NULL,
  `training_time` datetime DEFAULT NULL,
  `training_type` varchar(255) DEFAULT NULL,
  `major` varchar(255) DEFAULT NULL,
  `graduate_time` datetime DEFAULT NULL,
  `educate` varchar(255) DEFAULT NULL,
  `position_name` varchar(255) DEFAULT NULL,
  `teach_course1` varchar(255) DEFAULT NULL,
  `teach_course2` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_info`
--

LOCK TABLES `training_info` WRITE;
/*!40000 ALTER TABLE `training_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `training_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ttinfo`
--

DROP TABLE IF EXISTS `ttinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) NOT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `graduate_school` varchar(255) DEFAULT NULL,
  `major` varchar(255) DEFAULT NULL,
  `teach_major` varchar(255) DEFAULT NULL,
  `teach_course` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `degree` varchar(255) DEFAULT NULL,
  `edubg` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCC86332EDAD1C3CA` (`id_card`),
  CONSTRAINT `FKCC86332EDAD1C3CA` FOREIGN KEY (`id_card`) REFERENCES `teacher` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ttinfo`
--

LOCK TABLES `ttinfo` WRITE;
/*!40000 ALTER TABLE `ttinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ttinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `power` int(11) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-11-16 14:44:06
