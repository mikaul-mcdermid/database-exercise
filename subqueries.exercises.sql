-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:
USE employees;
-- 1 Find all the current employees with the same hire date as employee 101010 using a subquery.
SELECT CONCAT(first_name,' ',last_name) as 'Employee Name', hire_date as 'Hire Date', emp_no as 'Employee Num'
FROM employees
WHERE hire_date = (
					SELECT hire_date
                    FROM employees
                    WHERE emp_no = 101010
                    )
;
-- 2 Find all the titles ever held by all current employees with the first name Aamod.
SELECT DISTINCT first_name, title as 'Titles Held' 
FROM titles
	JOIN employees
		USING (emp_no)
WHERE first_name = (
				SELECT first_name
				FROM employees
                WHERE first_name = 'Aamod%' AND to_date > NOW()
                )
                ;
SELECT first_name;
-- 3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT DISTINCT COUNT(*) as 'Fired'
	FROM employees 
	WHERE emp_no NOT IN (SELECT emp_no
						FROM salaries
						WHERE to_date > NOW());
-- 4 Find all the current department managers that are female. List their names in a comment in your code.
SELECT CONCAT(e.first_name,' ',e.last_name) as Names, gender
FROM (
	SELECT first_name, last_name, emp_no
	FROM employees
	WHERE gender = 'F') as emp_names
	JOIN employees e
		USING (emp_no)
	JOIN dept_manager dm
		USING (emp_no)
	WHERE to_date > NOW()
; -- 
-- 5 Find all the employees who currently have a higher salary than the companie's overall, historical average salary.
SELECT COUNT(emp_no) 
FROM salaries s
WHERE s.to_date > NOW() AND salary >= (SELECT round(avg(salary),0)
FROM salaries);


-- 6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built-in function to calculate the standard deviation.) What percentage of all salaries is this?
describe max salary;
-- describe stddev of max salary;
-- describe percentage of above results;

SELECT *
FROM salaries
WHERE salary BETWEEN 140910 AND 158220 AND to_date > NOW(); -- 220 employees within this range, 83 after filtering for now
-- (
SELECT MAX(salary) -- MAX salary of current employees
FROM salaries
WHERE to_date > NOW() -- 158220
AND 
(
SELECT STDDEV(salary)
FROM salaries
WHERE to_date > NOW());	-- 17309.96 -- current standard deviation 

SELECT STDDEV((SELECT MAX(salary) -- MAX salary of current employees
FROM salaries
WHERE to_date > NOW()));

SELECT MAX(salary) - ROUND(STD(salary),0) -- 140910 is the salary 1 STDDEV to the left of the max salary
FROM salaries
WHERE to_date > NOW();

SELECT COUNT(salary) 
FROM salaries
WHERE to_date > NOW() AND salary >= (
									SELECT MAX(salary) - ROUND(STD(salary),0) -- 140910 is the salary 1 STDDEV to the left of the max salary
									FROM salaries
									WHERE to_date > NOW()
                                    )
                                    ; -- this part gives us 83
SELECT COUNT(salary)
FROM salaries
WHERE to_date > NOW() 
							SELECT STDDEV((SELECT MAX(salary) -- MAX salary of current employees
							FROM salaries
							WHERE to_date > NOW())
                            )
                            ) - 
                            (
							SELECT STDDEV(salary) -- 1stddev 
							FROM salaries
							WHERE to_date > NOW()
                            )
;
SELECT (
		SELECT MAX(salary)
        FROM salaries
        WHERE to_date > NOW()
        )
        - * 100 / count(*)
FROM salaries
WHERE to_date > NOW();

SELECT (83 * 100)/ 240124;

SELECT COUNT(salary)
FROM salaries
WHERE to_date > NOW(); -- this gives us 240124 which is the total number of current salaries
;
SELECT COUNT(salary) * 100 / (
							SELECT COUNT(salary)
							FROM salaries
							WHERE to_date > NOW() -- 240124
							)
FROM salaries
WHERE to_date > NOW() AND salary >= (
									SELECT MAX(salary) - ROUND(STD(salary),0) -- 140910 is the salary 1 STDDEV to the left of the max salary
									FROM salaries
									WHERE to_date > NOW() -- 83
                                    )
                                    ;
-- -- Hint You will likely use multiple subqueries in a variety of ways
-- -- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
-- -- BONUS

-- -- Find all the department names that currently have female managers.
-- -- Find the first and last name of the employee with the highest salary.
-- -- Find the department name that the employee with the highest salary works in.

-- -- Who is the highest paid employee within each department.