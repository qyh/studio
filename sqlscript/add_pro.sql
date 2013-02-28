use test;
delimiter $
create procedure addUser(IN inName varchar(45), OUT outId int)
    begin
        insert into `test`.`test`(name) values(inName);
        select id into outId from `test`.`test` where name = inName;
    end
$
delimiter ;