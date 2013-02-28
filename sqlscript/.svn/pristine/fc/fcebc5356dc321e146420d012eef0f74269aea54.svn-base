create table item(
	id int(6) not null auto_increment,
	name char(32) not null,
	price decimal(4,2) not null,
	description char(255) default 'No Description',
	
	primary key(id),
	key (name)
);

insert into item values(1, 'Toothbrush', 1.25, NULL);
insert into item values(2, 'Comb', 2.50, NULL);
insert into item values(3, 'Brush', 3.00, NULL);
insert into item values(4, 'Toothpaste', 0.75, NULL);

create table item_option(
	id int(6) not null auto_increment,
	item_id int(6) not null,
	name char(32) not null,
	
	primary key(id),
	foreign key(item_id) references item(id)
);

insert into item_option values(1, 2, 'Red Plastic');
insert into item_option values(2, 2, 'Blue Plastic');