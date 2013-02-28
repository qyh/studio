DROP TABLE IF EXISTS `fetion`.`article`;
CREATE TABLE  `fetion`.`article` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(45) NOT NULL,
  `title` varchar(128) default NULL,
  `content` text,
  `date` date default NULL,
  `reply_number` int(11) default NULL,
  `id_template` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `id_template` (`id_template`),
  KEY `username` (`username`),
  CONSTRAINT `id_template` FOREIGN KEY (`id_template`) REFERENCES `template` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `user` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;