-- Create a new file called basic_statement_exercises.sql and save your work there. You should be testing your code in MySQL Workbench as you go.
SHOW databases;
-- Use the albums_db database.
USE albums_db;
SELECT database();
SHOW tables;
DESCRIBE albums;
-- What is the primary key for the albums table?
# A: id
-- What does the column named 'name' represent?
# A: the artist's name
-- What do you think the sales column represents?
# A: The amount they sold
-- Find the name of all albums by Pink Floyd.
select release_date from albums
where name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

SELECT name
FROM albums
WHERE artist = 'Pink Floyd';
# A: The Dark Side of the Moon & The Wall
-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
# A: 1967
-- What is the genre for the album Nevermind?
SELECT genre
FROM albums
WHERE name = 'Nevermind';
# A: Grunge, Alternative rock
-- Which albums were released in the 1990s?
SELECT name
FROM albums
WHERE release_date BETWEEN 1990 and 1999;
# A: 'Titanic: Music from the Motion Picture'
-- 'The Immaculate Collection'
-- 'The Bodyguard'
-- 'Supernatural'
-- 'Nevermind'
-- 'Metallica'
-- 'Let\'s Talk About Love'
-- 'Jagged Little Pill'
-- 'Falling into You'
-- 'Dangerous'
-- 'Come On Over'


-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name as low_selling_albums FROM albums
WHERE sales < 20000000;
# A: 'Thriller'
-- 'Back in Black'
-- 'The Dark Side of the Moon'
-- 'Bat Out of Hell'
-- 'The Bodyguard'
-- 'Their Greatest Hits (1971–1975)'
-- 'Saturday Night Fever'
-- 'Rumours'
-- 'Grease: The Original Soundtrack from the Motion Picture'
-- 'Led Zeppelin IV'
-- 'Bad'
-- 'Jagged Little Pill'
-- 'Come On Over'
-- 'Falling into You'
-- 'Sgt. Pepper\'s Lonely Hearts Club Band'
-- 'Hotel California'
-- 'Dirty Dancing'
-- '21'
-- 'Let\'s Talk About Love'
-- '1'
-- 'Dangerous'
-- 'The Immaculate Collection'
-- 'Abbey Road'
-- 'Born in the U.S.A.'
-- 'Brothers in Arms'
-- 'Titanic: Music from the Motion Picture'
-- 'Metallica'
-- 'Nevermind'
-- 'The Wall'
-- 'Supernatural'
-- 'Appetite for Destruction'

SHOW databases;
USE chipotle;
SELECT database();
SHOW tables; -- only one table, called orders
SELECT * -- shows me everything
from orders;

# FORMAT: WHERE [column_name] LIKE %[value]%
# find all orders that are bowls
SELECT *
FROM orders -- table names are case sensitive
WHERE item_name = 'bowl';

SELECT *
FROM orders WHERE item_name LIKE '%bowl%'; -- have to utilize both LIKE and the % or MYSQL looks for the % sign in the name of your query

