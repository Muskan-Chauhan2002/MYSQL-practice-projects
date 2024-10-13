 create database Placement;
 use Placement;
 
 
 -- Q1: Retrieve all records from the detailed_data table. 
 
 SELECT 
    *
FROM
    detailed_data;
 
 
 -- Q2: Count the total number of students placed from the detailed_data table.

SELECT 
    COUNT(*) AS placed
FROM
    detailed_data;
    
-- Q3: Find different regions within the region_mumbai table.

SELECT 
    *
FROM
    region_mumbai;
SELECT DISTINCT
    region
FROM
    region_mumbai;

-- Q4: List the top 5 companies that have recruited the most students from the placement_companies table.


SELECT 
    company_name, COUNT(*) AS company_count
FROM
    placement_companies
GROUP BY company_name
ORDER BY company_count DESC
LIMIT 5;


-- Q5: Find the salaries above 500,000 and count the number of regions for each salary.
--  Group by salary and display the results in descending order.

use placement;
SELECT 
    salary, COUNT(region)
FROM
    detailed_data
WHERE
    salary > 500000
GROUP BY salary
ORDER BY salary DESC;


-- Q6: Find the highest salary offered, company that offered and the college name ewho received it.

SELECT 
    company_name, college_name, salary
FROM
    detailed_data
ORDER BY salary DESC
LIMIT 1;


-- Q7: Find the average salary offered/received.

SELECT 
    AVG(salary)
FROM
    detailed_data;



-- Q8: Find the colleges who have a salary greater than the average salary.

SELECT 
    college_name, company_name, salary
FROM
    detailed_data
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            detailed_data)
ORDER BY salary DESC;