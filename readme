
# 🛍️ Retail Sales Analysis (PostgreSQL)

## 📌 Project Overview

This project demonstrates SQL skills commonly used by data analysts to explore, clean, and analyze retail sales data.
It covers **database setup**, **data cleaning**, and **business analysis** using SQL queries.

---

## ✅ Objectives

1. **Database Setup:** Create and populate a retail sales database.
2. **Data Cleaning:** Handle missing values and ensure data integrity.
3. **EDA (Exploratory Data Analysis):** Understand the dataset structure and patterns.
4. **Business Insights:** Answer key business questions using SQL queries.

---

## 🗂️ Database Schema

```sql
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

## 🔍 Data Cleaning Queries

```sql

-- Unique Customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Unique Categories
SELECT DISTINCT category FROM retail_sales;

-- Null Value Check
SELECT * FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
      gender IS NULL OR age IS NULL OR category IS NULL OR
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Delete Null Records
DELETE FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
      gender IS NULL OR age IS NULL OR category IS NULL OR
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

---

## 📊 Business Analysis Queries

### 1. Sales on `2022-11-05`

```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### 2. Clothing category, quantity > 4, in Nov-2022

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
```

### 3. Total sales by category

```sql
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

### 4. Average age of customers for Beauty category

```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 5. Transactions with total\_sale > 1000

```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

### 6. Total transactions by gender and category

```sql
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

### 7. Best-selling month in each year

```sql
SELECT year, month, avg_sale
FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)
                       ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) t
WHERE rank = 1;
```

### 8. Top 5 customers by total sales

```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### 9. Unique customers per category

```sql
SELECT category, COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;
```

### 10. Number of orders by shift (Morning, Afternoon, Evening)

```sql
WITH hourly_sale AS (
    SELECT *,
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

---

## 📈 Insights

* **Sales Trends:** Seasonal peaks identified.
* **Top Categories:** Clothing & Beauty categories drive revenue.
* **High-Value Orders:** Multiple transactions exceed 1000 units.
* **Customer Insights:** Top spenders and demographic patterns.

---

