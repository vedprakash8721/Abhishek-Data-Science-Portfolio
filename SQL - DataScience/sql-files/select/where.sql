#-----------------------

DESCRIBE matches;
select * from matches;
DESCRIBE deliveries;
select * from deliveries;


# Matches played in 2016 AND in Mumbai
select id,season,city
from matches
WHERE season= '2016' AND city='Mumbai';

select distinct city
from matches
where season='2008';

select DISTINCT season
from matches;

#Deliveries where batsman scored 4 OR 6

select match_id,batter,batsman_runs
from deliveries
where batsman_runs=4 or batsman_runs=6 ;

# Matches where team1 is MI, CSK, or RCB
select id,team1
from matches
where team1 in ('Kolkata Knight Riders');


#Players whose name starts with 'S'
select batter
from deliveries
where batter like '%Gambhir%';