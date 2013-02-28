-- MySQL dump 10.13  Distrib 5.1.61, for redhat-linux-gnu (x86_64)
--
-- Host: 192.168.30.10    Database: pdlog
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
-- Table structure for table `dlog_album`
--

DROP TABLE IF EXISTS `dlog_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_album` (
  `album_id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_id` int(11) DEFAULT NULL,
  `dlo_album_id` int(11) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `dlog_type_id` int(11) DEFAULT NULL,
  `album_name` varchar(40) NOT NULL,
  `album_desc` varchar(200) DEFAULT NULL,
  `photo_count` int(11) NOT NULL,
  `album_type` int(11) NOT NULL,
  `verifycode` varchar(20) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`album_id`),
  KEY `r_site_album_fk` (`site_id`),
  KEY `r_album_fk` (`dlo_album_id`),
  KEY `r_album_type_fk` (`dlog_type_id`),
  KEY `r_album_cover_fk` (`photo_id`),
  CONSTRAINT `fk_r_site_album` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`),
  CONSTRAINT `fk_r_album` FOREIGN KEY (`dlo_album_id`) REFERENCES `dlog_album` (`album_id`),
  CONSTRAINT `fk_r_album_cover` FOREIGN KEY (`photo_id`) REFERENCES `dlog_photo` (`photo_id`),
  CONSTRAINT `fk_r_album_type` FOREIGN KEY (`dlog_type_id`) REFERENCES `dlog_type` (`dlog_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_album`
--

LOCK TABLES `dlog_album` WRITE;
/*!40000 ALTER TABLE `dlog_album` DISABLE KEYS */;
INSERT INTO `dlog_album` VALUES (1,NULL,NULL,1,NULL,'sdf',NULL,0,0,NULL,1,'2012-04-08 20:14:45');
/*!40000 ALTER TABLE `dlog_album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_blocked_ip`
--

DROP TABLE IF EXISTS `dlog_blocked_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_blocked_ip` (
  `blocked_ip_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `ip_addr` int(11) NOT NULL,
  `s_ip_addr` varchar(16) NOT NULL,
  `ip_mask` int(11) NOT NULL,
  `s_ip_mask` varchar(16) NOT NULL,
  `blocked_type` smallint(6) NOT NULL,
  `blocked_time` datetime NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`blocked_ip_id`),
  KEY `r_site_blocked_ip_fk` (`site_id`),
  CONSTRAINT `fk_r_site_blocked_ip` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_blocked_ip`
--

LOCK TABLES `dlog_blocked_ip` WRITE;
/*!40000 ALTER TABLE `dlog_blocked_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_blocked_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_bookmark`
--

DROP TABLE IF EXISTS `dlog_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_bookmark` (
  `mark_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `parent_type` smallint(6) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`mark_id`),
  KEY `r_user_mark_fk` (`userid`),
  KEY `r_site_bookmark_fk` (`site_id`),
  CONSTRAINT `fk_r_user_mark` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_site_bookmark` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_bookmark`
--

