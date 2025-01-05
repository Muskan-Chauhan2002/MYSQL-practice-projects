create database walmart;
use walmart;
ALTER TABLE sales CHANGE `Invoice ID` Invoice_id VARCHAR(255);
alter table sales change `Unit price` Unit_price int(255);
alter table sales change `Tax 5%` `Tax5%` int(255);
alter table sales change `Product line` Product_line varchar(255);
alter table sales change `Customer_table` Customer_type varchar(50);

SELECT 
    `time`,
    (CASE 
        WHEN `time` BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN `time` BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_day
FROM SALES;


select * from sales;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-------------------------- Product--------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- How many unique cities does the data have?
select distinct city from sales;

-- What is the most selling product line
select product_line , sum(quantity) as most_sold from sales
group by product_line
order by most_sold desc;

-- What is the total revenue by month

select date_format(Date,'%M') as month_name from sales;

SELECT month_name, SUM(total) AS total_revenue from 
(select date_format(Date,'%M') as month_name, total from sales) as monthly_sales
GROUP BY month_name
ORDER BY total_revenue desc;


-- What month had the largest COGS?

select month_name, sum(cogs) as largest_cogs from
(select date_format(Date,'%M') as month_name, cogs from sales) as months
group by month_name
order by largest_cogs desc;


-- What product line had the largest revenue?
select Product_line, sum(Total) as largest_revenue from sales
group by product_line
order by largest_revenue desc;


-- What is the city with the largest revenue?

select city, sum(total) as largest_revenue from sales
group by city
order by largest_revenue desc;

-- What product line had the largest VAT?
select product_line, sum(`Tax5%`) as largest_VAT
from sales
group by product_line
order by largest_VAT desc;

-- Fetch each product line and add a column to those product line 
-- showing "Good", "Bad". Good if its greater than average sales.

SELECT 
    product_line,
    SUM(total) AS total_sales,
   ( CASE
        WHEN
            SUM(total) > (SELECT 
                    AVG(total) AS avg_sales
                FROM
                    sales)
        THEN
            'Good'
        ELSE 'Bad'
    END) AS performance
FROM
    sales
GROUP BY product_line;


-- Which branch sold more products than average product sold?

select Branch, sum(Quantity) from sales
group by branch
having  sum(Quantity) > (select avg(Quantity) from sales)
order by sum(Quantity) desc;

-- What is the most common product line by gender?

SELECT
	gender, product_line, count(gender) as total_count_of_gender
    from sales
    group by gender, product_line
    order by count(gender) asc;
    
    
    -- What is the average rating of each product line?
    
    select product_line, avg(rating) as avg_rating 
    from sales
    group by Product_line;
    
    
    
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----------------------- -- Customer -- ---------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- How many unique customer types does the data have?

select  distinct  customer_type from sales;


-- How many unique payment methods does the data have?

select distinct payment from sales;

-- What is the most common customer type?

select customer_type, count(customer_type) as common_customer_type from sales
group by Customer_type
order by count(customer_type) desc;

-- Which customer type buys the most?

select customer_type, count(quantity) as most_buys from sales
group by customer_type
order by  count(quantity) desc;

-- What is the gender of most of the customers?

SELECT 
    gender, COUNT(*) AS customers
FROM
    sales
GROUP BY gender;

-- What is the gender distribution per branch?

select branch, count(gender) as gender_count from sales
group by branch
order by count(gender) desc;


-- Which time of the day do customers give most ratings?

select time,
( case
 when `time` between "00:00:00" and "12:00:00" then "Morning"
 when `time` between "12:01:00" and "16:00:00" then "Afternoon"
 else "Evening"
 end) as time_of_day 
 from sales;
 
SELECT
	( case
 when `time` between "00:00:00" and "12:00:00" then "Morning"
 when `time` between "12:01:00" and "16:00:00" then "Afternoon"
 else "Evening"
 end) as time_of_day,
	count(rating) AS most_rating
FROM sales
GROUP BY time_of_day
ORDER BY most_rating DESC;


-- Which time of the day do customers give most ratings per branch?

select branch, ( case
 when `time` between "00:00:00" and "12:00:00" then "Morning"
 when `time` between "12:01:00" and "16:00:00" then "Afternoon"
 else "Evening"
 end) as time_of_day, count(rating) as most_ratings, avg(rating) as avg_ratings from sales
 group by time_of_day,branch
 order by branch asc, count(rating) desc;


-- Which day of the week has the best avg ratings?

select dayname(date) as day_name, avg(rating) as avg_rating from sales
group by dayname(date) 
order by avg(rating) desc;

-- why is that the case, how many sales are made on these days?
select dayname(date), sum(total) as day_sale from sales
group by dayname(date)
order by sum(total) desc;


-- Which day of the week has the best average ratings per branch?
SELECT 
    branch,
    DAYNAME(date) AS day_name,
    COUNT(DAYNAME(date)) AS total_ratings,
    AVG(rating) AS avg_rating
FROM
    sales
WHERE
    branch = 'B'
GROUP BY branch , DAYNAME(date)
ORDER BY COUNT(DAYNAME(date)) DESC;


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- ----------------------------- Sales ----------------------------------------------- --
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday. --
select dayname(date) as day_name, ( case
 when `time` between "00:00:00" and "12:00:00" then "Morning"
 when `time` between "12:01:00" and "16:00:00" then "Afternoon"
 else "Evening"
 end) as time_of_day, sum(total) as sale from sales
 where dayname(date) = "Monday"
 group by dayname(date), time_of_day
 order by sum(total);


--  Which of the customer types brings the most revenue?
select customer_type, sum(total) as revenue from sales
group by Customer_type
order by sum(total) desc
limit 1;

-- Which city has the largest tax/VAT percent? --
select city, round(sum(`tax5%`)/sum(total)*100, 2) as Tax_percentage from sales
group by city
order by  tax_percentage desc;

