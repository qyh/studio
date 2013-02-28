@echo off
mysqldump -h localhost -uroot -proot fetion > E:/sqlscript/mysql/fetion.sql
mysqldump -h localhost -uroot -proot hibernate > E:/sqlscript/mysql/hibernate.sql
mysqldump -h localhost -uroot -proot hibernate4 > E:/sqlscript/mysql/hibernate4.sql
mysqldump -h localhost -uroot -proot ibatis > E:/sqlscript/mysql/ibatis.sql
mysqldump -h localhost -uroot -proot jdbc_spring > E:/sqlscript/mysql/jdbc_spring.sql
mysqldump -h localhost -uroot -proot jpa > E:/sqlscript/mysql/jpa.sql
mysqldump -h localhost -uroot -proot library > E:/sqlscript/mysql/library.sql
mysqldump -h localhost -uroot -proot mybatis > E:/sqlscript/mysql/mybatis.sql
mysqldump -h localhost -uroot -proot project > E:/sqlscript/mysql/project.sql
mysqldump -h localhost -uroot -proot ssh > E:/sqlscript/mysql/ssh.sql
echo mysql backup success!
echo press any key to continue ...
