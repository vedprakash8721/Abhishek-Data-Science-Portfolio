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