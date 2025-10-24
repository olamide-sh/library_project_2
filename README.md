# library_project_2

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `library_project_2`

This project demonstrates the implementation of a Library Management System using SQL.
It covers database design, table creation, and execution of CRUD operations along with advanced SQL queries to manage and analyze library data.

The goal is to showcase practical SQL skills in database creation, manipulation, and querying, simulating real-world library operations such as book issuance, member management, and inventory tracking.

## Objectives
1. **Set up a Library Management Database: Design and create a relational database to manage books, members, and transactions.
2. **Data Management: Insert, update, and delete records using SQL to maintain accurate and consistent data.
3. **Query Execution: Perform various SQL queries to retrieve and analyze information such as issued books, member activity, and available inventory.
4. **Advanced SQL Operations: Implement joins, aggregate functions, and subqueries to answer complex business questions and derive meaningful insights.


### Database Creation
Created a database named **`library_project_2`**.

### Table Creation
Created tables for the following entities:
- **branches**
- **employees**
- **members**
- **books**
- **issued_status**
- **return_status**

```sql
CREATE DATABASE library_project_2;
USE library_project_2;

-- Creating branch table
CREATE TABLE branch(
branch_id VARCHAR(10) PRIMARY KEY, 
manager_id VARCHAR(10), 
branch_address VARCHAR(55), 	
contact_no VARCHAR(10)

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
```
### 2.  CRUD Operations

- **Create**: Inserted sample records into the `books` table.  
- **Read**: Retrieved and displayed data from various tables.  
- **Update**: Updated records in the `employees` table.  
- **Delete**: Removed records from the `members` table as needed.  

** Task 1: Create a New Book Record

```sql
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
```
**Task 2: Update an Existing Member's Address**
```sql
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;
```
**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
```sql
DELETE FROM issued_status
WHERE issued_id = 'IS121';
```
**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';
```
**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.
```sql
SELECT issued_emp_id,
COUNT(issued_id) AS total_books
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id)  > 1;
```
### 3. CTAS (Create Table As Select)

- **Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
```sql
SELECT b.isbn,
b.book_title,
COUNT(ist.issued_id) AS no_issued
FROM books AS b
JOIN issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1, 2;
```
### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

**Task 7. **Retrieve All Books in a Specific Category**:
```sql
SELECT * FROM books
WHERE category = 'History';
```
**Task 8: Find Total Rental Income by Category**:
```sql
SELECT category,
SUM(rental_price) AS Total_Rental_Income,
COUNT(*)
FROM books
GROUP BY 1;
```
**Task 9. List Members Who Registered in the Last 180 Days**:
```sql
SELECT * FROM members
WHERE reg_date >= CURDATE() - INTERVAL 180 DAY;
```
**Task 10. List Employees with Their Branch Manager's Name and their branch details**:
```sql
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
```
Task 11. **Create a Table of Books with Rental Price Above a Certain Threshold**:
```sql
CREATE TABLE books_7 AS
SELECT * FROM books
WHERE rental_price > 7;
```
Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
SELECT ist.issued_book_name
FROM issued_status AS ist
LEFT JOIN
return_status AS rs
ON
ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;
```

## Reports
-**Database Schema**: Includes detailed table structures, relationships, and key constraints between entities.  
-**Data Analysis**: Provides insights into book categories, employee salaries, member registration trends, and issued book records.  
-**Summary Reports**: Displays aggregated data on high-demand books, active members, and employee performance metrics.

## Conclusion
This project demonstrates the practical application of **SQL** in designing and managing a **Library Management System**.  
It covers key database concepts including **setup**, **data manipulation**, and **advanced querying**, providing a strong foundation for **data management**, **analysis**, and **real-world database operations**.

## Author - Olamide Shodolamu
This is my Second SQL project, part of my learning journey into data analytics and database management.

### Connect With Me
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/olamide-shodolamu-617390228?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)

Thank you for your support, and I look forward to connecting with you!



