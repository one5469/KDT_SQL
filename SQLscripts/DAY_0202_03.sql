use testdb;

drop table if exists string_tbl;
create table string_tbl
(char_fld char(30),
vchar_fld varchar(30),
text_fld text
);

insert into string_tbl (char_fld, vchar_fld, text_fld)
values ('This is char data',
		'This is varchar data',
        'This is text data');
        
update string_tbl
set vchar_fld = 'This is a piece of extremely long varchar data';

update string_tbl
set text_fld = 'This string didnt\'t work, but it does now';

select quote(text_fld) from string_tbl;

delete from string_tbl;

insert into string_tbl(char_fld, vchar_fld, text_fld)
values ('This string is 28 characters',
		'This string is 28 characters',
		'This string is 28 characters');
	
select length(char_fld) as char_length,
length(vchar_fld) as varchar_length,
length(text_fld) as text_length
from string_tbl;
		
select position('characters' in vchar_fld)
from string_tbl;

select locate('is', vchar_fld, 5)
from string_tbl;

select locate('is', vchar_fld, 1)
from string_tbl;

delete from string_tbl;

insert into string_tbl(vchar_fld)

insert into string_tbl (vchar_fld)
values ('abcd'),
		('xyz'),
		('QRSTUV'),
		('QRSTUV'),
		('12345');
		
select vchar_fld from string_tbl order by vchar_fld;

select strcmp('12345', '12345') 12345_12345,
	   strcmp('abcd', 'xyz') abcd_xyz,
	   strcmp('abcd', 'QRSTUV') abcd_QRSTUV,
	   strcmp('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
	   strcmp('12345', 'xyz') 12345_xyz,
	   strcmp('xyz', 'qrstuv') xyz_qrstuv;
	   
use sakila;

select name, name like '%y' ends_in_y from category;

select name, name regexp 'y$' ends_in_y from category;

use testdb;
delete from string_tbl;

insert into string_tbl (text_fld) values ('This string was 29 characters');

update string_tbl 
set text_fld = concat(text_fld, ', but now it is longer');

select text_fld from string_tbl;

use sakila;

select concat(first_name, ' ', last_name,
' has been a customer since ', date(create_date)) as cust_narrative
from customer;

select insert ('goodbye world', 9, 0, 'cruel ') as string;

select insert ('goodbye world', 1, 7, 'hello')as string;

select replace('goodbye world', 'goodbye', 'hello') as replace_str;

select substr('goodbye cruel world', 9, 5);