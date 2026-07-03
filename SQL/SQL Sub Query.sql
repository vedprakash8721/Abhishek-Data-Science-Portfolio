use college;
select * from employee;

-- SUB SQL QUERY: Subquery (Sub SQL Query) is a query written inside another SQL query. The result of the inner query is used by the outer query to filter, compare, or retrieve data.
-- finding emp name whose salary is above avg:

select emp_name,salary
from employee
where salary>(
select avg(salary) from employee);

-- find the employee name whose salary is even
select emp_name,salary
from employee
where salary=(
select salary
where salacontinentry%2=0 );

update employee set salary =35565 where emp_id=1;
set sql_safe_updates=0;

-- find the employee name whose salary is odd
select emp_name,salary
from employee
where salary=(
  select salary
  from employee
  where salary%2!=0 );


-- from sub sql query:
use world_db;
-- find asia most populated country with name of country and population:
select * from country;
select country_name,population
from ( 
       select * from country
       where continent='Asia'
       order by population desc
       limit 1 ) as temp ;
       
select country_name,population from country
       where continent='Asia'
       order by population desc
       limit 1;