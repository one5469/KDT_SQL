use sakila;

select language_id, name, last_update from `language` ;

select name from `language` l ;

select language_id,
	'COMMON' language_usage,
	language_id * 3.14 lang_pi_value,
	upper(name) language_name
from language;

select actor_id from film_actor order by actor_id;

select distinct actor_id from film_actor order by actor_id ;

select concat(cust.last_name, ', ', cust.first_name) full_name
from 
(select first_name, last_name, email
 from customer
 where first_name = 'JESSIE'
 ) as cust;
 
create temporary table actors_j
( actor_id smallint(5), first_name varchar(45), last_name varchar(45));
desc actors_j;

insert into actors_j
	select actor_id, first_name, last_name
	from actor where last_name like 'J%';

select  * from actors_j;

create view cust_vw as
	select customer_id, first_name, last_name, active
	from customer;
	
select * from cust_vw;

select customer.first_name, customer.last_name,
	time(rental.rental_date) as rental_time
from customer inner join rental on customer.customer_id = rental.customer_id
where date(rental.rental_date) = '2005-06-14';

select c.first_name, c.last_name,
	time(r.rental_date) rental_date
from customer c inner join rental r on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14';

select title from film where rating='G' and rental_duration >= 7;

select title, rating, rental_duration from film
where (rating='G' and rental_duration >= 7)
	or (rating = 'PG-13' and rental_duration < 4);
	
select c.first_name, c.last_name, count(*)
from customer c inner join rental as r
	on c.customer_id = r.customer_id 
group by c.first_name, c.last_name
having count(*) >= 40;

select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c inner join rental as r on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14'
order by c.last_name , c.first_name asc;

select actor_id, first_name, last_name from actor order by last_name, first_name;

select actor_id, first_name, last_name from actor where last_name = 'WILLIAMS' or last_name = 'DAVIS';

select distinct customer_id from rental where date(rental_date) = '2005-07-05';

select c.store_id, c.email, r.rental_date, r.return_date
from customer as c inner join  rental as r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14'
order by return_date desc;