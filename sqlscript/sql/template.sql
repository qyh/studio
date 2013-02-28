use test;
create table test(
	id int auto_increment not null primary key,
	name char(10) not null,
	address varchar(50) default '北京',
	year date
);
commit;

DROP TABLE IF EXISTS `forum`;
CREATE TABLE `forum` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `content` text,
  `time` datetime default NULL,
  `title` varchar(45) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_forum_name` (`name`),
  CONSTRAINT `FK_forum_name` FOREIGN KEY (`name`) REFERENCES `user` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(16) NOT NULL,
  `password` varchar(45) NOT NULL,
  `sex` varchar(2) NOT NULL,
  `qq` varchar(10) NOT NULL,
  `power` int(10) unsigned default '0',
  `rank` int(10) unsigned default '0',
  `credit` int(10) unsigned default '0',
  `phone` varchar(45) default NULL,
  `mail` varchar(45) default NULL,
  `turename` varchar(45) default NULL,
  `university` varchar(45) default NULL,
  `question` varchar(45) default NULL,
  `quesanswer` varchar(255) default NULL,
  `province` varchar(45) default NULL,
  `city` varchar(45) default NULL,
  `birthday` datetime default NULL,
  PRIMARY KEY  USING BTREE (`id`),
  UNIQUE KEY `Index_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

