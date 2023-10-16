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