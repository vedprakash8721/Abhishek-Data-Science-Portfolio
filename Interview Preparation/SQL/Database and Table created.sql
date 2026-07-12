-- ==========================================
-- CREATE DATABASE
-- ==========================================

DROP DATABASE IF EXISTS company_db;
CREATE DATABASE company_db;

USE company_db;

-- ==========================================
-- DEPARTMENTS
-- ==========================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- ==========================================
-- EMPLOYEES
-- ==========================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    age INT,
    gender ENUM('Male','Female','Other'),
    salary DECIMAL(10,2),
    department_id INT,
    manager_id INT NULL,
    joining_date DATE,
    city VARCHAR(100),

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);

-- ==========================================
-- CUSTOMERS
-- ==========================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(20),
    city VARCHAR(100),
    signup_date DATE
);

-- ==========================================
-- CATEGORIES
-- ==========================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) UNIQUE
);

-- ==========================================
-- PRODUCTS
-- ==========================================

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150),
    category_id INT,
    price DECIMAL(10,2),
    stock INT,

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

-- ==========================================
-- ORDERS
-- ==========================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- ==========================================
-- ORDER ITEMS
-- ==========================================

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- ==========================================
-- PAYMENTS
-- ==========================================

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

-- ==========================================
-- SUPPLIERS
-- ==========================================

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(150),
    city VARCHAR(100)
);

-- ==========================================
-- INVENTORY
-- ==========================================

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    supplier_id INT,
    quantity_available INT,

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
);

-- ==========================================
-- ACCOUNTS
-- ==========================================

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_type VARCHAR(50),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- ==========================================
-- TRANSACTIONS
-- ==========================================

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    transaction_date DATE,
    amount DECIMAL(12,2),
    transaction_type ENUM('Credit','Debit'),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

USE company_db;

-- ==========================================
-- INSERT INTO DEPARTMENTS
-- ==========================================

INSERT INTO departments (department_name)
VALUES
('HR'),
('Finance'),
('Sales'),
('Marketing'),
('IT'),
('Operations'),
('Customer Support'),
('Research & Development');

-- ==========================================
-- INSERT INTO CATEGORIES
-- ==========================================

INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Fashion'),
('Home & Kitchen'),
('Books'),
('Sports'),
('Beauty'),
('Toys'),
('Groceries');

-- ==========================================
-- INSERT INTO EMPLOYEES
-- ==========================================

INSERT INTO employees
(employee_name,email,phone,age,gender,salary,department_id,manager_id,joining_date,city)
VALUES

('Amit Sharma','amit@company.com','9876500001',45,'Male',120000,5,NULL,'2016-03-12','Mumbai'),

('Priya Singh','priya@company.com','9876500002',42,'Female',115000,3,NULL,'2017-06-18','Delhi'),

('Rahul Verma','rahul@company.com','9876500003',39,'Male',98000,5,1,'2019-01-10','Pune'),

('Neha Gupta','neha@company.com','9876500004',35,'Female',85000,3,2,'2020-05-22','Bengaluru'),

('Rohit Patel','rohit@company.com','9876500005',31,'Male',76000,2,1,'2021-02-15','Ahmedabad'),

('Anjali Mehta','anjali@company.com','9876500006',29,'Female',72000,4,2,'2022-04-09','Jaipur'),

('Karan Shah','karan@company.com','9876500007',33,'Male',81000,6,1,'2020-08-30','Surat'),

('Sneha Joshi','sneha@company.com','9876500008',30,'Female',69000,7,2,'2021-11-14','Nagpur'),

('Vikas Kumar','vikas@company.com','9876500009',27,'Male',62000,3,2,'2023-01-19','Lucknow'),

('Pooja Yadav','pooja@company.com','9876500010',26,'Female',60000,5,1,'2023-07-11','Indore'),

('Arjun Nair','arjun@company.com','9876500011',34,'Male',83000,8,1,'2019-09-17','Kochi'),

('Meera Iyer','meera@company.com','9876500012',28,'Female',65000,1,1,'2022-12-05','Chennai');

-- ==========================================
-- INSERT INTO CUSTOMERS
-- ==========================================

INSERT INTO customers
(customer_name,email,phone,city,signup_date)
VALUES

('Raj Malhotra','raj@gmail.com','9123400001','Mumbai','2023-01-15'),

('Simran Kaur','simran@gmail.com','9123400002','Delhi','2023-02-10'),

('Aakash Jain','aakash@gmail.com','9123400003','Pune','2023-03-12'),

('Riya Sharma','riya@gmail.com','9123400004','Jaipur','2023-04-08'),

('Mohit Singh','mohit@gmail.com','9123400005','Lucknow','2023-05-11'),

