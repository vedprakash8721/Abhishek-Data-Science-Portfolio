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
("Trent Boult", 110, 35, "New Zealand", 2011, 120, 0, 10),
("Glenn Maxwell", 111, 36, "Australia", 2012, 110, 6, 35),
("Mohammad Rizwan", 112, 32, "Pakistan", 2016, 95, 5, 42),
("Jos Buttler", 113, 34, "England", 2011, 160, 9, 41),
("Ravindra Jadeja", 114, 36, "India", 2009, 180, 3, 36),
("Tom Latham", 115, 32, "New Zealand", 2012, 130, 10, 38),
("Usman Khawaja", 116, 37, "Australia", 2011, 85, 9, 45),
("Fakhar Zaman", 117, 33, "Pakistan", 2017, 95, 12, 41),
("Harry Brook", 118, 25, "England", 2022, 35, 4, 52),
("KL Rahul", 119, 32, "India", 2014, 120, 14, 43),
("Shaheen Afridi", 120, 25, "Pakistan", 2018, 85, 0, 11);


select*from Players;
--  UPDATE QUERY : update the existing data.
#syntax: 
	--  update table_name
	--  set col = value1 , col2= values 
	--  where condition;

#now we want to remove that Pakistani Player

-- single update at a time

update Players
set Name= "Malcum Marshal", Country="Scotland"
where Cap_num= 112;

#Multiple update at a time
update Players
set
Name= case Cap_num
when 117 then "Brendom Maccalum"
when 120 then "steve roggers"
else Name
end,
Country= case Cap_num
when 117 then "New Zealand"
when 120 then "America"
else Country
end
where Cap_num in (117,120);

select*from Players;
