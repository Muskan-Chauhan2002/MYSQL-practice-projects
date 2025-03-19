create database food_order;
use food_order;
-- change the table name--
ALTER TABLE order_history_kaggle_data RENAME TO order_data;

select * from order_data;

-- list the various subzones--
select `Items in order`, City, subzone from order_data
group by `Items in order`,city,subzone;

-- Enlist the Restaurant names--
select distinct `Restaurant name` from order_data;

-- Enlist the various delivery partners --
select distinct delivery from order_data;

-- Find out the most billed order--
select `Order Id`,`Bill Subtotal`as `Bill before discount n charges`, `Items in Order` from order_data
order by `bill subtotal` desc
limit 8;

-- delete unwanted columns--
select distinct `gold discount`, `brand pack discount` from order_data;
alter table order_data
drop column `gold discount`,
drop column `brand pack discount`;

-- Maximum ordered distance --
select Distance from order_Data
order by Distance desc
limit 1;

-- Average ordered distance --
select avg(distance) as Avg_distance from order_data;

-- Top rated food --
select `Restaurant name`, `Items in Order`, Rating from order_data
order by Rating desc;

-- Total packaging charges round off to two decimal points --
select round(sum(`Packaging charges`),2) as `Total Packaging Charged` from order_data;

-- Find Total discount provided --
select round(sum(`Restaurant discount (Promo)`),2) , round(sum(`Restaurant discount (Flat offs, Freebies & others)`),2) from order_data;

-- Both columns combined --
SELECT ROUND(SUM(`Restaurant discount (Promo)`) + SUM(`Restaurant discount (Flat offs, Freebies & others)`), 2) 
AS `Total Discount`
FROM order_data;

-- Rider wait time --
select min(`Rider wait time (minutes)`) as Min_Time, max(`Rider wait time (minutes)`) as Max_Time from order_data;

-- Average Rider wait time --
select  round(avg(`Rider wait time (minutes)`),2) as `Avg Rider wait time` from order_data;

-- Reviews --
SELECT `Restaurant name`, Review 
FROM order_data 
WHERE Review IS NOT NULL AND Review <> '';

-- Most orders placed timing --
select hour(`Order Placed at`) as `Order Hour`, count(*) as `Order Count`
from order_Data
group by `Order Hour`
order by `Order Count` desc, `Order Hour` asc;

-- Order time by AM/PM -- the datatype for date was text, convert that to correct format first --
SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Placed at`, '%h:%i %p'), '%h %p') AS order_hour_am_pm, 
    COUNT(*) AS order_count
FROM order_data
WHERE `Order Placed at` IS NOT NULL AND `Order Placed at` <> ''
GROUP BY order_hour_am_pm
ORDER BY order_count DESC;

-- Customer Complaint --
select `Restaurant name`, `Items in order`, `Customer complaint tag` from order_data
where `Customer complaint tag` is not null and `Customer complaint tag` <> '';

select Total from order_data
order by Total 
limit 1;