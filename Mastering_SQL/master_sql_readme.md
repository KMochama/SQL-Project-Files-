# Master SQL -- Complete Learning Roadmap & Real‑World Case Studies

![SQL](https://img.shields.io/badge/Language-SQL-blue)
![Database](https://img.shields.io/badge/Domain-Databases-green)
![Level](https://img.shields.io/badge/Level-Beginner%20to%20Advanced-orange)

## Overview

This repository provides a structured roadmap for mastering SQL from
database fundamentals to advanced query optimization and real-world
industry applications.

The guide covers: - Core relational database concepts - SQL query
development - Data manipulation and aggregation - Advanced analytics
queries - Query optimization - Real-world industry use cases

Industries covered in the case studies:

-   Sales & Retail
-   Finance
-   Customer Analytics
-   Healthcare
-   Manufacturing
-   Telecommunications

------------------------------------------------------------------------

# SQL Learning Structure

## 1. Database Fundamentals

Relational databases organize structured data into tables.

``` sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
```

Foreign Key Example

``` sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

------------------------------------------------------------------------

## 2. SQL Data Types

``` sql
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    created_at DATETIME
);
```

------------------------------------------------------------------------

## 3. DDL -- Data Definition Language

Create Database

``` sql
CREATE DATABASE sales_db;
```

Create Table

``` sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);
```

Alter Table

``` sql
ALTER TABLE employees
ADD department VARCHAR(50);
```

------------------------------------------------------------------------

## 4. DML -- Data Manipulation Language

Insert

``` sql
INSERT INTO employees (id, name, salary)
VALUES (1,'John Doe',50000);
```

Update

``` sql
UPDATE employees
SET salary = 55000
WHERE id = 1;
```

Delete

``` sql
DELETE FROM employees
WHERE id = 1;
```

------------------------------------------------------------------------

## 5. Data Query Language

Select Data

``` sql
SELECT * FROM employees;
```

Filter

``` sql
SELECT * 
FROM employees
WHERE salary > 50000;
```

Grouping

``` sql
SELECT department, COUNT(*)
FROM employees
GROUP BY department;
```

------------------------------------------------------------------------

# Real‑World SQL Case Studies

## 1. Sales / Retail Analytics

Business Question: Which product categories generate the highest
revenue?

``` sql
SELECT product_category,
SUM(sales_amount) AS total_sales
FROM sales
GROUP BY product_category
ORDER BY total_sales DESC;
```

Insight: Identify top-performing product categories to optimize
inventory and marketing spend.

------------------------------------------------------------------------

## 2. Finance Industry

Business Question: Calculate total revenue per month.

``` sql
SELECT 
DATE_TRUNC('month', transaction_date) AS month,
SUM(amount) AS revenue
FROM transactions
GROUP BY month
ORDER BY month;
```

Use Case: Financial performance reporting and revenue forecasting.

------------------------------------------------------------------------

## 3. Customer Analytics

Business Question: Identify high‑value customers.

``` sql
SELECT customer_id,
SUM(order_value) AS lifetime_value
FROM orders
GROUP BY customer_id
ORDER BY lifetime_value DESC;
```

Use Case: Customer segmentation and loyalty programs.

------------------------------------------------------------------------

## 4. Healthcare Analytics

Business Question: Find the number of patients treated per department.

``` sql
SELECT department,
COUNT(patient_id) AS patients_treated
FROM hospital_visits
GROUP BY department;
```

Use Case: Resource allocation and hospital performance monitoring.

------------------------------------------------------------------------

## 5. Manufacturing Industry

Business Question: Calculate production output by factory.

``` sql
SELECT factory_id,
SUM(units_produced) AS total_production
FROM production
GROUP BY factory_id;
```

Use Case: Production planning and operational efficiency analysis.

------------------------------------------------------------------------

## 6. Telecommunications

Business Question: Identify customers with the highest data usage.

``` sql
SELECT customer_id,
SUM(data_usage_gb) AS total_usage
FROM telecom_usage
GROUP BY customer_id
ORDER BY total_usage DESC;
```

Use Case: Network capacity planning and premium plan targeting.

------------------------------------------------------------------------

# Performance Optimization Example

View execution plan

``` sql
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1001;
```

Use indexes for faster queries

``` sql
CREATE INDEX idx_orders_customer
ON orders(customer_id);
```

------------------------------------------------------------------------

# SQL Ecosystem

Popular relational database systems:

-   MySQL
-   PostgreSQL
-   SQLite
-   Microsoft SQL Server
-   Oracle Database

------------------------------------------------------------------------

# Author

Kevin Osioma\
Data Analyst \| SQL \| Excel \| Data Engineering \| Business
Intelligence
