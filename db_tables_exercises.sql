SHOW databases;
USE albums_db;
SELECT database();
SHOW tables;
SHOW databases;
USE employees;
SELECT database();
SHOW tables;
#  Which table(s) do you think contain a numeric type column? I think "salaries" would contain numeric values
describe employees;
# Which table(s) do you think contain a string type column? I thinnk "departments," "Dept_manager," "employees," and "titles" will contain strings
# Which table(s) do you think contain a date type column? I think the "dept_emp" table would contain dates and possibly "employees" if it lists dates they were hired.
# What is the relationship between the employees and the departments tables? The department table probably contains where the employees are grouped together denoting what sections they work in.
describe departments;
describe employees;
SHOW CREATE table dept_manager;
# CREATE TABLE `dept_manager` (
#  `emp_no` int NOT NULL,
#  `dept_no` char(4) NOT NULL,
#  `from_date` date NOT NULL,
#  `to_date` date NOT NULL,
#  PRIMARY KEY (`emp_no`,`dept_no`),
#  KEY `dept_no` (`dept_no`),
#  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
#  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
#) ENGINE=InnoDB DEFAULT CHARSET=latin1