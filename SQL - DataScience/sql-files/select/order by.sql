#-------------------------------
DESCRIBE matches;
select * from matches;
DESCRIBE deliveries;
select * from deliveries;
#-------------------------------

select season,city
from matches
order by season ASC;

select season,city
from matches
order by season desc ,city asc ;

#Sort all matches by id in ascending order

select id,season
from matches
order by id asc;

# Show matches sorted by city alphabetically

select city,id
from matches
order by city asc;

#Sort deliveries by total_runs (highest first)

select batter,batsman_runs
from deliveries
order by batsman_runs desc;

#Show top 5 matches with highest id

select id 
from matches
order by id desc limit 5;

#Show top 10 deliveries with highest runs

select batter,batsman_runs
from deliveries
order by batsman_runs desc limit 10;

#Find matches sorted by season, but for same season show highest id first

select id,season
from matches
order by id desc ,season asc;