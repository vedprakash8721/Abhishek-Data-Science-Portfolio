use company_db;
show tables;
-- 
/* Q59. What is a subquery?
A subquery is a query written inside another SQL query. It is used to provide a result that the outer query can use.
*/

-- Question: Find employees whose salary is greater than the average salary of all employees.
select employee_name,salary
from employees
where salary>(
select avg(salary)
from employees);

-- Q60. What is the difference between a correlated and a non-correlated subquery?
/*Non-correlated subquery: Runs independently of the outer query and usually executes once.
Correlated subquery: Depends on the outer query and is evaluated for each row processed by the outer query
*/

-- Q61. Write an SQL query to find employees earning more than the average salary.
select employee_name,salary
from employees
where salary>(
select avg(salary) from employees);

-- Q62. Write an SQL query to retrieve customers who placed the highest-value order.
select c.customer_name,o.order_id,o.total_amount
from customers c
join orders o
on c.customer_id=o.customer_id
where o.total_amount=(
select max(price) from order_items);

-- Q65. Explain the difference between IN, EXISTS, and ANY.
-- Question: Find employees who belong to departments that have at least one employee earning more than ₹75,000.
select e.employee_name,d.department_name
from employees e
join departments d
on e.department_id=d.department_id where e.department_id in (
select department_id
from employees
where salary>50000);