('Kavita Patel','kavita@gmail.com','9123400006','Ahmedabad','2023-06-20'),

('Suresh Rao','suresh@gmail.com','9123400007','Hyderabad','2023-07-02'),

('Nisha Verma','nisha@gmail.com','9123400008','Bengaluru','2023-08-15'),

('Deepak Gupta','deepak@gmail.com','9123400009','Indore','2023-09-03'),

('Pallavi Joshi','pallavi@gmail.com','9123400010','Nagpur','2023-10-18'),

('Ankit Mishra','ankit@gmail.com','9123400011','Kanpur','2024-01-06'),

('Shreya Roy','shreya@gmail.com','9123400012','Kolkata','2024-02-14'),

('Harsh Agarwal','harsh@gmail.com','9123400013','Noida','2024-03-01'),

('Divya Sinha','divya@gmail.com','9123400014','Patna','2024-04-10'),

('Yash Desai','yash@gmail.com','9123400015','Surat','2024-05-16');

SELECT * FROM departments;

SELECT * FROM categories;

SELECT * FROM employees;

SELECT * FROM customers;

USE company_db;

-- ==========================================
-- INSERT INTO PRODUCTS
-- ==========================================

INSERT INTO products (product_name, category_id, price, stock)
VALUES
('iPhone 15',1,79999,40),
('Samsung Galaxy S24',1,69999,50),
('Dell Inspiron Laptop',1,58999,25),
('Boat Headphones',1,1999,120),
('Nike Running Shoes',2,4999,80),
('Levis Jeans',2,2499,100),
('Puma T-Shirt',2,1499,150),
('Air Fryer',3,6999,30),
('Mixer Grinder',3,3499,60),
('Dining Table',3,15999,15),
('Atomic Habits',4,599,200),
('Rich Dad Poor Dad',4,399,180),
('Cricket Bat',5,2499,50),
('Football',5,899,100),
('Yoga Mat',5,999,120),
('Face Wash',6,299,250),
('Perfume',6,1499,90),
('Lipstick',6,799,140),
('Remote Car',7,1299,70),
('Building Blocks',7,999,110),
('Rice 10kg',8,799,150),
('Cooking Oil 5L',8,1099,100),
('Sugar 5kg',8,299,200),
('Wheat Flour 10kg',8,499,170);

-- ==========================================
-- INSERT INTO ORDERS
-- ==========================================

INSERT INTO orders
(customer_id, employee_id, order_date, total_amount)
VALUES

(1,4,'2024-01-05',79999),
(2,9,'2024-01-10',4999),
(3,4,'2024-01-12',58999),
(4,10,'2024-01-15',1999),
(5,9,'2024-01-20',2499),

(6,4,'2024-02-02',15999),
(7,10,'2024-02-05',6999),
(8,9,'2024-02-08',999),
(9,4,'2024-02-12',599),
(10,10,'2024-02-18',1499),

(11,9,'2024-03-01',69999),
(12,4,'2024-03-05',3499),
(13,10,'2024-03-10',1099),
(14,9,'2024-03-14',899),
(15,4,'2024-03-18',2499),

(2,9,'2024-04-02',399),
(4,10,'2024-04-07',799),
(6,4,'2024-04-11',999),
(8,9,'2024-04-18',1299),
(10,4,'2024-04-22',499),

(1,10,'2024-05-03',299),
(3,9,'2024-05-06',799),
(5,4,'2024-05-12',1099),
(7,10,'2024-05-18',2499),
(9,4,'2024-05-25',6999),

(11,9,'2024-06-04',1999),
(12,10,'2024-06-08',58999),
(13,4,'2024-06-15',999),
(14,9,'2024-06-20',1499),
(15,10,'2024-06-28',79999);

SELECT * FROM products;

SELECT * FROM orders;

USE company_db;

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1,1,1,79999),
(2,5,1,4999),
(3,3,1,58999),
(4,4,1,1999),
(5,6,1,2499),
(6,10,1,15999),
(7,8,1,6999),
(8,15,1,999),
(9,11,1,599),
(10,17,1,1499),
(11,2,1,69999),
(12,9,1,3499),
(13,22,1,1099),
(14,14,1,899),
(15,13,1,2499),
(16,12,1,399),
(17,18,1,799),
(18,20,1,999),
(19,19,1,1299),
(20,24,1,499),
(21,16,1,299),
(22,23,2,399),
(23,22,1,1099),
(24,13,1,2499),
(25,8,1,6999),
(26,4,1,1999),
(27,3,1,58999),
(28,20,1,999),
(29,17,1,1499),
(30,1,1,79999);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES

(3,11,2,599),
(3,16,1,299),

(6,21,2,799),
(6,22,1,1099),

