SELECT @@VERSION;

--Database Creation
CREATE DATABASE Retail_Sales_db;

--Delete entire table with the structure if already been created
DROP TABLE IF EXISTS retail_sales;

--Make sure table is created inside the correct database
USE Retail_Sales_db;

--Table creation
CREATE TABLE retail_sales (
    TransactionID INT,
    Date DATE,
    CustomerID VARCHAR(20),
    Gender VARCHAR(10),
    Age INT,
    ProductCategory VARCHAR(50),
    Quantity INT,
    PricePerUnit DECIMAL(10,2),
    TotalAmount DECIMAL(10,2)
);

--confirm the table exists
--Use SQL Server system view (`INFORMATION_SCHEMA.COLUMNS`) and this gives you a clean list of all column names.
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'retail_sales';

--Or to view all the columns name
SELECT * FROM retail_sales;

--Use `sp_help` (quick table overview)and this shows: column names, data types, nullability, constraints
EXEC sp_help 'retail_sales';

--Import CSV Using BULK INSERT (SQL Server)
USE Retail_Sales_db;

BULK INSERT retail_sales
FROM '/var/opt/mssql/data/retail_sales_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

--to check all the data available to the table 
SELECT * FROM retail_sales;


--Data Exploration & Cleaning

--Total Records
SELECT COUNT(*) AS total_sales FROM retail_sales;

--Unique Customers
SELECT COUNT(DISTINCT CustomerID) AS unique_customers FROM retail_sales;

--Product Categories
SELECT DISTINCT ProductCategory FROM retail_sales;

--Checking for Null Values. Identifying missing values
SELECT * FROM retail_sales
WHERE TransactionID IS NULL
    OR Date IS NULL
    OR CustomerID IS NULL
    OR Gender IS NULL
    OR Age IS NULL
    OR ProductCategory IS NULL
    OR Quantity IS NULL
    OR PricePerUnit IS NULL
    OR TotalAmount IS NULL;

--Removing Incomplete Records
DELETE FROM retail_sales
WHERE TransactionID IS NULL
    OR Date IS NULL
    OR CustomerID IS NULL
    OR Gender IS NULL
    OR Age IS NULL
    OR ProductCategory IS NULL
    OR Quantity IS NULL
    OR PricePerUnit IS NULL
    OR TotalAmount IS NULL;

-- Q.1 write a query for retrive all column query for sales made in this mounth "2022-11-05"
SELECT * FROM retail_sales 
WHERE Date = '2023-11-05'; 

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE LOWER(ProductCategory) = 'clothing'
  AND Date >= '2023-11-01'
  AND Date <  '2023-12-01'
  AND Quantity > 2;
    
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    ProductCategory,
    SUM(TotalAmount) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY ProductCategory;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(Age), 2) as avg_age
FROM retail_sales
WHERE ProductCategory = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE TotalAmount > 1200;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    ProductCategory,
    Gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
    ProductCategory,
    gender
ORDER BY 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
   EXTRACT(YEAR FROM sale_date) AS year,
   EXTRACT(MONTH FROM sale_date) AS month,
   AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1, 3 DESC;


-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT TOP 5
    CustomerID,
    SUM(TotalAmount) AS total_sales
FROM retail_sales
GROUP BY CustomerID
ORDER BY total_sales DESC;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
    ProductCategory,
    COUNT(DISTINCT CustomerID) as cnt_unique_cs
FROM retail_sales
GROUP BY ProductCategory;

-- Q.10 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        DATEPART(YEAR, Date) AS year,
        DATEPART(MONTH, Date) AS month,
        AVG(TotalAmount) AS avg_sale,
        RANK() OVER(
            PARTITION BY DATEPART(YEAR, Date)
            ORDER BY AVG(TotalAmount) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY 
        DATEPART(YEAR, Date),
        DATEPART(MONTH, Date)
) AS t1
WHERE rank = 1;

-- End of project
