-- Create a file named temporary_tables.sql to do your work for this exercise.

-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
Use ursula_2331;
CREATE TEMPORARY TABLE EWD AS
SELECT first_name, last_name, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

Select * 
FROM EWD;
-- 1 Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
alter table EWD add full_name VARCHAR(100);
-- SELECT SUM('first_name' + 'last_name') FROM EWD;
-- 2 Update the table so that the full_name column contains the correct data.
update EWD set full_name = CONCAT(first_name,' ',last_name);
alter table EWD drop column full_name;
-- 3 Remove the first_name and last_name columns from the table.
alter table EWD drop column first_name, drop column last_name;
-- 4 What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE EWD2 AS
SELECT dept_name, CONCAT(first_name,' ',last_name) as full_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

SELECT *
FROM EWD2;
-- 2 Create a temporary table based on the payment table from the sakila database.
Use sakila;
SELECT *
FROM payment;
USE ursula_2331;

CREATE TEMPORARY TABLE IF NOT EXISTS Sakila3 AS
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM sakila.payment
LIMIT 100;
-- 2.1 Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE Sakila3 MODIFY amount DECIMAL(10,2);
update Sakila3 set amount = amount * 100;
alter table Sakila3 modify amount INTEGER;

SELECT *
FROM Sakila3;


-- 3 Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?
    -- Returns the current z-scores for each salary
    -- Notice that there are 2 separate scalar subqueries involved

-- Overall current salary stats
select 
	avg(salary), 
    std(salary)
from employees.salaries 
where to_date > now();

-- 72,012 overall average salary
-- 17,310 overall standard deviation


-- Saving my values for later... that's what variables do (with a name)
-- Think about temp tables like variables
use employees;

drop table overall_aggregates;
-- get overall std 
create temporary table overall_aggregates as (
    select 
		avg(salary) as avg_salary,
        std(salary) as overall_std
    from employees.salaries  where to_date > now()
);

select * from overall_aggregates;


-- Let's check out our current average salaries for each department
-- If you see "for each" in the English for a query to build..
-- Then, you're probably going to use a group by..
-- want to compare each departments average salary to the overall std and overall avg salary

drop table current_info;
-- get current average salaries for each department
create temporary table current_info as (
    select 
		dept_name, 
        avg(salary) as department_current_average
    from employees.salaries s
    join employees.dept_emp de
		on s.emp_no=de.emp_no and 
        de.to_date > NOW() and 
        s.to_date > NOW()
    join employees.departments d
		on d.dept_no=de.dept_no
    group by dept_name
);

select * from current_info;


-- add on all the columns we'll end up needing:
alter table current_info add overall_avg float(10,2);
alter table current_info add overall_std float(10,2);
alter table current_info add zscore float(10,2);

-- set the avg and std
update current_info set overall_avg = (select avg_salary from overall_aggregates);
update current_info set overall_std = (select overall_std from overall_aggregates);


-- update the zscore column to hold the calculated zscores
update current_info 
set zscore = (department_current_average - overall_avg) / overall_std;


select * from current_info;

select 
	max(zscore) as max_score
from current_info 
where max(zscore) = .97
;

-- Finding and using the z-score

-- A z-score is a way to standardize data and compare a data point to the mean of the sample.

-- Formula for the z-score

-- z
-- =
-- x
-- −
-- μ
-- σ

-- Notation	Description
-- z
-- the z-score for a data point
-- x
-- a data point
-- μ
-- the average of the sample
-- σ
-- the standard deviation of the sample
-- Hint The following code will produce the z-score for current salaries. Compare this to the formula for z-score shown above.


--     -- Returns the current z-scores for each salary
--     -- Notice that there are 2 separate scalar subqueries involved
--     SELECT salary,
--         (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
--         /
--         (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
--     FROM salaries
--     WHERE to_date > now();
-- BONUS Determine the overall historic average department average salary, the historic overall average, and the historic z-scores for salary. Do the z-scores for current department average salaries (from exercise 3) tell a similar or a different story than the historic department salary z-scores?

-- Hint: How should the SQL code used in exercise 3 be altered to instead use historic salary values?