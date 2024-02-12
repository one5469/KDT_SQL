use sakila;

select customer_id, rental_date
from rental where rental_date < '2005-05-25';

select customer_id, rental_date from rental
where rental_date <= '2005-06-16' and rental_date  >= '2005-06-14';

select customer_id, rental_date from rental
where date(rental_date) <= '2005-06-16' and date(rental_date) >= '2005-06-14';

select customer_id, rental_date from rental 
where date(rental_date) between '2005-06-14' and '2005-06-16';

select customer_id, payment_date, amount from payment
where amount between 10.0 and 11.99;

select last_name, first_name from customer where last_name between 'FA' and 'FRB';

select title, rating from film where rating='G' or rating='PG';

select title, rating from film where rating in ('G', 'PG');

select title, rating from film where title like '%PET%';

select title, rating from film where rating in 
(select rating from film where title like '%PET%');

select title, rating from film where rating not in ('PG-13', 'R', 'NC-17');

select last_name, first_name from customer
where last_name like '_A_T%S';

select last_name, first_name from customer c 
where last_name like 'Q%' or last_name like 'Y%';

select last_name, first_name from customer
where last_name regexp '^[QY]';

select rental_id, customer_id, return_date from rental
where return_date is null
or return_date not between '2005-05-01' and '2005-09-01';

