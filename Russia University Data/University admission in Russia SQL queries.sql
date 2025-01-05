create database admissions;
use admissions;

-- TO Activate ("")
SET sql_mode = 'ANSI_QUOTES';

rename table "university and vocational schools admission in russia 2014-2023" to university;
SELECT 
    *
FROM
    university;

    -- 1. What is the total number of admissions for each year?
SELECT 
    year, COUNT('number of students') AS total_admissions
FROM
    university
GROUP BY year
ORDER BY year DESC;
    
    -- 2. Which universities had the highest number of admissions in 2023?
    
SELECT 
    'branches of science',
    'group of professions',
    year,
    SUM('number of students') AS admissions
FROM
    university
WHERE
    year = 2023
GROUP BY 'branches of science' , 'group of professions'
ORDER BY admissions DESC
LIMIT 5;
    
    
    -- 3. What is the average number of admissions per university for each year?
    
SELECT 
    'branches of science',
    year,
    AVG('number of students') AS admissions
FROM
    university
GROUP BY 'branches of science' , year
ORDER BY admissions DESC;
    
    /* 4. What is the trend of admissions for a specific field of study (e.g., Computer Science) over the years? */
    
SELECT 
    year, SUM('number of students') AS no_of_admissions
FROM
    university
WHERE
    'group of professions' = 'computer science'
GROUP BY year
ORDER BY no_of_admissions DESC;
    
    #The trend of admissions for Computer Science is increasing over the years
    
   -- 5. What are the top 5 fields of study with the highest admissions in 2023?
   
   select "group of professions",sum("number of students") as admissions from university
   group by "group of professions"
   order by admissions desc
   limit 5;
    
    
    -- 6. How many total admissions were there for undergraduate and postgraduate programs in 2023?

    select year, "degree",sum("number of students") as admissions from university
    where year = 2023
    group by "degree"
    order by sum("number of students") desc;