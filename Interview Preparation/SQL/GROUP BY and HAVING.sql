use company_db;

-- Question: How many employees are there in each department?
select d.department_id,d.department_name,count(e.employee_id) as total_emp_count
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_id,d.department_name
order by total_emp_count desc;

-- Q53. Write an SQL query to find departments whose average salary is greater than ₹75,000.
select d.department_name,avg(e.salary) as avg_sal
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_id
having avg_sal>75000;

-- Q54. Write an SQL query to display cities having more than 1 customers.
select city,count(customer_id) as total_customer
from customers
group by city
having total_customer>0;
select city,customer_name from customers;

-- Q55. Write an SQL query to find the number of orders placed by each customer.
select c.customer_name , count(c.customer_id) as total_ord_places
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.customer_id;

-- Q56. Write an SQL query to display product categories with total sales exceeding ₹10,000
select ct.category_name ,sum(oi.quantity*oi.price) as total_sales
from categories ct
join products p
on ct.category_id=p.category_id
join order_items oi
on p.product_id=oi.product_id
group by ct.category_id
having total_sales>10000;

-- Q58. Explain the difference between filtering before aggregation and after aggregation
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
WHERE salary > 50000
GROUP BY department_id
HAVING AVG(salary) > 75000;