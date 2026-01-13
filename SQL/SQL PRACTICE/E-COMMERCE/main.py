import pandas as pd 
import duckdb
# LOADING THE DATA INTO VARIABLE
df=pd.read_csv(r"c:/MY SPACE/DATA SCIENCE AND GEN AI/Abhishek-Data-Science-Portfolio/SQL/SQL PRACTICE/E-COMMERCE/data/flipkart.csv")
# Duck db connection
conn=duckdb.connect()
# Registering dataframe into duckdb
conn.register("sales_df",df)

# Running the sql query
result= conn.execute(
    """
select * from sales_df limit 10
"""
).df()
print(result)