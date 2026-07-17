use company_db;

-- finding secong highest salary 

select salary from employees
order by salary desc limit 5;

select distinct salary
from employees 
order by salary desc
limit 1 offset 1;

 select max(salary) as second_highest_sal from employees 
where salary < (select max(salary) from employees);

-- Q34. Write an SQL query to calculate the total salary paid to all employees.
select sum(salary) as  total_salary_paid from employees;

-- Q35. Write an SQL query to find the average salary of employees in each department.
select d.department_name,avg(e.salary) AS AVG_sal from employees e
join departments d
on e.department_id=d.department_id
group by d.department_id,d.department_name;

-- Q35. Write an SQL query to find the max salary of employees in each department.
select d.department_name,max(e.salary) as max_sal from employees e
join departments d
on e.department_id=d.department_id
group by d.department_id,d.department_name;

-- second highest form each dept
select d.department_name,e.salary as sec_max_sal from(
select department_id,salary,dense_rank() over( partition by department_id order by salary desc) as rnk from employees
) e
join departments d
on e.department_id=d.department_id
where e.rnk=2;

select * from employees;

-- Q36. Write an SQL query to count the number of employees in each department.
select d.department_name,count(employee_id) from employees e
join departments d
on e.department_id=d.department_id
group by d.department_id,d.department_name;

-- Q37. Write an SQL query to find the highest salary in the Employees table.
select employee_name,salary from employees where
salary=(select max(salary) from employees);

-- Q38. Write an SQL query to find the second highest salary without using window functions.
select employee_name,salary from employees
 where salary =( select max(salary) from employees 
 where salary< (select max(salary) from employees));
 
 -- using window function
 select employee_name,salary from (
 select salary ,dense_rank() over ( 
 partition by department_id order by salary desc) as rnk from employees )e
 where e.rnk=2;
