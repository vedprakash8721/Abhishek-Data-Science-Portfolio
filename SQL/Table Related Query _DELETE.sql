create database cricket;
use cricket;

create table Players(
Name varchar(50) ,
Cap_num int primary key,
Age int not null,
Country varchar(50),
Debut int not null,
Match_played int,
Century int ,
Avg int );

select* from Players;
# i fon't want to use some of them so i am firstly deleting the Players table and initialize it again
drop table Players;

-- DELETE  : important note: when you are deleting anything from the database then make sure about syntax because once the data is deleted it can not be undo
# ( Without a WHERE clause, it deletes all rows — use with extreme caution. )
-- with delete query . the entire row will be deleted . like any specific player ka pura record


select* from Players;
delete from Players
where Avg<22;
set sql_safe_updates=0;

-- for specific data deletion we have to update this like .

update Players
set Avg=0
where Cap_num=109;
# so like this we can update or delete anything from database .
update Players
set Avg=24
where Cap_num=109;

INSERT INTO Players VALUES 
("Gautam Gambhir", 101, 42, "India", 2003, 147, 20, 39),
("Steve Smith", 102, 34, "Australia", 2010, 190, 45, 50),
("Joe Root", 103, 33, "England", 2012, 210, 46, 52),
("Kane Williamson", 104, 34, "New Zealand", 2010, 185, 43, 53),
("Rohit Sharma", 105, 37, "India", 2007, 250, 49, 47),
("David Warner", 106, 38, "Australia", 2009, 230, 42, 44),
("Shubman Gill", 107, 25, "India", 2019, 60, 10, 48),
("Ben Stokes", 108, 33, "England", 2013, 140, 12, 39),
("Hardik Pandya", 109, 31, "India", 2016, 90, 3, 34),
("Trent Boult", 110, 35, "New Zealand", 2011, 120, 0, 10);



