-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: 192.168.137.115    Database: ssh
-- ------------------------------------------------------
-- Server version	5.1.47

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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dormitory_fee`
--

LOCK TABLES `dormitory_fee` WRITE;
/*!40000 ALTER TABLE `dormitory_fee` DISABLE KEYS */;
INSERT INTO `dormitory_fee` VALUES (17,'交费','2011-09-15 00:00:00',205,'每人交50',-205),(18,'水费','2011-09-15 00:00:00',198.5,'',6.5),(19,'水费','2011-09-21 00:00:00',192,'',6.5),(20,'大功率断电','2011-09-22 00:00:00',182,'大功率断电',10),(21,'水费','2011-09-27 00:00:00',175.5,'',6.5),(22,'电费','2011-09-29 00:00:00',75.5,'',100),(23,'水费','2011-10-04 00:00:00',69,'',6.5),(24,'水费','2011-10-11 00:00:00',62.5,'',6.5),(25,'水费','2011-10-18 00:00:00',56,'',6.5),(26,'水费','2011-10-22 00:00:00',49.5,'',6.5),(27,'水费','2011-10-28 00:00:00',43,'',6.5),(28,'水费','2011-11-08 00:00:00',36.5,'',6.5),(29,'电费','2011-11-14 00:00:00',-63.5,'',100),(33,'水费','2011-11-16 08:58:11',-70,'',6.5),(34,'异常断电','2011-11-17 08:59:35',-80,'吴',10),(35,'交费','2011-11-18 19:29:46',120,'每人交50',-200);
/*!40000 ALTER TABLE `dormitory_fee` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-11-19 21:24:04
