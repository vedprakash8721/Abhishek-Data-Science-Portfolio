# it collects data from multiple rows and groups the result in one or more column

INSERT INTO Employee (Name, Emp_id, Gender, Department, Salary, City) VALUES
("Abhishek", 301, "Male", "IT", 75000, "Lucknow"),
("Suhani", 302, "Female", "HR", 58000, "Ghazipur"),
("Manvi", 303, "Female", "Finance", 67000, "Lucknow"),
("Anshu", 304, "Female", "IT", 72000, "Mirzapur"),
("Raghav", 305, "Male", "Sales", 56000, "Varanasi"),
("Neha", 306, "Female", "Marketing", 60000, "Kanpur"),
("Vivek", 307, "Male", "IT", 82000, "Noida"),
("Kriti", 308, "Female", "Finance", 69000, "Lucknow"),
("Arjun", 309, "Male", "HR", 61000, "Ghazipur"),
("Pooja", 310, "Female", "Sales", 55000, "Kanpur"),
("Nikhil", 311, "Male", "IT", 77000, "Ghazipur"),
("Sneha", 312, "Female", "Marketing", 63000, "Allahabad"),
("Aman", 313, "Male", "Finance", 70000, "Noida"),
("Tanya", 314, "Female", "HR", 58000, "Lucknow"),
("Deepak", 315, "Male", "IT", 81000, "Varanasi"),
("Ishita", 316, "Female", "Marketing", 62000, "Ayodhya"),
("Ritesh", 317, "Male", "Finance", 73000, "Ghazipur"),
("Shalini", 318, "Female", "Sales", 54000, "Lucknow"),
("Harsh", 319, "Male", "IT", 79000, "Allahabad"),
("Aarti", 320, "Female", "HR", 60000, "Mirzapur"),
("Yash", 321, "Male", "IT", 75000, "Noida"),
("Divya", 322, "Female", "Finance", 66000, "Ayodhya"),
("Lakshya", 323, "Male", "Marketing", 61000, "Kanpur"),
("Payal", 324, "Female", "Sales", 57000, "Varanasi"),
("Ravi", 325, "Male", "Finance", 74000, "Ghazipur"),
("Tanvi", 326, "Female", "HR", 59000, "Ayodhya"),
("Zoya", 327, "Female", "Sales", 62000, "Allahabad"),
("Kunal", 328, "Male", "IT", 78000, "Lucknow"),
("Simran", 329, "Female", "Marketing", 60000, "Mirzapur"),
("Farhan", 330, "Male", "Finance", 71000, "Noida");


-- generally we use group by clause with aggregate function: 
select city from Employee group by city;
# this gives all cities. lets see further. if we want to see how much employee are from same cities and which? then do this
select city , count(name) from Employee group by city;

-- now the basis of city name too
select city ,name ,count(name) from Employee group by city , name;
#this gives output as grouped by city and name like from each city how many of them have similar name

-- to check that what is avg salary of each city employee

select city , avg(Salary) from employee group by city;

-- practice 
# we are trying to get the avg salary from each city in ascending order

select city ,avg(salary) from employee group by city order by avg(Salary) desc;

-- for top 3 cities
select city ,avg(salary) from employee group by city order by avg(Salary) desc limit 3;
