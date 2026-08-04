use company_db;
-- 
-- Q41. What is the difference between an INNER JOIN and a LEFT JOIN?

-- INNER JOIN returns only the rows that have matching values in both tables.
-- LEFT JOIN returns all rows from the left table and the matching rows from the right table. If no match exists, the right table columns contain NULL.
-- INNER JOIN: Match hai → Row aayegi; Match nahi hai → Row nahi aayegi.
-- LEFT JOIN: Left table ki row hamesha aayegi; Match nahi hai → Right table ke columns NULL honge.
-- INNER JOIN: 
SELECT
   e.*,d.*
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- left join
select e.* ,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id;

-- Q42. Explain when you would use a RIGHT JOIN.
/*A RIGHT JOIN is used when you want all rows from the right table and only the matching rows from the left table.
If there is no match, the left table columns return NULL.
*/
-- Write a MySQL query to retrieve all departments and their employee names using a RIGHT JOIN. Include all departments, even if they have no employees.
select e.employee_name,d.department_name
from employees e
right join departments d
on e.department_id = d.department_id;

-- Q43. What is a FULL OUTER JOIN? In which SQL databases is it directly supported?
/*
A FULL OUTER JOIN returns all rows from both tables.
If a row has a match, it combines the data from both tables.
If there is no match, the missing side returns NULL.
It is directly supported in databases such as PostgreSQL, SQL Server, and Oracle.
It is not directly supported in MySQL.
*/
-- Write a MySQL query to retrieve all employees and all departments, including unmatched records from both tables, using a FULL OUTER JOIN.
select e.employee_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
union
select e.employee_name,d.department_name
from employees e
right join departments d
on e.department_id=d.department_id;

/* Q46. Consider two tables: Customers(customer_id, customer_name) and Orders(order_id, customer_id, order_date).
Write an SQL query to retrieve all customers along with their orders, including customers who have not placed any orders.
*/
select c.customer_name,o.order_id
from customers c
left join orders o
on c.customer_id=o.customer_id;

-- Q47. Using the same tables, write an SQL query to find customers who have never placed an order.
select c.customer_name
from customers c
left join orders o
on c.customer_id=o.customer_id
where o.order_id is null;

-- Q48. Write an SQL query to display all orders that do not have a matching customer.
select o.order_id
from orders o
left join customers c
on o.customer_id=c.customer_id
where c.customer_id is null;

-- Q49. Given Employees(employee_id, manager_id, employee_name), write an SQL query to display each employee along with their manager's name.
select e.employee_name as Employee_name,
m.employee_name as Manager_name
from employees e
left join employees m
on e.manager_id=m.employee_id;