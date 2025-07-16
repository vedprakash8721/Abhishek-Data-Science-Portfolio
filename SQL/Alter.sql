-- to change the schema 
# alter is used to add , rename and to drop the columm
use cricket;

-- to add column
alter table Players
add column career int ;
select * from Players;

# adding some value to see how it looks
update Players
set career=16 where Cap_num=101;
set sql_safe_updates=0;