create database ved;
use ved;

create table students(
Roll_Number int primary key,
Name varchar(40),
 Attendance int not null);
 
insert into students values(06,"Abhishek Kushwaha",93),(05,"Heera Bete",100);
insert into students values(17,"Aman",93),(26,"Anshu",93);

select*from students;
drop table students;