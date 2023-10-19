-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:
USE employees;
-- 1 Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
SELECT first_name, last_name, dept_no, from_date, to_date,
	IF (to_date > NOW(), true, false) as "is_current_employee"
FROM employees
	JOIN dept_emp
		USING (emp_no)
;

SELECT emp_no
, concat(first_name,' ',last_name) as Full_Name
, dept_no
, from_date
, to_date
, IF (to_date > NOW(), true, false) as 'is_current_employee' 
FROM employees
	JOIN dept_emp
		USING (emp_no)
; 
-- 2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name, 
	CASE
	WHEN last_name BETWEEN 'a' AND 'h' THEN 'A-H'
    -- WHEN last_name BETWEEN 'i' AND '%q%' THEN 'I-Q'
    -- ELSE 'R-Z'
    END as 'alpha_group'
	, CASE 
	WHEN last_name BETWEEN 'i' AND 'q' THEN 'I-Q'
    END as 'alpha_group'
    , CASE
	WHEN last_name BETWEEN 'r' AND 'z' THEN 'R-Z'
	END as 'alpha_group'
-- 	, IF (last_name IN ('a','b','c','d','e','f','g','h'), true, false) as 'A-H'
--     , IF (last_name IN ('i','j','k','l','m','n','o','p','q'), true, false) as 'I-Q'
--     , IF (last_name IN ('r','s','t','u','v','w','x','y','z'), true, false) as 'R-Z'
FROM employees
ORDER BY last_name
;

SELECT last_name,-- last_name, left(last_name,1), -- substr(last_name,1,1)
	CASE
		WHEN left(last_name,1) <= 'H' THEN 'A-H'
        WHEN substr(last_name,1,1) >= 'Q' THEN 'I-Q'
        ELSE 'R-Z'
	END as alpha_group
FROM employees
;

SELECT first_name, last_name
, CASE
	WHEN last_name BETWEEN substr('a%') AND substr('h%') THEN 'A-H'
	WHEN last_name BETWEEN 'i%' AND 'q%' THEN 'I-Q'
    ELSE 'R-Z'
    END as 'alpha_group'
FROM employees
ORDER BY last_name DESC
;
Select birth_date
FROM employees
;
Select count(*)
FROM employees
;

-- 3 How many employees (current or previous) were born in each decade?
SELECT first_name, last_name, birth_date, 
    COUNT(
		CASE
		WHEN birth_date LIKE '195%' THEN '50s'
        END
        )
        ,
	COUNT(
		CASE
        WHEN birth_date LIKE '196%' THEN '60s'
        END
        )
FROM employees
GROUP BY first_name, last_name, birth_date
;
USE employees;
SELECT 
	CASE
		WHEN birth_date LIKE '195%' AND birth_date < '1960-01-01'THEN '50s'
        WHEN birth_date LIKE '196%' AND birth_date < '1970-01-01'THEN '60s'
        ELSE 0
	END as decade
    , count(*)
FROM employees
GROUP BY decade
    ; 

SELECT min(birth_date), max(birth_date) -- Check bithday range
FROM employees 
;     

SELECT 
	CASE
		WHEN birth_date LIKE '195%' THEN '50s'
        WHEN birth_date LIKE '196%' THEN '60s'
        ELSE 'other'
        END as Birth_Decade
        , count(*) as cnt
FROM employees
GROUP BY Birth_Decade
;
-- 4 What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT
	 CASE
		WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        ELSE 'Customer Service'
        END as dept_group
        , AVG(salary) as 'Average Salary'
FROM departments
	JOIN dept_emp
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
WHERE salaries.to_date > NOW() 
AND dept_emp.to_date >NOW() -- gets us most up to date salaries
GROUP BY dept_group 
    ;

SELECT 
	CASE
		WHEN dept_no IN ('d009',  
FROM departments
	JOIN dept_emp
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
	
; 

SELECT avg(salary)
FROM departments
	JOIN dept_emp
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
	WHERE dept_no = 'd009' -- 58770.3665
	;
SELECT avg(salary)
FROM departments
	JOIN dept_emp
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
	WHERE dept_no = 'd008'-- 59665.1817
    ;

SELECT avg(salary)
FROM departments
	JOIN dept_emp
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
	WHERE dept_no = 'd007'-- 80667
    ;
    
SELECT avg(salary)
FROM departments
	JOIN dept_emp
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
	WHERE dept_no = 'd006' -- 7251.2719
    ;

SELECT avg(salary), dept_name
FROM departments
	JOIN dept_emp
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
GROUP BY dept_name
    ;
    -- development is d005 and research is d008
-- d007 is Sales and d001 is Marketing
-- d004 is prod and QM is d006
--  Finance is d002 and HR is d003
-- customer service is d009,

-- BONUS

-- Remove duplicate employees from exercise 1.