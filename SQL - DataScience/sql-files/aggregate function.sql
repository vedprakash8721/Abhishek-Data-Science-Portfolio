-- Information about the table --------------------------
describe sales_data;

-- table data ----------------------------
select * from sales_data limit 100;

-- Find maximum monthly spend
select max(monthly_spend) as Maximum_spent
from sales_data;

-- Find minimum age
select min(age) as MIn_age from sales_data;