-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: localhost    Database: ssh
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
-- Table structure for table `dormitory_fee`
--

DROP TABLE IF EXISTS `dormitory_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dormitory_fee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `balance` float DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `fee` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dormitory_fee`
--

LOCK TABLES `dormitory_fee` WRITE;
/*!40000 ALTER TABLE `dormitory_fee` DISABLE KEYS */;
INSERT INTO `dormitory_fee` VALUES (14,'交费','2011-11-07 00:00:00',200,'每人交50',-200),(15,'电费','2011-11-07 00:00:00',150,'电费',50),(16,'水费','2011-11-14 18:46:59',143.5,'',6.5),(17,'水费','2010-10-12 18:52:20',137,'',6.5),(18,'水费','2010-11-01 18:53:08',130.5,'',6.5),(19,'水费','2010-10-31 19:13:25',124,'',6.5),(20,'水费','2011-10-11 19:17:59',117.5,'',6.5),(21,'水费','2011-11-14 19:42:45',111,'',6.5),(22,'电费','2011-11-14 19:58:58',11,'',100),(23,'水费','2011-11-14 20:09:34',4.5,'',6.5),(24,'水费','2011-11-14 20:10:21',-2,'',6.5),(25,'水费','2011-11-14 20:14:05',-8.5,'',6.5),(26,'水费','2011-11-14 20:16:06',-15,'',6.5),(27,'水费','2011-11-14 20:18:05',-21.5,'',6.5),(28,'水费','2011-11-14 20:20:28',-28,'',6.5);
/*!40000 ALTER TABLE `dormitory_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (2,'update_person'),(3,'Herenate person'),(4,'Herenate person'),(5,'Herenate person'),(6,'Herenate person'),(7,'Herenate person'),(8,'Herenate person'),(9,'HelloAdd'),(10,'add_again'),(11,'123242423'),(12,'ererte'),(13,'你好'),(14,'世界'),(15,'计算机'),(16,'hibernate');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `c` varchar(255) DEFAULT NULL,
  `tele` varchar(255) DEFAULT NULL,
  `score` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,NULL,'student',NULL,NULL,NULL),(2,'20092214','student',NULL,NULL,NULL),(3,'20092217','student',NULL,NULL,NULL),(4,'20092218','student',NULL,NULL,NULL),(5,'20092215','qinyanhong',NULL,NULL,NULL),(6,'Hello','123456',NULL,NULL,NULL),(7,'Hello','123456',NULL,NULL,NULL),(8,'Helloworld','sdkfskdfskdfsd',NULL,NULL,NULL),(10,'2009221121','student',NULL,NULL,NULL),(11,'Helloworld4543','sdsdfsd2342343',NULL,NULL,NULL),(12,'454654','werwwe',NULL,NULL,NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-11-16 14:44:07
