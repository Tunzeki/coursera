-- Create database
CREATE DATABASE Lucky_Shrub;

--Use the database
USE Lucky_Shrub; 

-- Create Orders table
CREATE TABLE Orders(OrderID INT NOT NULL, ClientID VARCHAR(10) DEFAULT NULL, ProductID VARCHAR(10) DEFAULT NULL, Quantity INT DEFAULT NULL, Cost DECIMAL(6,2) DEFAULT NULL, Date DATE DEFAULT NULL, PRIMARY KEY (OrderID));

-- Create Employees table
CREATE TABLE Employees(EmployeeID INT DEFAULT NULL, FullName VARCHAR(100) DEFAULT NULL, Role VARCHAR(50) DEFAULT NULL, Department VARCHAR(255) DEFAULT NULL);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date)  
VALUES  
(1, "Cl1", "P1", 10, 500, "2020-09-01"), 
(2, "Cl2", "P2", 5, 100, "2020-09-05"),  
(3, "Cl3", "P3", 20, 800, "2020-09-03"),  
(4, "Cl4", "P4", 15, 150, "2020-09-07"),  
(5, "Cl3", "P3", 10, 450, "2020-09-08"),  
(6, "Cl2", "P2", 5, 800, "2020-09-09"),  
(7, "Cl1", "P4", 22, 1200, "2020-09-10"),  
(8, "Cl3", "P1", 15, 150, "2020-09-10"),  
(9, "Cl1", "P1", 10, 500, "2020-09-12"),  
(10, "Cl2", "P2", 5, 100, "2020-09-13"),  
(11, "Cl1", "P2", 15, 80, "2020-09-12"), 
(12, "Cl1", "P1", 10, 500, "2022-09-01"),  
(13, "Cl2", "P2", 5, 100, "2022-09-05"),  
(14, "Cl3", "P3", 20, 800, "2022-09-03"),  
(15, "Cl4", "P4", 15, 150, "2022-09-07"),  
(16, "Cl3", "P3", 10, 450, "2022-09-08"),  
(17, "Cl2", "P2", 5, 800, "2022-09-09"),  
(18, "Cl1", "P4", 22, 1200, "2022-09-10"),  
(19, "Cl3", "P1", 15, 150, "2022-09-10"),  
(20, "Cl1", "P1", 10, 500, "2022-09-12"),  
(21, "Cl2", "P2", 5, 100, "2022-09-13"),   
(22, "Cl2", "P1", 10, 500, "2021-09-01"),  
(23, "Cl2", "P2", 5, 100, "2021-09-05"),  
(24, "Cl3", "P3", 20, 800, "2021-09-03"),  
(25, "Cl4", "P4", 15, 150, "2021-09-07"),  
(26, "Cl1", "P3", 10, 450, "2021-09-08"),  
(27, "Cl2", "P1", 20, 1000, "2022-09-01"),  
(28, "Cl2", "P2", 10, 200, "2022-09-05"),  
(29, "Cl3", "P3", 20, 800, "2021-09-03"); 

-- Insert data into Employees table
INSERT INTO Employees (EmployeeID, FullName,  Role, Department)  
VALUES    
(1, "Seamus Hogan", "Manager", "Management"),    
(2, "Thomas Eriksson", "Assistant ", "Sales"),   
(3, "Simon Tolo", "Executive", "Management"),   
(4, "Francesca Soffia", "Assistant  ", "Human Resources"),   
(5, "Emily Sierra", "Accountant", "Finance"),    
(6, "Greta Galkina", "Accountant", "Finance"), 
(7, "Maria Carter", "Executive", "Human Resources"), 
(8, "Rick Griffin", "Manager", "Marketing");

-- Task 1: Lucky Shrub need data on client orders. 
-- They have written the following SELECT query 
-- to retrieve all data from the Orders table:
-- SELECT * FROM Orders;
-- However, the data they need is contained within 
-- the OrderID, ProductID, Quantity and Date columns. 
-- So, these are the important fields that their query must target. 
-- Targeting other columns in the table is an inefficient use of resources.
-- Rewrite the SELECT statement so that it is optimized.

SELECT 
    OrderID, ProductID, Quantity, `Date`
FROM 
    Orders;

-- Task 2: Lucky Shrub need to find the order placed by the client Cl1. 
-- They have written the following query to complete this task:
-- SELECT * FROM Orders WHERE ClientID ='Cl1'; 
-- However, this query's execution plan shows that it does not use 
-- an index to perform this search, as indicated by the NULL values 
-- in possible_keys and keys columns.
-- Help Lucky Shrub to optimize this query by creating an index 
-- named IdxClientID on the required column of the Orders table. 
-- Once you have created the index, run the same SELECT statement 
-- as above with the EXPLAIN statement.

CREATE INDEX IdxClientID ON Orders(ClientID);

EXPLAIN SELECT * FROM Orders WHERE ClientID ='Cl1'; 

-- Task 3: Lucky Shrub have written the following SELECT query 
-- to find the details of the employee whose last name is 'Tolo':
-- SELECT * FROM Employees WHERE FullName LIKE '%Tolo'; 
-- However, there’s an index on the FullName column which the query cannot use 
-- because it contains a leading wildcard (%) in the WHERE clause condition.
-- The following steps can be taken to eliminate the leading wildcard:
-- Step 1: Add a new column to the Employees table called ReverseFullName.
-- Step 2: Populate the ReverseFullName column with the name of each employee 
-- as its values, but in reverse.
-- Step 3: Finally, create an index named IdxReverseFullName on the ReverseFullName column.
-- Follow these steps first and then rewrite the SELECT query and improve its performance 
-- so that it uses a trailing wildcard instead of the leading wild card.

ALTER TABLE Employees ADD COLUMN ReverseFullName VARCHAR(100) NOT NULL;

UPDATE Employees SET ReverseFullName = CONCAT(SUBSTRING_INDEX(FullName, ' ', -1), ' ', SUBSTRING_INDEX(FullName, ' ', 1));

CREATE INDEX IdxReverseFullName ON Employees(ReverseFullName);

SELECT * FROM Employees WHERE ReverseFullName LIKE 'Tolo%'; 