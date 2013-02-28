use fetion;
delimiter |
create trigger reply_user BEFORE update on user
    FOR EACH ROW BEGIN
	update reply set head = new.head where username = new.name;
	update reply set rank = new.rank where username = new.name;
	update reply set credit = new.credit where username = new.name;
    END
|
delimiter ;


