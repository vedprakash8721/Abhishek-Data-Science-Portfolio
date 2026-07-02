create database pw;
use pw;

## CREATE COMMAND
create table if not exists Courses(
course_id varchar(20),
course_name varchar(20),
mode_of_delivery varchar(10),
student_intake int,
faculty varchar(30)
);

# ALTER COMMAND
alter table Courses change column mode_of_delivery delivery_mode varchar(10);

select * from Courses;
alter table Courses add column Location varchar(20);
alter table Courses rename to pw_courses;

# applying foreign key and primary key

create table Department(
dept_id int primary key,
dept_name varchar(10));
insert into Department values (101,'cse'),(102,'it'),(103,'ml');

create table student(
student_id int primary key,
student_name varchar(20),
dept_id int,
foreign key(dept_id) references Department(dept_id));
INSERT INTO student VALUES
(1, 'Ved', 101),
(2, 'Rahul', 102),
(3, 'Aman', 103);


insert into student values( 09,'rahul',1011);
select * from student;


