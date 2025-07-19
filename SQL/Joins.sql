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
create table student(
Roll_no int primary key,
 Name varchar(39)
 );
 
INSERT INTO student (Roll_no, Name) VALUES
(1, 'Aarav Sharma'),
(2, 'Ishita Verma'),
(3, 'Rohan Mehta'),
(4, 'Sneha Kapoor'),
(5, 'Yuvraj Singh'),
(6, 'Tanya Chauhan'),
(7, 'Kartik Joshi'),
(8, 'Simran Kaur'),
(9, 'Devansh Gupta'),
(10, 'Priya Nair');

create table Course(
Roll_no int unique,
course_name varchar(77)
);
 
INSERT INTO Course (Roll_no, course_name) VALUES
(1, 'Data Structures and Algorithms'),
(2, 'Operating Systems'),
(3, 'Computer Networks'),
(4, 'Database Management Systems'),
(5, 'Machine Learning'),
(6, 'Artificial Intelligence'),
(7, 'Software Engineering'),
(8, 'Web Development'),
(9, 'Cyber Security'),
(10, 'Cloud Computing');

select student.Roll_no,student.Name,Course.course_name from Course
inner join student
on student.Roll_no=Course.Roll_no;
