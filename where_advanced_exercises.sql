-- 1.)Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
USE employees;
SELECT database();
SHOW tables;
DESCRIBE employees; 
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
# A: 10200, 10397, 10610

-- 2.)Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?
SElECt * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
# A: 10200, 10397, 10610. It matches previous query
-- 3.)Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results?
SELECT * FROM employees WHERE first_name = 'irena' OR first_name = 'vidya' OR first_name = 'Maya' AND gender = 'M';
SELECT * FROM employees WHERE first_name IN ('irena', 'vidya', 'maya') AND gender = "M"; -- I get that it's part of the exercise, but HWHY!? This is so much less typing and achieves the same results
# A: 10200, 10397, 10821
-- 4.)Find all unique last names that start with 'E'.
SELECT * FROM employees WHERE last_name LIKE 'E%';
-- 5.)Find all unique last names that start or end with 'E'.
SELECT * FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
-- 6.)Find all unique last names that end with E, but does not start with E?
SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name NOT LIKE 'E%';
-- 7.)Find all unique last names that start and end with 'E'.
SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%';
-- 8.)Find all current or previous employees hired in the 90s. Enter a comment with the top three employee numbers.
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- 9.)Find all current or previous employees born on Christmas. Enter a comment with the top three employee numbers.
SELECT * FROM employees WHERE birth_date LIKE '%12-25';
-- 10.)Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the top three employee numbers.
SELECT * FROM employees WHERE (birth_date LIKE '%12-25') AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';
# A: 10261, 10438, 10681
-- 11.)Find all unique last names that have a 'q' in their last name.
SELECT * FROM employees WHERE last_name LIKE '%q%';
-- 12.)Find all unique last names that have a 'q' in their last name but not 'qu'.
SELECT * FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';