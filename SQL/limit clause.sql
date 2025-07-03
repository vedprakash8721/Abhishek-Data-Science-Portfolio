# sets a upper limit on number of rows to be returned
use college;
select*from students limit 3;
# we can use it with where clause
select *from students where Marks>90 limit 5;