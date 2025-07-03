# Aggregate function are used to perform calculation on dataset and return a single value.

-- these are as follows:
-- count(): returns number of values .
create database Company;
use Company;

create table Employee( Name varchar(20), Emp_id int primary key,Gender varchar(10),Department varchar(20),Salary int not null,city varchar(20));

CREATE TABLE Employee(
    Name VARCHAR(20),
    Emp_id INT PRIMARY KEY,
    Gender VARCHAR(10),
    Department VARCHAR(20),
    Salary INT NOT NULL,
    City VARCHAR(20)
);

INSERT INTO Employee (Name, Emp_id, Gender, Department, Salary, City) VALUES
("Abhishek", 101, "Male", "IT", 75000, "Lucknow"),
("Suhani", 102, "Female", "HR", 58000, "Kanpur"),
("Manvi", 103, "Female", "Finance", 67000, "Allahabad"),
("Anshu", 104, "Female", "IT", 72000, "Gorakhpur"),
("Raghav", 105, "Male", "Sales", 56000, "Bareilly"),
("Neha", 106, "Female", "Marketing", 60000, "Agra"),
("Vivek", 107, "Male", "IT", 82000, "Varanasi"),
("Kriti", 108, "Female", "Finance", 69000, "Basti"),
("Arjun", 109, "Male", "HR", 61000, "Noida"),
("Pooja", 110, "Female", "Sales", 55000, "Moradabad"),
("Nikhil", 111, "Male", "IT", 77000, "Sitapur"),
("Sneha", 112, "Female", "Marketing", 63000, "Raebareli"),
("Aman", 113, "Male", "Finance", 70000, "Mirzapur"),
("Tanya", 114, "Female", "HR", 58000, "Ballia"),
("Deepak", 115, "Male", "IT", 81000, "Ghazipur"),
("Ishita", 116, "Female", "Marketing", 62000, "Faizabad"),
("Ritesh", 117, "Male", "Finance", 73000, "Deoria"),
("Shalini", 118, "Female", "Sales", 54000, "Azamgarh"),
("Harsh", 119, "Male", "IT", 79000, "Sultanpur"),
("Aarti", 120, "Female", "HR", 60000, "Jaunpur");

select *from Employee;
-- USE OF AGGREGATE FUNCTION :
# COUNT():  this count the number of the value like num of Employee.
select count(name) from Employee;
-- returns 20

# MAX() : returns maximum or largest value like salary:
select max(Salary) from Employee; # this returns only maximum salary but if we want name too then:
-- method 1: 
select Name,Salary from Employee where Salary=(select max(Salary) from Employee);
-- method 2:
select Name ,Salary from Employee order by Salary desc limit 1;

# MIN() : same as max we can use and get results;
select Name ,City , Salary from Employee where Salary=(select min(Salary) from Employee);
select Name, City, Salary from Employee order by Salary asc limit 1;

