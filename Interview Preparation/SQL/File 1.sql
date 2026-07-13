use company_db;

/* Q1. What is SQL, and why is it used?
SQL (Structured Query Language) is a standard language used to interact with relational databases.
It helps in performing operations such as retrieving, inserting, updating, deleting, and managing data.
SQL is widely used because it provides an efficient and standard way to query and manipulate structured data stored in databases.

Q2. What is the difference between a DBMS and an RDBMS?
A DBMS (Database Management System) is software used to store and manage data, whereas an RDBMS (Relational Database Management System) is a type of DBMS that stores data in table format.
An RDBMS supports Primary Keys, Foreign Keys, relationships, ACID properties, and uses SQL for data management. Most modern databases like MySQL, PostgreSQL are example of RDBMS.

Q3. What is a database table?
A database table is a structured collection of related data organized into rows and columns.
Each row represents a single record, and each column represents a specific attribute of that record.
Tables are the primary way data is stored in a relational database.

Q4. What is the difference between a row and a column?
A row represents a single record in a table, while a column represents a specific attribute or field of that record.
For example, in an employees table, one row represents one employee, and columns like employee_id, name, and salary store different pieces of information about that employee.

Q5. What are the different categories of SQL commands?
SQL commands are classified into five categories based on their purpose:
DDL (Data Definition Language): Defines and modifies database objects. Examples: CREATE, ALTER, DROP, TRUNCATE, RENAME.
DML (Data Manipulation Language): Inserts, updates, and deletes data. Examples: INSERT, UPDATE, DELETE.
DQL (Data Query Language): Retrieves data from the database. Example: SELECT.
DCL (Data Control Language): Manages user permissions and access. Examples: GRANT, REVOKE.
TCL (Transaction Control Language): Manages transactions. Examples: COMMIT, ROLLBACK, SAVEPOINT.

Q6. What is a primary key?
A Primary Key is a column or a combination of columns that uniquely identifies each record in a table.
It does not allow NULL values or duplicate values, ensuring that every row has a unique identity.

Q7. What is a foreign key?
A Foreign Key is a column or a combination of columns in one table that references the Primary Key of another table.
It is used to establish a relationship between tables and maintain referential integrity.

Q8. What is the difference between a primary key and a unique key?
a table can have only one Primary key and multiple unique key

Q9. What is a composite primary key?
A Composite Primary Key is a Primary Key made up of two or more columns.
It is used when a single column cannot uniquely identify a record, but the combination of multiple columns can.

Q10. What is the purpose of the NOT NULL constraint?
The NOT NULL constraint ensures that a column cannot store NULL values. It makes a value mandatory for every record.
*/

-- Q11. Write an SQL query to display all records from the Employees table
select * from employees;

-- Q12. Write an SQL query to display only the employee_name and salary columns from the Employees table.
select employee_name,salary from employees;

-- Q13. Write an SQL query to display unique department names from the Employees table.
select distinct department_name from departments;

-- Q14. Write an SQL query to retrieve employees whose salary is greater than 50,000.
select employee_name,salary from employees
where salary>50000;

-- Q15. Write an SQL query to display employees whose department is 'Sales'.
select e.* from employees e
join departments d
on e.department_id=d.department_id
where department_name='Sales';

-- Q16. Write an SQL query to retrieve employees whose age is between 25 and 35.
select * from employees
where age between 25 and 35;

-- Q17. Write an SQL query to display employees whose department is either 'HR' or 'Finance'.
select e.* from employees e
join departments d
on e.department_id=d.department_id
where department_name in ( 'HR','Finance');

-- Q18. Write an SQL query to retrieve employees whose name starts with the letter 'A'.
select * from employees
where employee_name like 'A%'; 

-- Q19. Write an SQL query to retrieve employees whose email ends with '@company.com'.
select * from employees
where email like '%@company.com';

-- Q20. Write an SQL query to display all employees sorted by salary in descending order.
select * from employees
order by salary desc;