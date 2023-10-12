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
WHERE release_date >= 1990 and release_date <= 1999;
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