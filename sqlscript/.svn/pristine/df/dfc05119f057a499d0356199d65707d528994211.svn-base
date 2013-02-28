DROP TABLE IF EXISTS `fetion`.`reply`;
CREATE TABLE  `fetion`.`reply` (
  `id` int(11) NOT NULL,
  `id_article` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `content` text,
  `date` date default NULL,
  PRIMARY KEY  (`id`),
  KEY `id_article` (`id_article`),
  CONSTRAINT `id_article` FOREIGN KEY (`id_article`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;