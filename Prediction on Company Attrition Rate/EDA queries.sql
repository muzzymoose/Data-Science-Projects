SELECT *
FROM public.company;

--EXPLORATORY DATA ANALYSIS--



--Check employeeid max--
--[output 2068]--
SELECT MAX(employeeid)
FROM public.company;



--Check employeeid min-- 
--[output 1]--
SELECT MIN(employeeid)

FROM public.company;


--Counting number of attrition Yes/No-- 
--[output 1233 No, 237 Yes]--
SELECT 
	attrition,
	CASE WHEN attrition LIKE 'Yes' THEN COUNT(attrition) 
	ELSE COUNT(attrition) END AS attrition_count
FROM public.company
GROUP BY attrition;



--Calculating percentage of attrition Yes/No-- 
--[output 83.88% Yes, 16.12% No]--
WITH attrition_count AS (
	SELECT 
		attrition,
		CASE WHEN attrition LIKE 'Yes' THEN COUNT(attrition) 
		ELSE COUNT(attrition) END AS attrition_count
	FROM public.company
	GROUP BY attrition
	)
SELECT
	attrition, attrition_count,
	ROUND((attrition_count*1.0/SUM(attrition_count) OVER())*100,2) AS attrition_pct
FROM attrition_count
GROUP BY attrition, attrition_count;



--Checking age distribution--
--[output Employees mostly between Age 26-35]--
SELECT
	--attrition,
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        WHEN age BETWEEN 56 AND 60 THEN '56-60'
        ELSE 'Outside Range'
    END AS age_bin,
    COUNT(*) AS count
FROM public.company
WHERE age BETWEEN 18 AND 60
GROUP BY 
	--attrition, 
	age_bin
ORDER BY 
	--attrition, 
	age_bin;
	

-- Checking Income Distribution --
--[output Highest attrition rate observed in income_bin 1000-3000]--
WITH income_bins AS (                -- Create CTE for income bins
    SELECT
        attrition,
        CASE
            WHEN monthlyincome BETWEEN 1000 AND 3000 THEN '1000-3000'
            WHEN monthlyincome BETWEEN 3001 AND 5000 THEN '3001-5000'
            WHEN monthlyincome BETWEEN 5001 AND 7000 THEN '5001-7000'
            WHEN monthlyincome BETWEEN 7001 AND 9000 THEN '7001-9000'
            WHEN monthlyincome BETWEEN 9001 AND 11000 THEN '9001-11000'
            WHEN monthlyincome BETWEEN 11001 AND 13000 THEN '11001-13000'
            WHEN monthlyincome BETWEEN 13001 AND 15000 THEN '13001-15000'
            WHEN monthlyincome BETWEEN 15001 AND 17000 THEN '15001-17000'
            WHEN monthlyincome BETWEEN 17001 AND 19000 THEN '17001-19000'
            WHEN monthlyincome BETWEEN 19001 AND 21000 THEN '19001-21000'
            ELSE 'Out of Range'
        END AS income_bin
    FROM public.company
),
att_income AS (                    -- Create CTE for attrition percentage by income bin
    SELECT
        income_bin,
        attrition,
        COUNT(income_bin) AS count_att,
        ROUND((COUNT(income_bin) / SUM(COUNT(income_bin)) OVER (PARTITION BY income_bin)) * 100, 2) AS att_income_pct
    FROM income_bins
    GROUP BY income_bin, attrition
    ORDER BY
        CASE
            WHEN income_bin = '1000-3000' THEN 1
            WHEN income_bin = '3001-5000' THEN 2
            WHEN income_bin = '5001-7000' THEN 3
            WHEN income_bin = '7001-9000' THEN 4
            WHEN income_bin = '9001-11000' THEN 5
            WHEN income_bin = '11001-13000' THEN 6
            WHEN income_bin = '13001-15000' THEN 7
            WHEN income_bin = '15001-17000' THEN 8
            WHEN income_bin = '17001-19000' THEN 9
            WHEN income_bin = '19001-21000' THEN 10
            ELSE 11
        END,
        attrition
)
SELECT 
    income_bin,
    att_income_pct
FROM att_income
WHERE attrition = 'Yes'
ORDER BY att_income_pct DESC;

	

--Checking avg monthly income by Department and Attrition--
--Those with lower avg income have higher chance to leave the company--
SELECT 
	department, attrition,
	AVG(monthlyincome) AS avg_income, 
	MIN(monthlyincome) AS min_income,
	MAX(monthlyincome) AS max_income
FROM public.company
GROUP BY department, attrition
ORDER BY department, attrition;



--Checking avg monthly income by Department and Attrition--
--Those with lower avg income have higher chance to leave the company--
SELECT 
	jobrole, attrition,
	AVG(monthlyincome) AS avg_income, 
	MIN(monthlyincome) AS min_income,
	MAX(monthlyincome) AS max_income
FROM public.company
GROUP BY jobrole, attrition
ORDER BY jobrole, attrition;



--Checking Attrition Rate by jobrole--
--[Output Sales Representative have highest Attrition Rate]
WITH att_job AS (
	SELECT 
		jobrole, 
		attrition, 
		COUNT(jobrole) AS count,
		ROUND((COUNT(jobrole)/SUM(COUNT(jobrole)) OVER(PARTITION BY jobrole)*100),2) AS att_pct
	FROM public.company
	GROUP BY jobrole, attrition
	ORDER BY jobrole, attrition
	)
SELECT jobrole, att_pct
FROM att_job
WHERE attrition = 'Yes'
ORDER BY att_pct DESC;



--Checking Monthly Income by Jobrole--
--[output Sales Representative have least monthly income]--
SELECT jobrole, AVG(monthlyincome)
FROM public.company
GROUP BY jobrole
ORDER BY 2;



--Checking Attrition rate by jobroles and marital status--
--[output Highest attrition rate by from Sales Representative who are single]--
WITH att_job_status AS (
	SELECT 
		jobrole, 
		maritalstatus, 
		attrition, 
		COUNT(attrition) AS count_att,
		ROUND((COUNT(attrition)/SUM(COUNT(attrition)) 
			OVER(PARTITION BY jobrole, maritalstatus))*100,2) AS job_status_att_pct
	FROM public.company
	GROUP BY jobrole, maritalstatus, attrition
	ORDER BY jobrole, maritalstatus, attrition
)
SELECT jobrole, maritalstatus, job_status_att_pct
FROM att_job_status
WHERE attrition = 'Yes'
ORDER BY job_status_att_pct DESC;



--Check Age by Sales Representative and Marital status--
--[output High attrition rates among single employees between Age 18-25 particularly from 3 jobroles]
WITH age_salesrep AS (
	SELECT 
		attrition, maritalstatus,
		CASE
	        WHEN age BETWEEN 18 AND 25 THEN '18-25'
	        WHEN age BETWEEN 26 AND 35 THEN '26-35'
	        WHEN age BETWEEN 36 AND 45 THEN '36-45'
	        WHEN age BETWEEN 46 AND 55 THEN '46-55'
	        WHEN age BETWEEN 56 AND 60 THEN '56-60'
	        ELSE 'Outside Range'
	    END AS age_bin 
	FROM public.company
	WHERE 
		jobrole = 'Sales Representative' OR
		jobrole = 'Research Scientist' OR
		jobrole = 'Laboratory Technician'
)
SELECT 
	age_bin, attrition,
	COUNT(age_bin)
FROM age_salesrep
WHERE maritalstatus = 'Single'
GROUP BY age_bin, attrition
ORDER BY age_bin, attrition

