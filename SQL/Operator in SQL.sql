show databases;
show tables;
select*from Students;

-- AND operator: checks for both condition to be true
select *from Students where Marks>90 and city="Ghazipur"; # shows the data which has greater than 90 marks and city is Ghazipur
select *from Students where Marks>95 and city="Ghazipur"; # no result match


-- OR : checks for alteast one condition to be true:
select *from Students where Marks>95 or city ="Ghazipur"; #show result that has city is ghazipur and marks is greater than 95


-- BETWEEN : for a specific range of data 
select*from Students where Marks between 90 and 92;

-- IN : matches any value from the given list:
select*from Students where city in( "varanasi","Ghazipur");

-- NOT IN : negate the list
select*from Students where city not in( "varanasi","Ghazipur"); # all city excluded varanasi and ghazipur
