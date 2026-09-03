create database ecommerce_db;
use ecommerce_db;
drop table if exists data;
create table data(
invoiceNo varchar(50),
Stockcode varchar(50),
description TEXT,
Quantity INT,
InvoiceDate varchar(50),
UnitPrice DECIMAL(10,2),
CustomerID VARCHAR(50),
Country Varchar(100)
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'D:/archive/data.csv'
INTO TABLE data
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT COUNT(*) FROM DATA;


-- 1. Unique Customers Aur Total Orders Count (Basic)
SELECT 
    COUNT(DISTINCT CustomerID) AS TotalUniqueCustomers,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM data
WHERE CustomerID IS NOT NULL AND CustomerID != '';

-- 2. Top 10 Best-Selling Products By Quantity (Basic)
SELECT 
    Description,
    SUM(Quantity) AS TotalQuantitySold
FROM data
WHERE Quantity > 0
GROUP BY Description
ORDER BY TotalQuantitySold DESC
LIMIT 10;

-- 3. Country-Wise Total Revenue (Intermediate)
SELECT 
    Country,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue
FROM data
WHERE Quantity > 0
GROUP BY Country
ORDER BY TotalRevenue DESC;

-- 4. High-Value Transactions 
SELECT 
    InvoiceNo,
    CustomerID,
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS InvoiceTotal
FROM data
WHERE Quantity > 0
GROUP BY InvoiceNo, CustomerID, Country
HAVING InvoiceTotal > 500
ORDER BY InvoiceTotal DESC;

-- 5. Cancelled Orders 
SELECT 
    InvoiceNo,
    CustomerID,
    Description,
    Quantity,
    UnitPrice
FROM data
WHERE InvoiceNo LIKE 'C%'
LIMIT 20;


-- 1. Missing CustomerIDs 'Unknown' mark 
SELECT 
    InvoiceNo,
    COALESCE(CustomerID, 'Unknown') AS CleanCustomerID,
    Country,
    ROUND(Quantity * UnitPrice, 2) AS LineTotal
FROM data
LIMIT 10;

-- 2. Clean Sales View 
CREATE OR REPLACE VIEW v_clean_sales AS
SELECT *
FROM data
WHERE Quantity > 0 
  AND UnitPrice > 0
  AND CustomerID IS NOT NULL 
  AND CustomerID != '';

-- 3. Created View Clean Data Verify 
SELECT COUNT(*) AS CleanedRowCount FROM v_clean_sales;

-- 4. Product Descriptions Trim & Standardize
SELECT DISTINCT 
    StockCode,
    TRIM(UPPER(Description)) AS CleanDescription
FROM data
WHERE Description IS NOT NULL
ORDER BY CleanDescription ASC
LIMIT 10;