/*
** Combine two sql 
*/
select * from user where id = (select max(id) from user);
//---------------
insert into `fetion`.`user`(name,password,sex,qq,power,rank,credit,
        phone,turename,university) select
        name,password,sex,qq,power,rank,credit,phone,turename,
        university from `jdbc`.`user` where name not in (select  
        name from `fetion`.`user`);

/*
** Get tables rows 
*/
select count(*) as rows from user;
or
mysql> SELECT student.student_name,COUNT(*)
    ->        FROM student,course
    ->        WHERE student.student_id=course.student_id
    ->        GROUP BY student_name;

/*
** Create table to database
*/
CREATE TABLE `test`.`test` (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `money` FLOAT DEFAULT 100.0,
  `birthday` DATETIME,
  `age` INTEGER UNSIGNED,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Index_2`(`name`)
)
ENGINE = InnoDB;

/*
** foreign key
*/
CREATE TABLE `test`.`test_ref` (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_name` FOREIGN KEY `FK_name` (`name`)
    REFERENCES `test` (`name`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB;

use test;
create table test(
	id int auto_increment not null primary key,
	name char(10) not null,
	address varchar(50) default '±±Ÿ©',
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


/*
** Add foreign key to column after table created
*/
ALTER TABLE `test`.`test_ref` ADD CONSTRAINT `FK_name` FOREIGN KEY `FK_name` (`name`)
    REFERENCES `test` (`name`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;

/*
** Drop foreign key
*/
ALTER TABLE `test`.`test_ref` DROP FOREIGN KEY `FK_name`;

/*
** Modify column to table
*/
ALTER TABLE `test`.`test` MODIFY COLUMN `age` INT(10) DEFAULT NULL;

-- drop unique key
alter table table_name drop index `unique_key_name`

/*
** Add column to table
*/   
ALTER TABLE `test`.`test` ADD COLUMN `credit` INTEGER UNSIGNED NOT NULL AFTER `age`;

/*
** Drop column from table
*/
ALTER TABLE `test`.`test` DROP COLUMN `credit`;

/*
** Add check(unique) to column core of table test_ref
*/
ALTER TABLE `test`.`test_ref` ADD UNIQUE INDEX `Index_core`(`core`);

/*
** Drop check(unique) to column core of table test_ref
*/
ALTER TABLE `test`.`test_ref` DROP INDEX `Index_core`;

/*
** Trigger 
*/

CREATE TABLE test1(a1 INT);
CREATE TABLE test2(a2 INT);
CREATE TABLE test3(a3 INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
CREATE TABLE test4(
  a4 INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  b4 INT DEFAULT 0
);

 
DELIMITER |
 
CREATE TRIGGER testref BEFORE INSERT ON test1
  FOR EACH ROW BEGIN
    INSERT INTO test2 SET a2 = NEW.a1;
    DELETE FROM test3 WHERE a3 = NEW.a1;  
    UPDATE test4 SET b4 = b4 + 1 WHERE a4 = NEW.a1;
  END
|
 
DELIMITER ;
 
INSERT INTO test3 (a3) VALUES 
  (NULL), (NULL), (NULL), (NULL), (NULL), 
  (NULL), (NULL), (NULL), (NULL), (NULL);
 
INSERT INTO test4 (a4) VALUES 
  (0), (0), (0), (0), (0), (0), (0), (0), (0), (0);
  
--
--My Trigger of table `fetion`.`user`
--
use fetion;
drop trigger if exists reply_user;
delimiter |
create trigger reply_user BEFORE update on user
    FOR EACH ROW BEGIN
	update reply set head = new.head where username = new.name;
	update reply set rank = new.rank where username = new.name;
	update reply set credit = new.credit where username = new.name;
    END
|
delimiter ;

/* Trigger end */

--
-- Create Procedure
--
DELIMITER $$
DROP PROCEDURE IF EXISTS `test`.`Update_CompanyInfo` $$
CREATE PROCEDURE `test`.`Update_CompanyInfo`(in N_id varchar(20),in O_id varchar(20),in N_name varchar(60),in N_tel varchar(20),in N_addr varchar(20),in dealflag varchar(10))
BEGIN
   declare @Tmp int #ÕâÀïŒÇµÃŒÓ¡®;¡¯
   if(O_id is not null or O_id!='') then # ¿ÉÒÔÓÃ<>
      select count(*) into @tmp from companyinfo where id=O_id;
    else
      select count(*) into @tmp form companyinfo where id=N_id;
    end if;

    if(dealflag!='delete' and @tmp=0) then
       insert into companyinfo (id,name,tel,addr)values(N_id,N_name,N_tel,N_addr);
    elseif(dealflag='delete' and @tmp=1) then
       delete from companyinfo where id=O_id;
    elseif(dealflag!='delete' and @tmp=1) then
       update companyinfo set name=N_name,tel=N_tel,addr=N_addr where id=O_id;
    end if;

END $$

DELIMITER ;

-- Call Procedure
call procedrue_name();

--
-- Procedure end
--

/*
** Create and drop Index on table
*/
--创建唯一索引
create unique index customer_info_index1 on customer_info(number);

--创建索引
create index customer_info_index2 on customer_info(name);

--删除索引
drop index user_info_index1 on user_info;
 
-- Create multiseriate index: http://tech.ddvip.com/2006-04/11443594204131.html
ALTER TABLE people ADD INDEX fname_lname_age (firstname,lastname,age);
/**
限制使用索引的范围
http://tech.ddvip.com/2007-05/117871971323787_5.html
　　有时我们在数据表里建立了很多索引，当MySQL对索引进行选择时，这些索引都在考虑的范围内。但有时我们希望MySQL只考虑几个索引，而不是全部的索引，这就需要用到USE INDEX对查询语句进行设置。SELECT * FROM TABLE1 USE INDEX (FIELD1, FIELD2) …

　　从以上SQL语句可以看出，无论在TABLE1中已经建立了多少个索引，MySQL在选择索引时，只考虑在FIELD1和FIELD2上建立的索引。

　　限制不使用索引的范围

　　如果我们要考虑的索引很多，而不被使用的索引又很少时，可以使用IGNORE INDEX进行反向选取。在上面的例子中是选择被考虑的索引，而使用IGNORE INDEX是选择不被考虑的索引。SELECT * FROM TABLE1 IGNORE INDEX (FIELD1, FIELD2) …

　　在上面的SQL语句中，TABLE1表中只有FIELD1和FIELD2上的索引不被使用。

　　强迫使用某一个索引

　　上面的两个例子都是给MySQL提供一个选择，也就是说MySQL并不一定要使用这些索引。而有时我们希望MySQL必须要使用某一个索引(由于 MySQL在查询时只能使用一个索引，因此只能强迫MySQL使用一个索引)。这就需要使用FORCE INDEX来完成这个功能。SELECT * FROM TABLE1 FORCE INDEX (FIELD1) …

　　以上的SQL语句只使用建立在FIELD1上的索引，而不使用其它字段上的索引。
*/
--
-- Index end
--
/**
** Fulltext index
** More detail: http://tech.techweb.com.cn/thread-388617-1-1.html
**/
-- Create fulltext index only when table engine is Myisam
alter table reviews add fulltext index (data);

-- Use fulltext index 
select id from reviews where match (data) against (’Madonna’);

/**
** Paging 分页 
** more detail: http://tech.ddvip.com/2007-08/118758458132435.html
**/
select * from table LIMIT 5,10; #返回第6-15行数据
select * from table LIMIT 5; #返回前5行
select * from table LIMIT 0,5; #返回前5行

/**
** Paging end 
**/

/**
* 查看mysql支持连接数
*/
show variables like 'max_con%';
