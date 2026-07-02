-- joins : joins are of four types :
/*
1: inner join
2: left outer join
3: right outer join
4: full outer join
*/

# lets talk about inner join: it performs the join such as from table A and table B it return those values that are common
create database college;
use college;


CREATE TABLE Student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    phone VARCHAR(15)
);

INSERT INTO Student VALUES
(1,'Aarav Sharma',20,'Male','Delhi','9876543210'),
(2,'Ishita Verma',21,'Female','Mumbai','9876543211'),
(3,'Rohan Mehta',22,'Male','Pune','9876543212'),
(4,'Sneha Kapoor',20,'Female','Jaipur','9876543213'),
(5,'Yuvraj Singh',23,'Male','Lucknow','9876543214'),
(6,'Tanya Chauhan',21,'Female','Bhopal','9876543215'),
(7,'Kartik Joshi',22,'Male','Indore','9876543216'),
(8,'Simran Kaur',20,'Female','Chandigarh','9876543217'),
(9,'Devansh Gupta',24,'Male','Kanpur','9876543218'),
(10,'Priya Nair',22,'Female','Kochi','9876543219'),
(11,'Devansh rata',24,'Male','zys','9876543218');


CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    roll_no INT UNIQUE,
    course_name VARCHAR(100),
    instructor VARCHAR(50),
    duration_months INT,
    fees DECIMAL(8,2),
    FOREIGN KEY (roll_no) REFERENCES Student(roll_no)
);

INSERT INTO Course VALUES
(101,1,'Data Structures','Ankit Sharma',6,25000),
(102,2,'Operating Systems','Neha Verma',5,22000),
(103,3,'Computer Networks','Rahul Singh',4,21000),
(104,4,'Database Management Systems','Pooja Gupta',6,26000),
(105,5,'Machine Learning','Amit Kumar',8,45000),
(106,6,'Artificial Intelligence','Ritika Jain',8,50000),
(107,7,'Software Engineering','Sandeep Mishra',5,23000),
(108,8,'Web Development','Karan Patel',4,20000),
(109,9,'Cyber Security','Vivek Sharma',7,35000),
(110,10,'Cloud Computing','Anjali Mehta',6,30000),
(111,12,'Cloud Computing','ss Mehta',7,30000);

select student.Roll_no,student.Name,Course.course_name from Course
inner join student
on student.Roll_no=Course.Roll_no;

select student.Roll_no ,Course.course_name from Course
inner join student
on student.Roll_no=Course.Roll_no;

select * from student;
select * from course;

## Left Join

select s.roll_no,s.name,c.course_name,c.fees
from student as s
left join course as c
on s.roll_no=c.roll_no order by fees desc limit 5;

## Right join

select * 
from course as c
right join student as s
on c.roll_no=s.roll_no order by fees desc limit 10;


## full join
select * 
from student as s
left join course as c
on s.roll_no=c.roll_no
union
select* 
from student as s
right join course as c
on s.roll_no=c.roll_no;


## left exlusive join
select * 
from student as s
left join course as c
on s.roll_no=c.roll_no
where c.roll_no is null;

## right exclusive join