(11,4,2,1999),
(11,15,1,999),

(18,16,3,299),
(18,23,2,299),

(25,17,1,1499),
(25,12,2,399),

(30,18,2,799),
(30,14,3,899);

USE company_db;

-- ==========================================
-- INSERT INTO PAYMENTS
-- ==========================================

INSERT INTO payments
(order_id, payment_date, payment_method, payment_status)
VALUES

(1,'2024-01-05','Credit Card','Completed'),
(2,'2024-01-10','UPI','Completed'),
(3,'2024-01-12','Net Banking','Completed'),
(4,'2024-01-15','Debit Card','Completed'),
(5,'2024-01-20','UPI','Completed'),

(6,'2024-02-02','Credit Card','Completed'),
(7,'2024-02-05','Cash','Completed'),
(8,'2024-02-08','UPI','Completed'),
(9,'2024-02-12','Credit Card','Completed'),
(10,'2024-02-18','Debit Card','Completed'),

(11,'2024-03-01','Net Banking','Completed'),
(12,'2024-03-05','UPI','Completed'),
(13,'2024-03-10','Cash','Completed'),
(14,'2024-03-14','Credit Card','Completed'),
(15,'2024-03-18','Debit Card','Completed'),

(16,'2024-04-02','UPI','Completed'),
(17,'2024-04-07','Credit Card','Completed'),
(18,'2024-04-11','Cash','Completed'),
(19,'2024-04-18','UPI','Completed'),
(20,'2024-04-22','Debit Card','Completed'),

(21,'2024-05-03','UPI','Completed'),
(22,'2024-05-06','Credit Card','Completed'),
(23,'2024-05-12','Net Banking','Completed'),
(24,'2024-05-18','Cash','Completed'),
(25,'2024-05-25','Credit Card','Completed'),

(26,'2024-06-04','Debit Card','Completed'),
(27,'2024-06-08','Credit Card','Completed'),
(28,'2024-06-15','UPI','Completed'),
(29,'2024-06-20','Cash','Pending'),
(30,'2024-06-28','Net Banking','Completed');

-- ==========================================
-- INSERT INTO SUPPLIERS
-- ==========================================

INSERT INTO suppliers
(supplier_name, city)
VALUES
('Tech Distributors Pvt Ltd','Mumbai'),
('Global Electronics','Delhi'),
('Fashion Hub','Surat'),
('Home Essentials','Jaipur'),
('Book World','Kolkata'),
('Sports India','Pune'),
('Beauty Care Ltd','Bengaluru'),
('Fresh Grocery Suppliers','Ahmedabad');

USE company_db;

-- ==========================================
-- INSERT INTO INVENTORY
-- ==========================================

INSERT INTO inventory (product_id, supplier_id, quantity_available)
VALUES
(1,1,40),
(2,2,35),
(3,1,20),
(4,1,120),
(5,3,80),
(6,3,100),
(7,3,150),
(8,4,30),
(9,4,60),
(10,4,15),
(11,5,200),
(12,5,180),
(13,6,50),
(14,6,100),
(15,6,120),
(16,7,250),
(17,7,90),
(18,7,140),
(19,6,70),
(20,6,110),
(21,8,150),
(22,8,100),
(23,8,200),
(24,8,170);

-- ==========================================
-- INSERT INTO ACCOUNTS
-- ==========================================

INSERT INTO accounts (customer_id, account_type)
VALUES
(1,'Savings'),
(2,'Savings'),
(3,'Current'),
(4,'Savings'),
(5,'Current'),
(6,'Savings'),
(7,'Current'),
(8,'Savings'),
(9,'Savings'),
(10,'Current'),
(11,'Savings'),
(12,'Current'),
(13,'Savings'),
(14,'Current'),
(15,'Savings');

-- ==========================================
-- INSERT INTO TRANSACTIONS
-- ==========================================

INSERT INTO transactions
(account_id, transaction_date, amount, transaction_type)
VALUES

(1,'2024-01-05',79999,'Debit'),
(1,'2024-01-07',100000,'Credit'),

(2,'2024-01-10',4999,'Debit'),
(2,'2024-01-15',15000,'Credit'),

(3,'2024-01-12',58999,'Debit'),
(3,'2024-01-20',90000,'Credit'),

(4,'2024-01-15',1999,'Debit'),
(4,'2024-01-18',12000,'Credit'),

(5,'2024-01-20',2499,'Debit'),
(5,'2024-01-25',18000,'Credit'),

(6,'2024-02-02',15999,'Debit'),
(6,'2024-02-08',50000,'Credit'),

(7,'2024-02-05',6999,'Debit'),
(7,'2024-02-09',22000,'Credit'),