SELECT DISTINCT item_name FROM orders; -- allows us to select distinct names in specific category 
SELECT DISTINCT * FROM orders WHERE item_name LIKE '%bowl%'; -- doesn't specify what category we're looking for and only exact duplicates would be filtered out (which every order may slightly be different
SELECT DISTINCT item_name, quantity FROM orders WHERE item_name LIKE '%bowl%%'; -- Multiple distinct selector
SELECT DISTINCT item_name FROM orders WHERE item_name NOT LIKE '%bowl%'; -- utilizing the NOT command
# When using wildcards(%) you are checking for variables before or after a search term

# FORMAT: WHERE [column_name] BETWEEN [value1] AND [value2]
SELECT * FROM orders WHERE order_id BETWEEN 1 and 5;

# FORMAT: WHERE [column_name] IN ([value1],[value2],[value3])
SELECT * FROM orders WHERE item_name IN ('chicken bowl', 'veggie bowl'); -- have to use parenthesis or it will error out
SELECT * FROM orders WHERE order_id IN (1,2,3,4,5);
# Using a wildcard without a LIKE breaks the operation in SQL

# FORMAT: WHERE [column_name] IS [NOT] NULL -- the NOT is optional
USE join_example_db; -- select new database
SELECT database(); -- verify you're in the database
SHOW tables; -- shows tables

SELECT * FROM users WHERE role_id IS NULL; -- NULL command example, be sure to write out IS
SELECT * FROM users WHERE role_id IS NOT NULL; 

# FORMAT: WHERE [column_name] operator [value1] AND/OR [column_name2] operator [value2]
# AND will return rows when BOTH conditions are TRUE
# OR will return rows when EITHER condition is TRUE
SELECT * FROM users WHERE name = 'sally'; 
SELECT * FROM users WHERE role_id = 3 AND name = 'sally'; -- both conditions are true in this scenario
SELECT * FROM users WHERE role_id = 3 OR name = 'jane'; -- shows all possible true conditions
SELECT * FROM users WHERE role_id = 3 or 1; -- not a complete conditional statement (parenthesis around the values doesn't work either)
SELECT * FROM users WHERE role_id = 3,1; -- comma doesn't work either
SELECT * FROM users WHERE role_id IN (3,1); 


# FORMAT ORDER BY [column_name] [ASC/DES]alter
-- 1 SELECT
-- FROM
-- WHERE 
-- ORDER BY -- sorts our rows
USE chipotle; 
SELECT database();
SELECT * FROM orders WHERE item_name LIKE '%bowl%' AND quantity > 1 ORDER BY quantity ASC;
SELECT * FROM orders WHERE item_name LIKE '%bowl%' AND quantity > 1 ORDER BY quantity; -- defaults to ascending format, must manually select descending
SELECT * FROM orders WHERE item_name LIKE '%bowl%' AND quantity > 1 ORDER BY quantity DESC; 
SELECT * FROM orders WHERE item_name LIKE '%bowl%' AND quantity > 1 ORDER BY quantity DESC, item_name; -- order by is stackable and will sort left to right. In this example we chose quantity first and then item name so it will start with quantity unless we reverse the order
-- secondarily you need to select DESC/ASC for EACH order by modifier

# FORMAT: LIMIT [#]
-- SELECT
-- FROM
-- WHERE
-- ORDER BY
-- LIMIT

SELECT * FROM orders LIMIT 5;

# OFFSET -- used with LIMIT to skip a set amount of lines
SELECT * FROM orders LIMIT 5 OFFSET 10; -- must be used with a LIMIT

# ORDER BY RAND()
SELECT * FROM orders ORDER BY RAND() LIMIT 5;

USE farmers_market;
SELECT database();
SHOW tables;
DESCRIBE customer_purchases;
SELECT * FROM customer_purchases;
SELECT MIN(market_date) as "Min Date", MAX(market_date) as "Max Date"
FROM customer_purchases; -- How to utilize MIN() and MAX() simultaneously 

SELECT CONCAT('ID', market_date) FROM customer_purchases; -- How to utilize CONCAT()
SELECT NOW() - market_date FROM customer_purchases; -- How to get time difference (in seconds)
SELECT REPLACE(market_date, '-', '/') FROM customer_purchases;
SELECT SUBSTR(market_date,6,2) as month FROM customer_purchases;
-- LOWER must only contain one -- function at a time, trying to use it after another function causes it to error as you must input LOWER functions one at a time. You can circumvent this by placing the LOWER/UPPER in front of whatever function you're trying to run
-- SELECT [column_name_to_group], [column_that_you_summarize]
-- FROM
-- WHERE
-- GROUP BY [column_name_to_group]
USE chipotle;
SELECT item_name 
FROM orders
WHERE item_name LIKE '%chicken%'
GROUP BY item_name -- this is the column we're trying to reduce down to its unique values
;
# works similar to DISTINCT to return unique values for the specified column
# can group by multiple variables
SELECT * -- can't use this since it's too many extra columns to deal with extra data
FROM orders
WHERE item_name LIKE '%chicken%'
GROUP BY item_name, quantity -- multiple columns can be separated with a comma
;

SELECT item_name, quantity -- minimizes the amount of data returned so the function now works
FROM orders
WHERE item_name LIKE '%chicken%'
GROUP BY item_name, quantity;

SELECT item_name, COUNT(*)
FROM orders
WHERE item_name LIKE '%chicken%'
GROUP BY item_name;

SELECT item_name -- add column name here for GROUPing
	, MIN(quantity) -- as long as it's a function, you can use multiple filters
	, MAX(quantity)
FROM orders
WHERE item_name like '%chicken%'
GROUP BY item_name;


SELECT item_name, COUNT(*) as cnt-- group by and select must match
FROM orders
WHERE item_name like '%chicken%'
GROUP BY item_name
HAVING cnt > 100
ORDER BY cnt DESC;

USE pizza;
show tables;
DESCRIBE toppings;

-- Use an assoicative table to combine pizza to toppings, will need pizza toppins table
SELECT 
	topping_name,
    COUNT(*) as cnt
FROM pizzas AS p
INNER JOIN pizza_toppings pt
	-- ON p.pizza_id=pt.pizza_id --one way 
    USING(pizza_id) -- other way
INNER JOIN toppings AS t
	ON pt.topping_id=t.topping_id
GROUP BY topping_name
ORDER BY cnt DESC; -- most popular topping is pepperoni and least is pineapple


-- If your inner query returns an entire table, you must place it in the FROM section, this is because FROM uses tables. Using it in the WHERE will error out
SELECT round(avg(salary),2) as average_salary
FROM salaries;
	SELECT *
    FROM salaries
		JOIN employees e
			USING (emp_no)
    WHERE salary > (
					SELECT round(avg(salary),2) as average_salary
					FROM salaries) 
                    AND to_date > NOW()
	LIMIT 20
;

SELECT round(avg(salary),2) as average_salary
FROM salaries;
	SELECT emp_no, 
    salary,
   -- (SELECT round(avg(salary),2) as avg_sal from salaries) as average_salary
    'hello'
    FROM salaries
		JOIN employees e
			USING (emp_no)
    WHERE salary > (
					SELECT round(avg(salary),2) as average_salary
					FROM salaries) 
                    AND to_date > NOW()
	LIMIT 20
    ;
-- Queries in the select statement can only hold a single value
-- Inner query
Select emp_no
FROM dept_manager
WHERE to_date > NOW()
;

-- Outer query
Select first_name, last_name, birth_date, emp_no, d.dept_name -- dm.*, d.* -- .* shows all values on a selected table
FROM employees
	JOIN dept_manager dm
		USING (emp_no)
	JOIN departments d
		USING (dept_no)
WHERE emp_no IN ( -- must use IN here because the results are column of values -- can also use more levels of inner query
	Select emp_no
	FROM dept_manager
	WHERE to_date > NOW()
		AND emp_no > (select avg(emp_no) from dept_manager) -- nonsensical query but just showing how you can keep going down the rabbit hole
	)
;

USE chipotle;
SELECT database();
SHOW tables;

# FORMAT: IF(condition, value if true, value if false)
SELECT distinct item_name
	, IF (item_name LIKE '%chicken%', 'yes', 'no') as "Has Chicken"
FROM orders 
;

SELECT distinct item_name
	, IF (item_name LIKE '%chicken%', true, false) as "Has Chicken" -- SQL doesn't hold a data type for boolean values so it defaults to 0 or 1
    , IF (item_name LIKE '%steak%', true, false) as "MOO"
FROM orders 
;

SELECT distinct item_name
	, item_name LIKE '%chicken%' as "Has Chicken" -- shortcut for writing if statements
FROM orders 
;

SELECT count(has_chicken) -- subquery example, avoid using spaces cause it will error out
FROM (
	SELECT distinct item_name
	, IF (item_name LIKE '%chicken%', true, false) as "Has_Chicken" -- shortcut for writing if statements
	FROM orders 
	) as is_chicken
    ;
    
    
-- FORMAT:
-- CASE
-- 	WHEN column_a operator condition_a THEN value_a
--     WHEN column_b operator condition_b THEN value_b
--     ELSE value_c
-- END as new_column_name
-- */ 

-- more flexibility
-- multiple columns check
-- ORDER MATTERS!
;

SELECT 
	order_id
    , item_name
    , CASE
		-- WHEN order_id = 3 THEN 'ORDER_3!' -- order matters
		WHEN item_name LIKE '%chicken%' THEN 'is_chicken'
        WHEN item_name LIKE '%steak%' THEN 'is_steak'
        -- WHEN order_id = 3 THEN 'ORDER_3!' -- order matters
        ELSE 'not_chicken_or_steak'
	END as 'is_food' -- have to alias or it'll write this all as column name
FROM orders
;

SELECT quantity, count(*)
FROM orders
GROUP BY quantity
ORDER BY quantity
;

SELECT 
	
  --  , count(*) as cnt
    CASE
		WHEN quantity = 1 THEN 'single_order'
        WHEN quantity <=5 THEN 'middle_size_order'
        ELSE 'large order'
	END as 'order_size'
FROM orders
GROUP BY order_size
-- ORDER BY 
;


SELECT quantity, count(*),
	CASE
		WHEN item_name = 'Chicken Bowl' then item_name end as 'Chicken Bowl'
	, count(CASE WHEN item_name = 'Chicken Crispy Taco' then item_name end) as 'Chicken Crispy Taco'
    , count(CASE WHEN item_name = 'Chicken Soft Taco' then item_name end) as 'Chicken Soft Taco'
    , count(CASE WHEN item_name = 'Chicken Burrito' then item_name end) as 'Chicken Burrito'
    , count(CASE WHEN item_name = 'Chicken Salad Bowl' then item_name end) as 'Chicken Salad Bowl'
    , count(CASE WHEN item_name = 'Chicken Salad' then item_name end) as 'Chicken Salad'
FROM orders
WHERE item_name LIKE '%chicken%'
GROUP BY quantity
ORDER BY quantity
;


Use ursula_2331;
Create temporary table runners;
USE numbers_with_groups;
SELECT student_id, COUNT(*)
FROM student_grades
GROUP BY final_grade;
SELECT *
FROM numbers_with_groups

CREATE TABLE 
;
SELECT SUBSTR("Data Scienterrific", 10, LENGTH("Data Scienterrific")); 