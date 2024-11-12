create database Cars;
use Cars;

-- 1. read data --
 
RENAME TABLE `car dekho` TO car_dekho;
SELECT 
    *
FROM
    car_dekho;

-- 2.count the record --

SELECT 
    COUNT(*)
FROM
    car_dekho;

-- 3.cars available in the year 2023 --

SELECT 
    COUNT(*)
FROM
    car_dekho
WHERE
    year = '2023';
    
    -- 4.cars available in the years 2020,2021,2022.--

  select year,count(*) as numbers from car_dekho where year in (2020,2021,2022) group by year;
  
  -- 5.total of all cars by year --
  
SELECT 
    year, COUNT(*) AS numbers
FROM
    car_dekho
GROUP BY year;
  
  -- 6.diesel cars in the year 2020. --
  
SELECT 
    year, COUNT(*) AS numbers
FROM
    car_dekho
WHERE
    year = '2020' AND fuel = 'diesel'
GROUP BY fuel;
  
  -- 7.petrol cars in the year 2020 --
 SELECT 
    year, COUNT(*) AS numbers
FROM
    car_dekho
WHERE
    year = '2020 ' AND fuel = 'petrol'
GROUP BY fuel;
  
  -- 8.all fuel cars in all year --
SELECT 
    year, fuel, COUNT(*) AS numbers
FROM
    car_dekho
GROUP BY fuel , year;
 
 
 -- 9. a year with more than 100 cars. --
SELECT 
    year, COUNT(*)
FROM
    car_dekho
GROUP BY year
HAVING COUNT(*) > 100;

-- 10.  all cars' details between the year 2015 and 2023. --
SELECT 
    *
FROM
    car_dekho
WHERE
    year BETWEEN 2015 AND 2023;
    
    -- 11. all cars' count details between the year  2015 AND 2023. --
  SELECT 
    COUNT(*)
FROM
    car_dekho
WHERE
    year BETWEEN 2015 AND 2023;

 
 

