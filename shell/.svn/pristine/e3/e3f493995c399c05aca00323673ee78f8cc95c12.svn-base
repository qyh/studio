-- MySQL dump 10.13  Distrib 5.1.61, for redhat-linux-gnu (x86_64)
--
-- Host: 192.168.30.10    Database: dlog4j
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
-- Table structure for table `dlog_bookmark`
--

DROP TABLE IF EXISTS `dlog_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_bookmark` (
  `markid` int(11) NOT NULL,
  `logid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `marktype` int(11) NOT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `markorder` int(11) NOT NULL,
  PRIMARY KEY (`markid`),
  KEY `userbook_FK` (`userid`),
  KEY `booklog_FK` (`logid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_bookmark`
--

LOCK TABLES `dlog_bookmark` WRITE;
/*!40000 ALTER TABLE `dlog_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_category`
--

DROP TABLE IF EXISTS `dlog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_category` (
  `catid` int(11) NOT NULL,
  `siteid` int(11) DEFAULT NULL,
  `catname` varchar(40) NOT NULL,
  `iconurl` varchar(20) DEFAULT NULL,
  `cattype` int(11) NOT NULL,
  `showInHome` int(11) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  PRIMARY KEY (`catid`),
  KEY `catsite_FK` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_category`
--

LOCK TABLES `dlog_category` WRITE;
/*!40000 ALTER TABLE `dlog_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_favorite`
--

DROP TABLE IF EXISTS `dlog_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_favorite` (
  `favid` int(11) NOT NULL,
  `siteid` int(11) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `detail` text,
  `url` varchar(250) NOT NULL,
  `mode` varchar(5) DEFAULT NULL,
  `in_new_wnd` int(11) NOT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sortOrder` int(11) NOT NULL,
  PRIMARY KEY (`favid`),
  KEY `sitelink_FK` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_favorite`
--

LOCK TABLES `dlog_favorite` WRITE;
/*!40000 ALTER TABLE `dlog_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_journal`
--

DROP TABLE IF EXISTS `dlog_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_journal` (
  `logid` int(11) NOT NULL,
  `catid` int(11) DEFAULT NULL,
  `siteid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `author_url` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `content` text,
  `logkeys` varchar(40) DEFAULT NULL,
  `logTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `refUrl` varchar(100) DEFAULT NULL,
  `weather` varchar(20) NOT NULL,
  `moodLevel` int(11) DEFAULT NULL,
  `replyNotify` int(11) DEFAULT NULL,
  `clientType` varchar(5) NOT NULL,
  `viewcount` int(11) NOT NULL,
  `replyCount` int(11) NOT NULL,
  `delete_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` int(11) NOT NULL,
  PRIMARY KEY (`logid`),
  KEY `loguser_FK` (`userid`),
  KEY `journal_category_FK` (`catid`),
  KEY `sitelog_FK` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_journal`
--

LOCK TABLES `dlog_journal` WRITE;
/*!40000 ALTER TABLE `dlog_journal` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_message`
--

DROP TABLE IF EXISTS `dlog_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_message` (
  `msgid` int(11) NOT NULL,
  `fromUserId` int(11) NOT NULL,
  `toUserId` int(11) NOT NULL,
  `content` text NOT NULL,
  `sendTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `readTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` int(11) NOT NULL,
  PRIMARY KEY (`msgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_message`
--

LOCK TABLES `dlog_message` WRITE;
/*!40000 ALTER TABLE `dlog_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_param`
--

DROP TABLE IF EXISTS `dlog_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_param` (
  `p_id` int(11) NOT NULL,
  `siteid` int(11) DEFAULT NULL,
  `p_name` varchar(20) NOT NULL,
  `p_desc` varchar(100) DEFAULT NULL,
  `p_type` int(11) NOT NULL,
  `p_value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`p_id`),
  KEY `siteparam_FK` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_param`
--

LOCK TABLES `dlog_param` WRITE;
/*!40000 ALTER TABLE `dlog_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_reference`
--

DROP TABLE IF EXISTS `dlog_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_reference` (
  `refid` int(11) NOT NULL,
  `logid` int(11) DEFAULT NULL,
  `refurl` varchar(100) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `excerpt` varchar(200) DEFAULT NULL,
  `blog_name` varchar(50) NOT NULL,
  `remoteAddr` char(15) NOT NULL,
  `reftime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`refid`),
  KEY `logref_FK` (`logid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_reference`
--

LOCK TABLES `dlog_reference` WRITE;
/*!40000 ALTER TABLE `dlog_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_reply`
--

DROP TABLE IF EXISTS `dlog_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_reply` (
  `cmtid` int(11) NOT NULL,
  `siteid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `logid` int(11) DEFAULT NULL,
  `content` text,
  `writetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `clientType` varchar(5) NOT NULL,
  PRIMARY KEY (`cmtid`),
  KEY `logcomment_FK` (`logid`),
  KEY `cmtuser_FK` (`userid`),
  KEY `sitereply_FK` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_reply`
--

LOCK TABLES `dlog_reply` WRITE;
/*!40000 ALTER TABLE `dlog_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_site`
--

DROP TABLE IF EXISTS `dlog_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_site` (
  `siteid` int(11) NOT NULL,
  `sitename` varchar(20) NOT NULL,
  `displayName` varchar(100) NOT NULL,
  `sitetitle` varchar(200) DEFAULT NULL,
  `sitedetail` text,
  `siteicon` varchar(50) DEFAULT NULL,
  `sitelogo` varchar(50) DEFAULT NULL,
  `cssfile` varchar(50) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `siteurl` varchar(100) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_site`
--

LOCK TABLES `dlog_site` WRITE;
/*!40000 ALTER TABLE `dlog_site` DISABLE KEYS */;
INSERT INTO `dlog_site` VALUES (1,'dlog','MY BLOG...',NULL,'MY BLOG...',NULL,NULL,NULL,'2012-04-08 11:14:37','2012-04-08 11:14:38',NULL,1);
/*!40000 ALTER TABLE `dlog_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_user`
--

DROP TABLE IF EXISTS `dlog_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_user` (
  `userid` int(11) NOT NULL,
  `siteid` int(11) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `displayName` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `homepage` varchar(100) DEFAULT NULL,
  `resume` varchar(250) DEFAULT NULL,
  `logincount` int(11) DEFAULT NULL,
  `regTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastAddr` varchar(16) DEFAULT NULL,
  `userRole` int(11) NOT NULL,
  `ownerCats` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `site_user_FK` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_user`
--

LOCK TABLES `dlog_user` WRITE;
/*!40000 ALTER TABLE `dlog_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_visit`
--

DROP TABLE IF EXISTS `dlog_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_visit` (
  `visit_id` int(11) NOT NULL,
  `siteid` int(11) DEFAULT NULL,
  `visit_date` int(11) NOT NULL,
  `visit_week` int(11) NOT NULL,
  `pageViewCount` int(11) NOT NULL,
  `sessionCount` int(11) NOT NULL,
  PRIMARY KEY (`visit_id`),
  KEY `site_visit_FK` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_visit`
--

LOCK TABLES `dlog_visit` WRITE;
/*!40000 ALTER TABLE `dlog_visit` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_visitdetail`
--

DROP TABLE IF EXISTS `dlog_visitdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_visitdetail` (
  `detail_id` int(11) NOT NULL,
  `siteid` int(11) DEFAULT NULL,
  `remoteAddr` varchar(15) NOT NULL,
  `requestURL` varchar(100) NOT NULL,
  `userAgent` varchar(100) DEFAULT NULL,
  `refererURL` varchar(100) DEFAULT NULL,
  `visitTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`detail_id`),
  KEY `site_vd_FK` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_visitdetail`
--

LOCK TABLES `dlog_visitdetail` WRITE;
/*!40000 ALTER TABLE `dlog_visitdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_visitdetail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-04-10 17:58:06
