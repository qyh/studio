insert into `fetion`.`user`(name,password,sex,qq,power,rank,credit,
        phone,turename,university) select
        name,password,sex,qq,power,rank,credit,phone,turename,
        university from `fetion_bak`.`user` where name not in (select  
        name from `fetion`.`user`);
