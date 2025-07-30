CREATE TABLE retail_sales
(
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

select * from retail_sales
limit 10;

select count(*) from retail_sales;

select * from retail_sales
where transactions_id is null;

select * from retail_sales
where
transactions_id is null
or
sale_date is null 
or
sale_time is null 
or
customer_id	is null 
or
gender	is null 
or
age	is null 
or
category is null 
or
quantity	is null 
or
price_per_unit	is null 
or
cogs is null 
or
total_sale is null ;

delete from retail_sales
where
transactions_id is null
or
sale_date is null 
or
sale_time is null 
or
customer_id	is null 
or
gender	is null 
or
age	is null 
or
category is null 
or
quantity	is null 
or
price_per_unit	is null 
or
cogs is null 
or
total_sale is null ;

-- DATA EXPLORATION
-- HOW MANY CUSTOMERS WE HAVE
select count( distinct customer_id) from retail_sales

-- HOW MANY CATEGORIES WE HAVE
select count( distinct category) from retail_sales


-- DATA ANALYSIS & BUSINESS KEY PROBLEMS

-- 1. Retrieve all columns for sales made on 2022-11-05.

select
  * 
from retail_sales
where sale_date= '2022-11-05';


-- 2. Retrieve all transactions where the category is 'Clothing' and quantity sold is more than 4 in November 2022.
select 
  *
from retail_sales
where category = 'Clothing' 
and to_char(sale_date,'yyyy-mm')='2022-11' 
and quantity >= 4

-- 3. Calculate the total sales (total_sale) for each category.
select 
 category,
 sum(total_sale) as net_sale
from retail_sales
group by category

-- 4. Find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
  ROUND(AVG(age), 2)
FROM retail_sales
WHERE category = 'Beauty';

-- 5. Find all transactions where the total_sale is greater than 1000.
SELECT 
  *
FROM retail_sales
WHERE total_sale>1000;

-- 6. Find the total number of transactions made by each gender in each category.

 SELECT 
  category ,
  gender ,
  count(*) as total_transaction
FROM retail_sales
group by 1,2;

-- 7. Calculate the average sale for each month and find out the best selling month in each year.
select * from(
SELECT 
  extract (year from sale_date) as year ,
  extract(month from sale_date) as month ,
  avg(total_sale) as avg_sale,
  rank() over(partition by  extract (year from sale_date) order by avg(total_sale) desc ) as rank
FROM retail_sales
group by 1,2
) as t1
where rank=1

-- 8. Find the top 5 customers based on the highest total sales.
select 
  customer_id,
  sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

-- 9. Find the number of unique customers who purchased items from each category.
select
  category,
  count(distinct customer_id) 
from retail_sales
group by 1

-- 10. Create each shift and number of orders (Morning <12, Afternoon between 12 & 17, Evening >17).
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

--END OF PROJECT






      