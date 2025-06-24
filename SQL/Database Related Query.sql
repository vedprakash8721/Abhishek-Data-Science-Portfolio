# We will see some database query Syntax
-- For creating Database

create database db_name;

# best practice is to use "if not exists" because if you have already created then it will throw an error and when you use this 
-- if will throw an warning
# after creating database if you want to create table or anything then you have to do this

use db_name;

# when you want to see the list of databases
show databases;

# to delete the database 
drop database if exists db_name;

