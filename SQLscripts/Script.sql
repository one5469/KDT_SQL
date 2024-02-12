show databases;
use sakila;

select now();

drop database if exists testdb;
create database testdb;

use testdb;

drop table if exists person;
create table person
		(
			person_id smallint unsigned,
			fname varchar(20),
			lname varchar(20),
			eye_color enum('BR','BL', 'GR'),
			birth_date DATE,
			street varchar(30),
			city varchar(20),
			state varchar(20),
			country varchar(20),
			postal_code varchar(20),
			constraint pk_person primary key (person_id)
			);
		
drop table if exists favorite_food;
create table favorite_food
		(person_id smallint unsigned,
			food varchar(20),
			constraint pk_favortie_food primary key (person_id, food),
			constraint fk_fav_food_person_id foreign key(person_id) references person(person_id)
			);
			
desc person;
desc favorite_food;

set foreign_key_checks=0;
alter table person modify person_id smallint unsigned auto_increment;
set foreign_key_checks=1;

insert into person(person_id, fname, lname, eye_color, birth_date)
 			values (null, 'William', 'Turnur', 'BR', '1072-05-27');

select * from person;

select person_id, fname, lname, birth_date from person;

select person_id, fname, lname, birth_date from person where lname = 'Turnur';

insert into favorite_food (person_id, food)
values (1, 'pizza'), (1, 'cookie'), (1, 'nachos');

select * from favorite_food;

select food from favorite_food where person_id=1 order by food;

insert into person (person_id, fname, lname, eye_color, birth_date, street, city, state, country, postal_code)
values (2, 'Susan', 'Smith', 'BL', '1975-11-02', '23 Maple St.', 'Arlington', 'VA', 'USA', '20220');
select person_id, fname, lname, birth_date from person;
select * from person;

update person
set street = '1225 Tremon St.',
	birth_date = '1972-05-27',
	city = 'Boston',
	state = 'MA',
	country = 'USA',
	postal_code = '02138'
	where person_id = 1;
	
select * from person;

-- delete from person where person_id=3;
-- 
-- select * from person;

insert into person (person_id, fname, lname) values(3, 'Kevin', 'Kern');

insert into favorite_food (person_id, food) values(3, 'lasagna');

select * from favorite_food;

-- update person set birth_date = 'DEC-21-1980' where person_id=1;
update person set birth_date = str_to_date('DEC-12-1980', '%b-%d-%Y') where person_id =1;