LOCK TABLES `dlog_bookmark` WRITE;
/*!40000 ALTER TABLE `dlog_bookmark` DISABLE KEYS */;
INSERT INTO `dlog_bookmark` VALUES (1,1,1,1,1,'C',NULL,'2012-04-08 20:07:23'),(2,1,1,1,5,'DLOG of 管理员',NULL,'2012-04-08 20:12:16');
/*!40000 ALTER TABLE `dlog_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_bulletin`
--

DROP TABLE IF EXISTS `dlog_bulletin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_bulletin` (
  `bulletin_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `bulletin_type` int(11) NOT NULL,
  `pub_time` datetime NOT NULL,
  `status` smallint(6) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`bulletin_id`),
  KEY `r_site_bulletin_fk` (`site_id`),
  CONSTRAINT `fk_r_site_bulletin` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_bulletin`
--

LOCK TABLES `dlog_bulletin` WRITE;
/*!40000 ALTER TABLE `dlog_bulletin` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_bulletin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_catalog`
--

DROP TABLE IF EXISTS `dlog_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_catalog` (
  `catalog_id` int(11) NOT NULL AUTO_INCREMENT,
  `dlog_type_id` int(11) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `catalog_name` varchar(20) NOT NULL,
  `catalog_desc` varchar(200) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `article_count` int(11) NOT NULL,
  `catalog_type` smallint(6) NOT NULL,
  `verifycode` varchar(20) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`catalog_id`),
  KEY `r_site_catalog_fk` (`site_id`),
  KEY `r_catalog_type_fk` (`dlog_type_id`),
  CONSTRAINT `fk_r_site_catalog` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`),
  CONSTRAINT `fk_r_catalog_type` FOREIGN KEY (`dlog_type_id`) REFERENCES `dlog_type` (`dlog_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_catalog`
--

LOCK TABLES `dlog_catalog` WRITE;
/*!40000 ALTER TABLE `dlog_catalog` DISABLE KEYS */;
INSERT INTO `dlog_catalog` VALUES (1,NULL,1,'C',NULL,'2012-04-08 20:06:53',1,1,NULL,1);
/*!40000 ALTER TABLE `dlog_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_catalog_perm`
--

DROP TABLE IF EXISTS `dlog_catalog_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_catalog_perm` (
  `catalog_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `user_role` int(11) NOT NULL,
  PRIMARY KEY (`catalog_id`,`userid`),
  KEY `dlog_catalog_perm_fk` (`catalog_id`),
  KEY `dlog_catalog_perm2_fk` (`userid`),
  CONSTRAINT `fk_dlog_catalog_perm2` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_dlog_catalog_perm` FOREIGN KEY (`catalog_id`) REFERENCES `dlog_catalog` (`catalog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_catalog_perm`
--

LOCK TABLES `dlog_catalog_perm` WRITE;
/*!40000 ALTER TABLE `dlog_catalog_perm` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_catalog_perm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_comments`
--

DROP TABLE IF EXISTS `dlog_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `dlo_comment_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `entity_id` int(11) NOT NULL,
  `entity_type` int(11) NOT NULL,
  `client_ip` varchar(16) NOT NULL,
  `client_type` smallint(6) NOT NULL,
  `client_user_agent` varchar(100) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `author` varchar(20) NOT NULL,
  `author_email` varchar(50) DEFAULT NULL,
  `author_url` varchar(100) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `content_format` smallint(6) NOT NULL,
  `comment_time` datetime NOT NULL,
  `comment_flag` smallint(6) NOT NULL,
  `comment_status` smallint(6) NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `r_sub_comment_fk` (`dlo_comment_id`),
  KEY `r_site_comment_fk` (`site_id`),
  CONSTRAINT `fk_r_sub_comment` FOREIGN KEY (`dlo_comment_id`) REFERENCES `dlog_comments` (`comment_id`),
  CONSTRAINT `fk_r_site_comment` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_comments`
--

LOCK TABLES `dlog_comments` WRITE;
/*!40000 ALTER TABLE `dlog_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_config`
--

DROP TABLE IF EXISTS `dlog_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `config_name` varchar(20) NOT NULL,
  `int_value` int(11) DEFAULT NULL,
  `string_value` varchar(100) DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `time_value` time DEFAULT NULL,
  `timestamp_value` datetime DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`config_id`),
  KEY `r_site_config_fk` (`site_id`),
  CONSTRAINT `fk_r_site_config` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_config`
--

LOCK TABLES `dlog_config` WRITE;
/*!40000 ALTER TABLE `dlog_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_diary`
--

DROP TABLE IF EXISTS `dlog_diary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_diary` (
  `diary_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `catalog_id` int(11) NOT NULL,
  `author` varchar(20) NOT NULL,
  `author_url` varchar(100) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `diary_size` int(11) NOT NULL,
  `refer` varchar(100) DEFAULT NULL,
  `weather` varchar(20) NOT NULL,
  `mood_level` smallint(6) NOT NULL,
  `tags` varchar(100) DEFAULT NULL,
  `bgsound` int(11) DEFAULT NULL,
  `reply_count` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `tb_count` int(11) NOT NULL,
  `client_type` smallint(6) NOT NULL,
  `client_ip` varchar(16) NOT NULL,
  `client_user_agent` varchar(100) DEFAULT NULL,
  `write_time` datetime NOT NULL,
  `last_read_time` datetime DEFAULT NULL,
  `last_reply_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `reply_notify` smallint(6) NOT NULL,
  `diary_type` smallint(6) NOT NULL,
  `locked` smallint(6) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`diary_id`),
  KEY `r_site_journal_fk` (`site_id`),
  KEY `r_catalog_diary_fk` (`catalog_id`),
  KEY `r_user_journal_fk` (`userid`),
  CONSTRAINT `fk_r_user_journal` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_catalog_diary` FOREIGN KEY (`catalog_id`) REFERENCES `dlog_catalog` (`catalog_id`),
  CONSTRAINT `fk_r_site_journal` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_diary`
--

LOCK TABLES `dlog_diary` WRITE;
/*!40000 ALTER TABLE `dlog_diary` DISABLE KEYS */;
INSERT INTO `dlog_diary` VALUES (1,1,1,1,'管理员','/dlog/viewuser.vm?uid=1','C','Hello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C\r\nv\r\nHello world C\r\nHello world C\r\nHello world C\r\nHello world C',970,NULL,'sunny',5,'C',NULL,1,11,0,0,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.151 Saf...','2012-04-08 20:07:23','2012-04-08 21:29:06','2012-04-08 20:10:56','2012-04-08 20:10:19',0,0,0,0);
/*!40000 ALTER TABLE `dlog_diary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_external_refer`
--

DROP TABLE IF EXISTS `dlog_external_refer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_external_refer` (
  `refer_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `ref_id` int(11) NOT NULL,
  `ref_type` smallint(6) NOT NULL,
  `refer_host` varchar(50) DEFAULT NULL,
  `refer_url` varchar(250) NOT NULL,
  `client_ip` varchar(16) NOT NULL,
  `refer_time` datetime NOT NULL,
  PRIMARY KEY (`refer_id`),
  KEY `r_site_refer_fk` (`site_id`),
  CONSTRAINT `fk_r_site_refer` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_external_refer`
--

LOCK TABLES `dlog_external_refer` WRITE;
/*!40000 ALTER TABLE `dlog_external_refer` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_external_refer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_fck_upload_file`
--

DROP TABLE IF EXISTS `dlog_fck_upload_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_fck_upload_file` (
  `fck_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `upload_time` datetime NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `ref_id` int(11) NOT NULL,
  `ref_type` smallint(6) NOT NULL,
  `save_path` varchar(255) NOT NULL,
  `file_uri` varchar(100) NOT NULL,
  `file_type` int(11) NOT NULL,
  `file_size` int(11) NOT NULL,
  PRIMARY KEY (`fck_file_id`),
  KEY `r_site_file_fk` (`site_id`),
  KEY `r_user_upload_fk` (`userid`),
  CONSTRAINT `fk_r_user_upload` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_site_file` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_fck_upload_file`
--

LOCK TABLES `dlog_fck_upload_file` WRITE;
/*!40000 ALTER TABLE `dlog_fck_upload_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_fck_upload_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_forum`
--

DROP TABLE IF EXISTS `dlog_forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_forum` (
  `forum_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `dlog_type_id` int(11) DEFAULT NULL,
  `forum_name` varchar(40) NOT NULL,
  `forum_desc` varchar(200) DEFAULT NULL,
  `forum_type` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_time` datetime DEFAULT NULL,
  `last_time` datetime DEFAULT NULL,
  `last_user_id` int(11) DEFAULT NULL,
  `last_user_name` varchar(50) DEFAULT NULL,
  `last_topic_id` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `topic_count` int(11) NOT NULL,
  `forum_option` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`forum_id`),
  KEY `r_site_forum_fk` (`site_id`),
  KEY `r_forum_type_fk` (`dlog_type_id`),
  CONSTRAINT `fk_r_site_forum` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`),
  CONSTRAINT `fk_r_forum_type` FOREIGN KEY (`dlog_type_id`) REFERENCES `dlog_type` (`dlog_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_forum`
--

LOCK TABLES `dlog_forum` WRITE;
/*!40000 ALTER TABLE `dlog_forum` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_friend`
--

DROP TABLE IF EXISTS `dlog_friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_friend` (
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `friend_type` int(11) NOT NULL,
  `friend_role` int(11) NOT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`friend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_friend`
--

LOCK TABLES `dlog_friend` WRITE;
/*!40000 ALTER TABLE `dlog_friend` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_guestbook`
--

DROP TABLE IF EXISTS `dlog_guestbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_guestbook` (
  `guest_book_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `client_type` smallint(6) NOT NULL,
  `client_ip` varchar(16) NOT NULL,
  `client_user_agent` varchar(100) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `reply_content` text,
  `reply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`guest_book_id`),
  KEY `r_site_guest_fk` (`site_id`),
  KEY `r_user_liuyan_fk` (`userid`),
  CONSTRAINT `fk_r_user_liuyan` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_site_guest` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_guestbook`
--

LOCK TABLES `dlog_guestbook` WRITE;
/*!40000 ALTER TABLE `dlog_guestbook` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_guestbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_j_reply`
--

DROP TABLE IF EXISTS `dlog_j_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_j_reply` (
  `j_reply_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `diary_id` int(11) NOT NULL,
  `author` varchar(20) NOT NULL,
  `author_url` varchar(100) DEFAULT NULL,
  `author_email` varchar(50) DEFAULT NULL,
  `client_type` smallint(6) NOT NULL,
  `client_ip` varchar(16) NOT NULL,
  `client_user_agent` varchar(100) DEFAULT NULL,
  `owner_only` int(11) NOT NULL,
  `content` text NOT NULL,
  `write_time` datetime NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`j_reply_id`),
  KEY `r_site_j_reply_fk` (`site_id`),
  KEY `r_journal_reply_fk` (`diary_id`),
  KEY `r_user_j_reply_fk` (`userid`),
  CONSTRAINT `fk_r_user_j_reply` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_journal_reply` FOREIGN KEY (`diary_id`) REFERENCES `dlog_diary` (`diary_id`),
  CONSTRAINT `fk_r_site_j_reply` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_j_reply`
--

LOCK TABLES `dlog_j_reply` WRITE;
/*!40000 ALTER TABLE `dlog_j_reply` DISABLE KEYS */;
INSERT INTO `dlog_j_reply` VALUES (1,1,1,1,'管理员',NULL,NULL,0,'127.0.0.1','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.151 Saf...',0,'XXXX pdlog','2012-04-08 20:10:56',0);
/*!40000 ALTER TABLE `dlog_j_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_link`
--

DROP TABLE IF EXISTS `dlog_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_link` (
  `linkid` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `link_title` varchar(40) NOT NULL,
  `link_url` varchar(200) NOT NULL,
  `link_type` smallint(6) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`linkid`),
  KEY `r_site_link_fk` (`site_id`),
  CONSTRAINT `fk_r_site_link` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_link`
--

LOCK TABLES `dlog_link` WRITE;
/*!40000 ALTER TABLE `dlog_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_message`
--

DROP TABLE IF EXISTS `dlog_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_message` (
  `msgid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `from_user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `send_time` datetime NOT NULL,
  `expire_time` datetime DEFAULT NULL,
  `read_time` datetime DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`msgid`),
  KEY `r_msg_receiver_fk` (`userid`),
  CONSTRAINT `fk_r_msg_receiver` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_message`
--

LOCK TABLES `dlog_message` WRITE;
/*!40000 ALTER TABLE `dlog_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_music`
--

DROP TABLE IF EXISTS `dlog_music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_music` (
  `music_id` int(11) NOT NULL AUTO_INCREMENT,
  `music_box_id` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `music_title` varchar(100) NOT NULL,
  `music_word` text,
  `album` varchar(100) DEFAULT NULL,
  `singer` varchar(50) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `view_count` int(11) NOT NULL,
  `music_type` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`music_id`),
  KEY `r_site_music_fk` (`site_id`),
  KEY `r_music_box_fk` (`music_box_id`),
  KEY `r_recommend_fk` (`userid`),
  CONSTRAINT `fk_r_site_music` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`),
  CONSTRAINT `fk_r_music_box` FOREIGN KEY (`music_box_id`) REFERENCES `dlog_musicbox` (`music_box_id`),
  CONSTRAINT `fk_r_recommend` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_music`
--

LOCK TABLES `dlog_music` WRITE;
/*!40000 ALTER TABLE `dlog_music` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_music` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_musicbox`
--

DROP TABLE IF EXISTS `dlog_musicbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_musicbox` (
  `music_box_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `box_name` varchar(40) NOT NULL,
  `box_desc` varchar(100) DEFAULT NULL,
  `music_count` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`music_box_id`),
  KEY `r_site_mbox_fk` (`site_id`),
  CONSTRAINT `fk_r_site_mbox` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_musicbox`
--

LOCK TABLES `dlog_musicbox` WRITE;
/*!40000 ALTER TABLE `dlog_musicbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_musicbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_my_blacklist`
--

DROP TABLE IF EXISTS `dlog_my_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_my_blacklist` (
  `my_user_id` int(11) NOT NULL,
  `other_user_id` int(11) NOT NULL,
  `bl_type` int(11) NOT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY (`my_user_id`,`other_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_my_blacklist`
--

LOCK TABLES `dlog_my_blacklist` WRITE;
/*!40000 ALTER TABLE `dlog_my_blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_my_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_p_reply`
--

DROP TABLE IF EXISTS `dlog_p_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_p_reply` (
  `p_reply_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `author` varchar(20) NOT NULL,
  `author_url` varchar(100) DEFAULT NULL,
  `author_email` varchar(50) DEFAULT NULL,
  `client_type` smallint(6) NOT NULL,
  `client_ip` varchar(16) NOT NULL,
  `client_user_agent` varchar(100) DEFAULT NULL,
  `owner_only` int(11) NOT NULL,
  `content` text NOT NULL,
  `write_time` datetime NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`p_reply_id`),
  KEY `r_photo_reply_fk` (`photo_id`),
  KEY `r_site_p_reply_fk` (`site_id`),
  KEY `r_user_p_reply_fk` (`userid`),
  CONSTRAINT `fk_r_user_p_reply` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_photo_reply` FOREIGN KEY (`photo_id`) REFERENCES `dlog_photo` (`photo_id`),
  CONSTRAINT `fk_r_site_p_reply` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_p_reply`
--

LOCK TABLES `dlog_p_reply` WRITE;
/*!40000 ALTER TABLE `dlog_p_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_p_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_photo`
--

DROP TABLE IF EXISTS `dlog_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_photo` (
  `photo_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `album_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `photo_name` varchar(40) NOT NULL,
  `photo_desc` text,
  `file_name` varchar(100) NOT NULL,
  `photo_url` varchar(100) NOT NULL,
  `preview_url` varchar(100) NOT NULL,
  `tags` varchar(100) DEFAULT NULL,
  `p_year` int(11) NOT NULL,
  `p_month` smallint(6) NOT NULL,
  `p_date` smallint(6) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `photo_size` bigint(20) NOT NULL,
  `color_bit` int(11) NOT NULL,
  `exif_manufacturer` varchar(50) DEFAULT NULL,
  `exif_model` varchar(50) DEFAULT NULL,
  `exif_iso` int(11) NOT NULL,
  `exif_aperture` varchar(20) DEFAULT NULL,
  `exif_shutter` varchar(20) DEFAULT NULL,
  `exif_exposure_bias` varchar(20) DEFAULT NULL,
  `exif_exposure_time` varchar(20) DEFAULT NULL,
  `exif_focal_length` varchar(20) DEFAULT NULL,
  `exif_color_space` varchar(20) DEFAULT NULL,
  `reply_count` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_time` datetime DEFAULT NULL,
  `last_reply_time` datetime DEFAULT NULL,
  `photo_type` int(11) NOT NULL,
  `locked` smallint(6) NOT NULL,
  `photo_status` smallint(6) NOT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `r_album_photo_fk` (`album_id`),
  KEY `r_site_photo_fk` (`site_id`),
  KEY `r_photo_owner_fk` (`userid`),
  CONSTRAINT `fk_r_site_photo` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`),
  CONSTRAINT `fk_r_album_photo` FOREIGN KEY (`album_id`) REFERENCES `dlog_album` (`album_id`),
  CONSTRAINT `fk_r_photo_owner` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_photo`
--

LOCK TABLES `dlog_photo` WRITE;
/*!40000 ALTER TABLE `dlog_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_site`
--

DROP TABLE IF EXISTS `dlog_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `dlog_type_id` int(11) DEFAULT NULL,
  `site_name` varchar(20) NOT NULL,
  `site_c_name` varchar(50) NOT NULL,
  `site_url` varchar(100) DEFAULT NULL,
  `site_title` varchar(100) DEFAULT NULL,
  `site_detail` varchar(250) DEFAULT NULL,
  `site_icp` varchar(20) DEFAULT NULL,
  `site_logo` varchar(50) DEFAULT NULL,
  `site_css` varchar(50) DEFAULT NULL,
  `site_layout` varchar(50) DEFAULT NULL,
  `site_lang` varchar(10) DEFAULT NULL,
  `site_flag` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `last_time` datetime DEFAULT NULL,
  `expired_time` datetime DEFAULT NULL,
  `last_exp_time` datetime DEFAULT NULL,
  `access_mode` smallint(6) NOT NULL,
  `access_code` varchar(50) DEFAULT NULL,
  `diary_status` smallint(6) NOT NULL,
  `photo_status` smallint(6) NOT NULL,
  `music_status` smallint(6) NOT NULL,
  `forum_status` smallint(6) NOT NULL,
  `guestbook_status` smallint(6) NOT NULL,
  `diary_cname` varchar(16) DEFAULT NULL,
  `photo_cname` varchar(16) DEFAULT NULL,
  `music_cname` varchar(16) DEFAULT NULL,
  `bbs_cname` varchar(16) DEFAULT NULL,
  `guestbook_cname` varchar(16) DEFAULT NULL,
  `photo_space_total` int(11) NOT NULL,
  `photo_space_used` int(11) NOT NULL,
  `diary_space_total` int(11) NOT NULL,
  `diary_space_used` int(11) NOT NULL,
  `media_space_total` int(11) NOT NULL,
  `media_space_used` int(11) NOT NULL,
  `site_type` int(11) NOT NULL,
  `site_level` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`site_id`),
  KEY `r_user_site_fk` (`userid`),
  KEY `r_site_type_fk` (`dlog_type_id`),
  CONSTRAINT `fk_r_user_site` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_site_type` FOREIGN KEY (`dlog_type_id`) REFERENCES `dlog_type` (`dlog_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_site`
--

LOCK TABLES `dlog_site` WRITE;
/*!40000 ALTER TABLE `dlog_site` DISABLE KEYS */;
INSERT INTO `dlog_site` VALUES (1,1,NULL,'admin','qyh.myvnc.com',NULL,'my blog',NULL,NULL,NULL,NULL,NULL,NULL,0,'2012-04-08 20:05:43','2012-04-08 21:30:07',NULL,NULL,0,NULL,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,-1,-1,-1,-1,-1,-1,1,1,0);
/*!40000 ALTER TABLE `dlog_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_site_stat`
--

DROP TABLE IF EXISTS `dlog_site_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_site_stat` (
  `site_stat_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `stat_date` int(11) NOT NULL,
  `uv_count` int(11) NOT NULL,
  `pv_count` int(11) NOT NULL,
  `v_source` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`site_stat_id`),
  KEY `r_site_stat_fk` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_site_stat`
--

LOCK TABLES `dlog_site_stat` WRITE;
/*!40000 ALTER TABLE `dlog_site_stat` DISABLE KEYS */;
INSERT INTO `dlog_site_stat` VALUES (1,1,20120308,1,0,1,'2012-04-08 20:05:43');
/*!40000 ALTER TABLE `dlog_site_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_t_reply`
--

DROP TABLE IF EXISTS `dlog_t_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_t_reply` (
  `t_reply_id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `write_time` datetime DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `client_ip` varchar(16) DEFAULT NULL,
  `client_type` smallint(6) DEFAULT NULL,
  `client_user_agent` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`t_reply_id`),
  KEY `r_site_t_reply_fk` (`site_id`),
  KEY `r_topic_reply_fk` (`topic_id`),
  KEY `r_user_t_reply_fk` (`userid`),
  CONSTRAINT `fk_r_user_t_reply` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_site_t_reply` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`),
  CONSTRAINT `fk_r_topic_reply` FOREIGN KEY (`topic_id`) REFERENCES `dlog_topic` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_t_reply`
--

LOCK TABLES `dlog_t_reply` WRITE;
/*!40000 ALTER TABLE `dlog_t_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_t_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_tag`
--

DROP TABLE IF EXISTS `dlog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ref_id` int(11) NOT NULL,
  `ref_type` smallint(6) NOT NULL,
  `tag_name` varchar(20) NOT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `r_site_tag_fk` (`site_id`),
  KEY `idx_tagname` (`tag_name`),
  CONSTRAINT `fk_r_site_tag` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_tag`
--

LOCK TABLES `dlog_tag` WRITE;
/*!40000 ALTER TABLE `dlog_tag` DISABLE KEYS */;
INSERT INTO `dlog_tag` VALUES (1,1,1,1,'C');
/*!40000 ALTER TABLE `dlog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_topic`
--

DROP TABLE IF EXISTS `dlog_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_topic` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `modify_time` datetime DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `tags` varchar(100) DEFAULT NULL,
  `last_reply_time` datetime DEFAULT NULL,
  `last_reply_id` int(11) DEFAULT NULL,
  `last_user_id` int(11) DEFAULT NULL,
  `last_user_name` varchar(50) DEFAULT NULL,
  `reply_count` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `locked` smallint(6) NOT NULL,
  `topic_type` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `client_type` smallint(6) NOT NULL,
  `client_ip` varchar(16) NOT NULL,
  `client_user_agent` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`topic_id`),
  KEY `r_site_topic_fk` (`site_id`),
  KEY `r_forum_topic_fk` (`forum_id`),
  KEY `r_user_topic_fk` (`userid`),
  CONSTRAINT `fk_r_user_topic` FOREIGN KEY (`userid`) REFERENCES `dlog_user` (`userid`),
  CONSTRAINT `fk_r_forum_topic` FOREIGN KEY (`forum_id`) REFERENCES `dlog_forum` (`forum_id`),
  CONSTRAINT `fk_r_site_topic` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_topic`
--

LOCK TABLES `dlog_topic` WRITE;
/*!40000 ALTER TABLE `dlog_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_trackback`
--

DROP TABLE IF EXISTS `dlog_trackback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_trackback` (
  `track_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `parent_type` smallint(6) NOT NULL,
  `refurl` varchar(100) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `excerpt` varchar(200) DEFAULT NULL,
  `blog_name` varchar(50) NOT NULL,
  `remote_addr` char(15) NOT NULL,
  `track_time` datetime NOT NULL,
  PRIMARY KEY (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_trackback`
--

LOCK TABLES `dlog_trackback` WRITE;
/*!40000 ALTER TABLE `dlog_trackback` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_trackback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_type`
--

DROP TABLE IF EXISTS `dlog_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_type` (
  `dlog_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `dlo_dlog_type_id` int(11) DEFAULT NULL,
  `type_name` varchar(20) NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`dlog_type_id`),
  KEY `r_site_type_tree_fk` (`dlo_dlog_type_id`),
  CONSTRAINT `fk_r_site_type_tree` FOREIGN KEY (`dlo_dlog_type_id`) REFERENCES `dlog_type` (`dlog_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_type`
--

LOCK TABLES `dlog_type` WRITE;
/*!40000 ALTER TABLE `dlog_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlog_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlog_user`
--

DROP TABLE IF EXISTS `dlog_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlog_user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `own_site_id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `user_role` int(11) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `sex` smallint(6) NOT NULL,
  `birth` date DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `homepage` varchar(50) DEFAULT NULL,
  `qq` varchar(16) DEFAULT NULL,
  `msn` varchar(50) DEFAULT NULL,
  `mobile` varchar(16) DEFAULT NULL,
  `nation` varchar(40) DEFAULT NULL,
  `province` varchar(40) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `industry` varchar(40) DEFAULT NULL,
  `company` varchar(80) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `job` varchar(40) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `zip` varchar(12) DEFAULT NULL,
  `portrait` varchar(100) DEFAULT NULL,
  `resume` varchar(200) DEFAULT NULL,
  `regtime` datetime NOT NULL,
  `last_time` datetime DEFAULT NULL,
  `last_ip` varchar(16) DEFAULT NULL,
  `keep_days` int(11) NOT NULL,
  `online_status` int(11) NOT NULL,
  `user_level` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `article_count` int(11) NOT NULL,
  `article_reply_count` int(11) NOT NULL,
  `topic_count` int(11) NOT NULL,
  `topic_reply_count` int(11) NOT NULL,
  `photo_count` int(11) NOT NULL,
  `photo_reply_count` int(11) NOT NULL,
  `guestbook_count` int(11) NOT NULL,
  `bookmark_count` int(11) NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `r_site_user_fk` (`site_id`),
  CONSTRAINT `fk_r_site_user` FOREIGN KEY (`site_id`) REFERENCES `dlog_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Users may bid for or sell auction items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlog_user`
--

LOCK TABLES `dlog_user` WRITE;
/*!40000 ALTER TABLE `dlog_user` DISABLE KEYS */;
INSERT INTO `dlog_user` VALUES (1,NULL,1,'admin','ACEB1D8E96AB2739',0,'管理员',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-04-08 20:05:43','2012-04-08 21:29:06','127.0.0.1',365,1,1,0,1,1,0,0,0,0,0,2),(2,1,0,'qinyanhong','619034920555A7F3',0,'qinyanhong',1,NULL,'qin6174@126.com',NULL,'704344856',NULL,NULL,NULL,'江西','南昌',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-04-08 20:17:35','2012-04-08 21:27:16','127.0.0.1',0,0,1,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `dlog_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-04-10 17:58:09
