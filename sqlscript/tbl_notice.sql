use dormitory;

create table tbl_notice (
    id int not null auto_increment primary key,
    title varchar(255),
    content text,
    public_time datetime,
    owner_id int not null,
    f_id int not null,
    constraint `pk_u_notice`
    foreign key (`owner_id`) references tbl_user(`id`),
    constraint `pk_f_notice` 
    foreign key (`f_id`) references tbl_floor (`id`)

);
