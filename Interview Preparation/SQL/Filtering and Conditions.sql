-- Q21. What is the difference between WHERE and HAVING?
/* The WHERE clause is used to filter individual rows before any grouping (GROUP BY).

where------------------------------------------
It cannot be used with aggregate functions like COUNT(), SUM(), or AVG().
why cant with aggregate function? : 
WHERE is evaluated before grouping and aggregation, whereas aggregate values are available after GROUP BY, so they must be filtered using HAVING.

having -----------------------------------------
The HAVING clause is used to filter groups and it is used after the GROUP BY operation.
It is commonly used with aggregate functions such as COUNT(), SUM(), AVG(), MIN(), and MAX().
*/

# Display employees whose salary is greater than 50,000.
select * from employees
where salary>50000;

# Display department name having more than 2 employees.
select * from employees;
select d.department_id ,d.department_name,count(*) as temp_count
from employees e
join departments d
on e.department_id=d.department_id
group by department_id,department_name
having count(*) >2;

-- Q22. What is the purpose of the DISTINCT keyword?
/* The DISTINCT keyword is used to remove duplicate values from the result set and return only unique records.
It is commonly used with the SELECT statement when duplicate data should not appear in the output.
and it can be used with multiple column.
*/
select distinct department_id,employee_name
from employees;

/* Q23. What is the difference between = and IN?
The = operator is used to compare a column with a single value, whereas the IN operator is used to compare a column with multiple values.
IN is a shorter and more readable alternative to using multiple OR conditions.
*/

/* Q24. What is the purpose of the BETWEEN operator?
The BETWEEN operator is used to filter values that lie within a specified range.
It is inclusive, meaning it includes both the lower and upper boundary values. It can be used with numbers, dates, and text.

Q25. Explain the use of the LIKE operator.
The LIKE operator is used for pattern matching in SQL.
It is commonly used with the % and _ wildcard characters to search for values that match a specific pattern.
*/
-- Question: Display employees whose name starts with 'S'
select employee_name from employees
where employee_name like 'S%';

-- Question: Display employees whose third character in the name is 'A'.
select employee_name from employees
where employee_name like '____a%';

-- Q27. What is the difference between IS NULL and = NULL?
-- IS NULL is used to check whether a column contains a NULL value. and =NULL is incorrect because NULL itself a unknown value and cant be compared with = operator.alter
select * from employees;
select employee_name from employees
where manager_id is null;

-- Q30. Write an SQL query to display customers whose city is not 'Mumbai'.
select customer_name from customers
where city!='Mumbai';