(8,'2024-02-08',999,'Debit'),
(8,'2024-02-11',15000,'Credit'),

(9,'2024-02-12',599,'Debit'),
(9,'2024-02-15',12000,'Credit'),

(10,'2024-02-18',1499,'Debit'),
(10,'2024-02-22',18000,'Credit'),

(11,'2024-03-01',69999,'Debit'),
(11,'2024-03-05',120000,'Credit'),

(12,'2024-03-05',3499,'Debit'),
(12,'2024-03-10',25000,'Credit'),

(13,'2024-03-10',1099,'Debit'),
(13,'2024-03-15',10000,'Credit'),

(14,'2024-03-14',899,'Debit'),
(14,'2024-03-18',9000,'Credit'),

(15,'2024-03-18',2499,'Debit'),
(15,'2024-03-25',20000,'Credit');

-- -------------------------
USE company_db;

-- ==========================================
-- VIEWS
-- ==========================================

-- Employee Details View

CREATE VIEW employee_details AS
SELECT
e.employee_id,
e.employee_name,
d.department_name,
e.salary,
e.city,
e.joining_date
FROM employees e
JOIN departments d
ON e.department_id=d.department_id;

------------------------------------------------

-- Customer Orders View

CREATE VIEW customer_orders AS
SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.order_date,
o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id;

------------------------------------------------

-- Product Sales View

CREATE VIEW product_sales AS
SELECT
p.product_id,
p.product_name,
SUM(oi.quantity) AS total_quantity,
SUM(oi.quantity*oi.price) AS total_sales
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_id,p.product_name;

------------------------------------------------

-- Department Salary View

CREATE VIEW department_salary AS
SELECT
d.department_name,
COUNT(e.employee_id) total_employees,
AVG(e.salary) average_salary,
MAX(e.salary) highest_salary,
MIN(e.salary) lowest_salary
FROM departments d
LEFT JOIN employees e
ON d.department_id=e.department_id
GROUP BY d.department_name;

USE company_db;

CREATE INDEX idx_employee_salary
ON employees(salary);

CREATE INDEX idx_employee_department
ON employees(department_id);

CREATE INDEX idx_customer_city
ON customers(city);

CREATE INDEX idx_order_date
ON orders(order_date);

CREATE INDEX idx_order_customer
ON orders(customer_id);

CREATE INDEX idx_product_category
ON products(category_id);

CREATE INDEX idx_transaction_date
ON transactions(transaction_date);

CREATE INDEX idx_payment_status
ON payments(payment_status);

CREATE INDEX idx_product_price
ON products(price);

CREATE INDEX idx_employee_joining
ON employees(joining_date);

--

USE company_db;

-- ==========================================
-- PROCEDURE 1
-- Show all employees of a department
-- ==========================================

DELIMITER $$

CREATE PROCEDURE GetEmployeesByDepartment(
    IN dept_name VARCHAR(100)
)
BEGIN
    SELECT
        e.employee_id,
        e.employee_name,
        e.salary,
        d.department_name
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    WHERE d.department_name = dept_name;
END $$

DELIMITER ;

-- ==========================================
-- PROCEDURE 2
-- Customer Purchase History
-- ==========================================

DELIMITER $$

CREATE PROCEDURE GetCustomerOrders(
    IN cust_id INT
)
BEGIN

SELECT
c.customer_name,
o.order_id,
o.order_date,
o.total_amount

FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id

WHERE c.customer_id=cust_id;

END $$

DELIMITER ;

-- ==========================================
-- PROCEDURE 3
-- Department Salary Report
-- ==========================================

DELIMITER $$

CREATE PROCEDURE DepartmentSalaryReport()
BEGIN

SELECT

d.department_name,

COUNT(*) Employees,

AVG(salary) AverageSalary,

MAX(salary) HighestSalary,

MIN(salary) LowestSalary

FROM employees e

JOIN departments d

ON e.department_id=d.department_id

GROUP BY d.department_name;

END $$

DELIMITER ;

USE company_db;

DELIMITER $$

CREATE FUNCTION AnnualSalary(monthly_salary DECIMAL(10,2))

RETURNS DECIMAL(12,2)

DETERMINISTIC

BEGIN

RETURN monthly_salary*12;

END $$

DELIMITER ;

USE company_db;

DELIMITER $$

CREATE TRIGGER update_inventory_after_order

AFTER INSERT

ON order_items

FOR EACH ROW

BEGIN

UPDATE products

SET stock=stock-NEW.quantity

WHERE product_id=NEW.product_id;

END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER prevent_negative_stock

BEFORE UPDATE

ON products

FOR EACH ROW

BEGIN

IF NEW.stock<0 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Stock cannot be negative';

END IF;

END $$

DELIMITER ;