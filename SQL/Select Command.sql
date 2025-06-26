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

-- first we will see indivisual column
select Roll_no from Students; # shows roll no from the students table

-- now grouped columns
select Roll_no,Name from Students;

-- for all 
select*from Students;

-- DISTINCT keyword: distinct keyword return the unique values from the table, that means no duplicate values:
select distinct Marks from Students;

