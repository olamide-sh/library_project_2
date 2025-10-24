-- Library Management System Project 2
CREATE DATABASE library_project_2;
USE library_project_2;

-- Creating branch table
CREATE TABLE branch(
branch_id VARCHAR(10) PRIMARY KEY, 
manager_id VARCHAR(10), 
branch_address VARCHAR(55), 	
contact_no VARCHAR(10)
);
ALTER TABLE branch
MODIFY COLUMN contact_no VARCHAR(15);

-- Creating employees table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
emp_id VARCHAR(10) PRIMARY KEY,
emp_name VARCHAR(25), 	
position VARCHAR(15), 		
salary INT,
branch_id VARCHAR(25) -- FK
);

-- -- Creating books table
CREATE TABLE books(
isbn  VARCHAR(20) PRIMARY KEY,	
book_title VARCHAR(75),
category  VARCHAR(10),
rental_price FLOAT,	
status VARCHAR(15),
author VARCHAR(20),
publisher VARCHAR(55)
);

ALTER TABLE books
MODIFY COLUMN author VARCHAR(25);


-- Creating members table
DROP TABLE IF EXISTS members;
CREATE TABLE members(
member_id  VARCHAR(20) PRIMARY KEY,
member_name	VARCHAR(25),
member_address VARCHAR(75), 	
reg_date DATE
);

-- Creating issued_status table
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status(
issued_id VARCHAR(10) PRIMARY KEY,
issued_member_id VARCHAR(10), -- FK
issued_book_name VARCHAR(75),
issued_date	DATE,
issued_book_isbn VARCHAR(25), -- FK
issued_emp_id VARCHAR(15) -- FK
);

-- Creating return_status table
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status(
return_id VARCHAR(10) PRIMARY KEY,
issued_id VARCHAR(10), -- FK
return_book_name VARCHAR(75),
return_date	DATE,
return_book_isbn VARCHAR(20)
);

-- FOREIGN KEY
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id);

-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE book_cnts AS 
SELECT b.isbn,
b.book_title,
COUNT(ist.issued_id) AS no_issued
FROM books AS b
JOIN issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1, 2;

SELECT * FROM book_cnts;

-- Task 7. Retrieve All Books in a Specific Category
SELECT DISTINCT(category)  FROM books;

SELECT * FROM books
WHERE category = 'History';


-- Task 8: Find Total Rental Income by Category
SELECT category,
SUM(rental_price) AS Total_Rental_Income,
COUNT(*)
FROM books
GROUP BY 1;

-- List Members Who Registered in the Last 180 Days
INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES ('C111', 'Daniel Bright', '148 Main Str', '2025-06-12'),
('C112', 'Eden Ayo', '148 Main Str', '2025-05-12');

SELECT * FROM members
WHERE reg_date >= CURDATE() - INTERVAL 180 DAY;

-- Task 10 List Employees with Their Branch Manager's Name and their branch details
SELECT * FROM branch;

SELECT
e1.*,
b.manager_id,
e2.emp_name AS manager_name
FROM employees AS e1
JOIN 
branch AS b
ON b.branch_id = e1.branch_id
JOIN 
employees AS e2
ON b.manager_id = e2.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold
CREATE TABLE books_7 AS
SELECT * FROM books
WHERE rental_price > 7;

SELECT * FROM books_7;

-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT ist.issued_book_name
FROM issued_status AS ist
LEFT JOIN
return_status AS rs
ON
ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;