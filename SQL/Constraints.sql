# sql constraints are used in sql to specify some rules for data in a table

-- 1: NOT NULL : column can be null.it could be duplicate but not empty
create database cons;
use cons;

create table temp(id int not null,name varchar(20));
# here we created id that is not null
insert into temp values(10, "ved"); # here we executed lets see fo duplicate value
insert into temp values(10, "Abhishek"); 
select * from temp;


-- 2:  UNIQUE  : 
create table temp1(id int unique,city varchar(20));
insert into temp1 values(10, "varanasi"); # here id is allocated 10
insert into temp1 values(10, "ghazipur"); # here it will throw an error
insert into temp1 values(null,"ghazipur"); # null accepted

select * from temp1;


-- 3: PRIMARY KEY : primary key must be unique and can not be null . in a table only one primary could exist

create table temp2( rollno int primary key, course varchar(20));
insert into temp2 values(06,"CSE");
select*from temp2;
# we can declare a key as primary key like this also ---- primary key(column name)
-- we can create a group of column as primary key then the group must be unique 


-- 4: Foreign key:  
# syntax:
-- foriegn key(column_name) references table_name(uss table ki column jisko banana hai)


-- 5: DEFAULT : 
# set the value as default

create table temp3(salary int default 20000,name varchar(20));
#lets see by giving only name
insert into temp3 (name) values(" ved prakash");
select*from temp3; # salary has been added 20000 as default
