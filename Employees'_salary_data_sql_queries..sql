create database salary;
use salary;

-- show all rows and columns in the table.

SELECT 
    *
FROM
    salaries;


-- show only the employee name and job title column.

SELECT 
    EmployeeName, JobTitle
FROM
    salaries;


-- show the number of employees in the table.

SELECT 
    COUNT(*)
FROM
    salaries;


-- show the unique job titles in the table.

SELECT DISTINCT
    JobTitle
FROM
    salaries;


-- overtime pay greater than 50000.

SELECT 
    EmployeeName, JobTitle, OvertimePay
FROM
    salaries
WHERE
    OvertimePay > 50000;


-- show the average base pay for all employees.

SELECT 
    AVG(BasePay) AS avg_BasePay
FROM
    salaries;
    
    
    -- show the top 10 highest paid employees.
    
SELECT DISTINCT
    Id, EmployeeName, TotalPay
FROM
    salaries
ORDER BY TotalPay DESC
LIMIT 10;
    
    
    -- show the average of basepay, Overtime, and Otherpay for each employee.
    
SELECT 
    Id,
    EmployeeName,
    ROUND(AVG(BasePay + OvertimePay + OtherPay) / 3,
            2) AS avg_of_bp_ot_op
FROM
    salaries
GROUP BY Id , EmployeeName;
    
    
    -- show all employees who have the word "Manager" in their job.
    
SELECT 
    Id, EmployeeName, JobTitle
FROM
    salaries
WHERE
    JobTitle LIKE '%Manager%';



    -- show all employees with a job title not equal to "Manager".
    
    select Id, EmployeeName, JobTitle 
    from salaries
    where JobTitle not like 'Manager';
    
    
-- show all employees with a total pay between 100000 and 750000.

SELECT 
    Id, EmployeeName, TotalPay
FROM
    salaries
WHERE
    TotalPay BETWEEN 100000 AND 750000;
    
    
    -- show all employees with a base pay less than 50000 or a total pay greater than 100000.

SELECT 
    *
FROM
    salaries
WHERE
    BasePay <= 50000 OR TotalPay >= 100000;
    
    
    -- show all employees with a total pay benefits value  between 125,000 and 500,000
    -- and a job title containing the word "Director".
    
  SELECT 
    *
FROM
    salaries
WHERE
    JobTitle LIKE '%Director%'
        AND TotalPayBenefits BETWEEN 125000 AND 500000;
    
    
    -- show all job titles with an average base pay of at least 100000,
    -- and order them by the average base pay in descending order.
    
  SELECT 
    JobTitle, AVG(BasePay) AS Avg_basepay
FROM
    salaries
GROUP BY JobTitle
HAVING AVG(BasePay) >= 100000
ORDER BY AVG(BasePay) DESC;
    
    
    -- update the basepay of all employees with the jobtitle containing
    -- "Manager" by increasing it by 10%.
    
    set sql_safe_updates = 0;
    
    UPDATE salaries 
SET 
    BasePay = BasePay * 1.1
WHERE
    JobTitle LIKE '%Manager%';
    
SELECT 
    *
FROM
    salaries;
    
    
    -- delete all employees who have no OvertimePay.
    
   SELECT 
    *
FROM
    salaries
WHERE
    OvertimePay = 0;
DELETE FROM salaries;
    
    
