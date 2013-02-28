insert into `fetion`.`article`(username, title, content,date)
        select name, title, content, time from `fetion_bak`.`forum`
        where name not in (select username from `fetion`.`article`);