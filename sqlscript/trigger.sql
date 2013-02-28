use test;
/* 1，创建触发器:t_afterinsert_on_tab1
** 作用：增加tab1表记录后自动将记录增加到tab2表中
*/
CREATE TRIGGER t_afterinsert_on_tab1
AFTER INSERT ON test
FOR EACH ROW
BEGIN
     if new.id is not null then
        insert into test_ref(id) values(new.id);
     end if;
END;


/* 2，创建触发器:t_afterdelete_on_tab1
** 作用：删除tab1表记录后自动将tab2表中对应的记录删去
*/
CREATE TRIGGER t_afterdelete_on_tab1
AFTER DELETE ON test
FOR EACH ROW
BEGIN
      delete from test_ref where id=old.id;
END;

/* 2，创建触发器:t_afterupdate_on_a
** 作用：修改a表age字段后自动将b表中对应的age字段修改
*/
CREATE TRIGGER t_afterupdate_on_age 
AFTER UPDATE ON test 
FOR EACH ROW 
update test_ref set age=NEW.age where id=NEW.id;