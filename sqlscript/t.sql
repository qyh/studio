/*insert into `fetion`.`user`(name,password,sex,qq,power,rank,credit,
        phone,turename,university) select
        name,password,sex,qq,power,rank,credit,phone,turename,
        university from `jdbc`.`user` where name not in (select  
        name from `fetion`.`user`);
*/        
insert into `project`.`teacher`(id, id_card, password, name, sex, age,
		birthday, depart, search_section, administrative, phone,
		email, native_place, nation, polity, first_educat, last_educat,
		major, power, get_double_teacher_time, graduate_sch_name,
		graduate_sch_type, obtain_offer_time, teach_date, teach_this_major_time,
		subject, cer_profesion, cer_major, status, checkRemarks, school_code)
		select id, id_card, password, name, sex, age,
		birthday, depart, search_section, administrative, phone,
		email, native_place, nation, polity, first_educat, last_educat,
		major, power, get_double_teacher_time, graduate_sch_name,
		graduate_sch_type, obtain_offer_time, teach_date, teach_this_major_time,
		subject, cer_profesion, cer_major, status, checkRemarks, school_code from
		`tts`.`teacher`;