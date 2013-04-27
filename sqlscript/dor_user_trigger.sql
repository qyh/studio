use dormitory;
/*
delimiter |
create trigger dor_user_add_trigger after insert on tbl_user
    for each row begin
    update tbl_dormitory set d_stu_num=d_stu_num+1 where id=new.d_id;
    end
|
delimiter ;

delimiter |
create trigger dor_user_del_trigger before delete on tbl_user
    for each row begin
    update tbl_dormitory set d_stu_num=d_stu_num-1 where id=old.d_id;
    end
|
delimiter ;
*/

