# Retail-Sales-Analysis-SQL-Project
This project focuses on analyzing retail sales data using SQL to uncover key business insights and trends. It demonstrates practical data analysis skills including data cleaning, transformation, and querying to answer real-world business questions.

Project Highlights

1. Database Setup & Data Import

•  Created a SQL Server database inside a Docker container
•  Designed a clean, normalized table schema
•  Imported CSV data using BULK INSERT
•  Validated data integrity and handled NULL/invalid values

2. Data Cleaning & Preparation

•  Standardized column names and data types
•  Checked for missing values using dynamic SQL
•  Ensured consistent formatting for dates and categories

3. Exploratory Data Analysis (EDA)

Includes SQL queries to analyze:

•  Monthly and daily sales trends
•  Top‑selling product categories
•  Customer demographics (age, gender)
•  High‑value transactions
•  Unique customer counts per category

4. Business Insights

Examples of insights generated:

•  Which product categories generate the highest revenue
•  Which customers contribute the most to total sales
•  Seasonal or monthly sales patterns
•  Average customer age by category
•  High‑value orders (>$1000)

5. SQL Techniques Used

•  Aggregations (SUM, COUNT, AVG)
•  Filtering with date ranges
•  Window functions
•  Grouping & ordering
•  Dynamic SQL for automated NULL checks
•  Performance‑friendly date filtering (YEAR(), MONTH())

/Retail-Sales-SQL-Project
│── data/
│   └── retail_sales_dataset.csv
│── sql/
│   ├── create_table.sql
│   ├── bulk_insert.sql
│   ├── data_cleaning.sql
│   ├── analysis_queries.sql
│── README.md
