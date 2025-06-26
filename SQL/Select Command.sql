-- SELECT : it is used to select any data from the database: 
# BASIC SYNTAX : select col_name from table_name;

# to select all : select * from table_name;

create database college;
use college;

create table Students(
Roll_no int primary key, 
Name varchar(20),
Marks int not null, Grade varchar(2), City varchar(20));

insert into Students value(05, "Abhishek Kumar Singh" , 91 , "A","deoria" ),(06,"Abhishek Kushwaha",91,"A","Ghazipur"),(67, "Ayan" , 93, "A", "sitapur"),
(26,"Anshu ", 92,"A"," mirjapur");
INSERT INTO Students VALUES(12, "Ritika Singh", 89, "B", "Lucknow"),
(18, "Shivam Yadav", 87, "A", "Allahabad"),
(29, "Nikita Verma", 85, "C", "Varanasi"),
(33, "Aditya Rai", 88, "A", "Jaunpur"),
(44, "Neha Mishra", 90, "B", "Kanpur"),
(50, "Ankit Verma", 92, "C", "Sultanpur"),
(21, "Sakshi Tiwari", 91, "B", "Azamgarh"),
(31, "Rahul Sharma", 86, "A", "Faizabad"),
(39, "Kriti Srivastava", 94, "A", "Barabanki"),
(55, "Mayank Dubey", 88, "B", "Ballia"),
(60, "Pooja Chauhan", 90, "C", "Basti"),
(17, "Vikrant Singh", 87, "A", "Mau"),
(23, "Sneha Gupta", 89, "B", "Gorakhpur"),
(73, "Alok Pandey", 85, "C", "Chandauli"),
(42, "Ishita Agarwal", 91, "A", "Noida"),
(66, "Deepak Chaudhary", 92, "B", "Mathura");

-- first we will see indivisual column
select Roll_no from Students; # shows roll no from the students table

-- now grouped columns
select Roll_no,Name from Students;

-- for all 
select*from Students;

-- DISTINCT keyword: distinct keyword return the unique values from the table, that means no duplicate values:
select distinct Marks from Students;


-- WHERE CLAUSE : to define some conditions
select *from Students where Roll_no=6;
select * from Students where Marks>90 and Grade="A";

-- so crazy things: if you want to see that if you add 10 marks to any student then  how much of them cross the 100 marks limit .
select*from Students where Marks+10>100;
select*from Students where Marks+10<100;

