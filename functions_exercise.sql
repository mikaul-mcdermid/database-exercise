-- 1.)You may choose to copy the order by exercises and save it as functions_exercises.sql, to save time as you will be editing the queries to answer your functions exercises.

-- 2.)Write a query to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
USE employees;
SHOW tables;
DESCRIBE employees;
SELECT CONCAT(first_name, ' ', last_name) as full_name
FROM employees WHERE last_name LIKE 'E%E';
-- 3.)Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) as full_name FROM employees WHERE last_name LIKE 'E%E';
-- 4.)Use a function to determine how many results were returned from your previous query.
SELECT COUNT(CONCAT(first_name, ' ', last_name)) as full_name FROM employees WHERE last_name LIKE 'E%E';
-- 5.)Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
SELECT emp_no, first_name, last_name, birth_date, hire_date,
	DATEDIFF(NOW(), hire_date) as days_worked
    FROM employees WHERE (birth_date LIKE '%12-25') AND (hire_date BETWEEN '1990-01-01' AND '1999-12-31');
    -- WHERE EXTRACT(year from hire_date) BETWEEN 1990 AND 1999; -- hired in the 90s using extract
    -- AND birth_date LIKE '%12-25'; -- same function to extract Christmans birthdays
SELECT DATEDIFF(current_date, hire_date) as days_worked
FROM employees WHERE (birth_date LIKE '%12-25') AND (hire_date BETWEEN '1990-01-01' AND '1999-12-31');
-- 6.)Find the smallest and largest current salary from the salaries table.
USE employees;
DESCRIBE salaries;
SELECT MAX(salary), MIN(salary) FROM salaries;
SELECT MAX(salary) FROM salaries;
SELECT MIN(salary) FROM salaries;
# A: MAX - 158220 MIN - 38623
-- 7.)Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
SELECT LOWER(
			CONCAT(
				SUBSTR(first_name, 1 ,1), 
                SUBSTR(last_name, 1, 4),
                '_', 
                SUBSTR(birth_date, 6,2), 
                SUBSTR(birth_date, 3, 2)
                )
                ) as username, first_name, last_name, birth_date
FROM employees;