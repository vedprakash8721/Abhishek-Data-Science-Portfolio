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

-- we can use it for deleting the column 
# we don't want to delete existing data so we will do this
alter table Players
add column yuhi varchar(5);
select * from Players;

# now delete the column
alter table Players
drop column yuhi;

-- rename table name: 
/* 
sytax:
alter table table_name
rename to new_table_name
*/
#lets change the name of the table players to player
alter table Players
rename to Player;
select*from Player;
-- now lets regain it
alter table Player
rename to Players;
select*from Players;


-- to modify data type or constraints of the column
alter table Players
modify age int;
