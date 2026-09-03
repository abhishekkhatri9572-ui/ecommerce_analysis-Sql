# 🛒 E-Commerce Data Analytics Project (MySQL)

## 📌 Project Overview
This project focuses on analyzing an online retail dataset containing over 540K transaction records. Using MySQL Workbench, I built data ingestion pipelines, cleaned raw data, and derived key business metrics like revenue trends, customer segments, and product performance.

## 🛠️ Tools & Technologies Used
* **Database:** MySQL Workbench
* **Language:** SQL (Data Cleaning, Aggregations, Views, CTEs)
* **Dataset:** Kaggle E-Commerce Data (~541K rows)

## 🧹 Key Data Cleaning Steps
1. Filtered out negative quantities and unit prices (returns & cancellations).
2. Standardized text encodings using `latin1` during ingestion.
3. Handled missing `CustomerID` fields using conditional filtering.

## 📊 Business Insights & Key Queries
* **Total Revenue & Unique Orders:** Calculated overall metrics across all international sales.
* **Top-Selling Products:** Identified top 10 products by total volume sold.
* **Country-wise Revenue Breakdown:** Analyzed global revenue distribution to pinpoint top markets.
* **High-Value Orders:** Isolated transactions exceeding $500 for targeted customer retention.

## 🚀 How to Run
1. Create database: `CREATE DATABASE ecommerce_db;`
2. Run schema setup and import the dataset using `LOAD DATA LOCAL INFILE`.
3. Execute the SQL scripts in `ecommerce_analysis.sql`.
