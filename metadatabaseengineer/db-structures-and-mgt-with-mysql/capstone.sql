-- Create database
CREATE DATABASE Little_Lemon;

-- Use the database
USE Little_Lemon; 

-- Create Customers table
CREATE TABLE Customers(CustomerID INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL,    PhoneNumber INT NOT NULL UNIQUE);

-- Insert data into Customers table
INSERT INTO Customers(CustomerID, FullName, PhoneNumber) VALUES 
    (1, "Vanessa McCarthy", 0757536378), 
    (2, "Marcos Romero", 0757536379), 
    (3, "Hiroki Yamane", 0757536376), 
    (4, "Anna Iversen", 0757536375),
    (5, "Diana Pinto", 0757536374),
    (6, "Altay Ayhan", 0757636378), 
    (7, "Jane Murphy", 0753536379), 
    (8, "Laurina Delgado", 0754536376), 
    (9, "Mike Edwards", 0757236375),
    (10, "Karl Pederson", 0757936374);

    -- Create Bookings table
    CREATE TABLE Bookings (   
BookingID INT,   
BookingDate DATE,   
TableNumber INT,    
NumberOfGuests INT,   
CustomerID INT    
); 

-- Insert data into Bookings table
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) VALUES
(10, '2021-11-10', 7, 5, 1), 
(11, '2021-11-10', 5, 2, 2), 
(12, '2021-11-10', 3, 2, 4),
(13, '2021-11-11', 2, 5, 5), 
(14, '2021-11-11', 5, 2, 6), 
(15, '2021-11-11', 3, 2, 7),
(16, '2021-11-11', 3, 5, 1), 
(17, '2021-11-12', 5, 2, 2), 
(18, '2021-11-12', 3, 2, 4),
(19, '2021-11-13', 7, 5, 6), 
(20, '2021-11-14', 5, 2, 3), 
(21, '2021-11-14', 3, 2, 4);

-- Create Courses table
CREATE TABLE Courses (CourseName VARCHAR(255) PRIMARY KEY, Cost Decimal(4,2));

-- Insert data into Courses
Insert into Courses (CourseName, Cost) VALUES ("Greek salad", 15.50), ("Bean soup", 12.25), ("Pizza", 15.00), ("Carbonara", 12.50), ("Kabasa", 17.00), ("Shwarma", 11.30);

-- Task 1: Create SQL statement to print all records from Bookings table 
-- for the following bookings dates using the BETWEEN operator: 
-- 2021-11-11, 2021-11-12 and 2021-11-13

SELECT * FROM Bookings 
WHERE BookingDate BETWEEN '2021-11-11' AND '2021-11-13';

-- Task 2: Create a JOIN SQL statement on the Customers and Bookings tables. 
-- The statement must print the customers full names and related bookings IDs 
-- from the date 2021-11-11.

SELECT 
    Customers.FullName, Bookings.BookingID
FROM Customers 
INNER JOIN Bookings USING (CustomerID)
WHERE Bookings.BookingDate = '2021-11-11';

-- Task 3: Create a SQl statement to print the bookings dates from Bookings table. 
-- The statement must show the total number of bookings placed on each of the printed 
-- dates using the GROUP BY BookingDate.

SELECT 
    BookingDate, COUNT(BookingDate) AS Total
FROM Bookings
GROUP BY BookingDate;

-- Task 4: Create a SQL REPLACE statement that updates 
-- the cost of the Kabasa course from $17.00 to $20.00

REPLACE INTO Courses
SET CourseName = 'Kabasa', Cost = 20.00;

-- Task 5: Create a new table called "DeliveryAddress" in the Little Lemon database 
-- with the following columns and constraints: 
-- ID: INT PRIMARY KEY
-- Address: VARCHAR(255) NOT NULL
-- Type: NOT NULL DEFAULT "Private" 
-- CustomerID: INT NOT NULL FOREIGN KEY referencing CustomerID in the Customers table

CREATE TABLE DeliveryAddress (
    Id INT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    Type VARCHAR(100) NOT NULL Default "Private",
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Task 6: Create a SQL statement that adds a new column called 'Ingredients' 
-- to the Courses table. 
-- Ingredients: VARCHAR(255)

ALTER TABLE Courses ADD Ingredients VARCHAR(255);

-- Task 7: Create a SQL statement with a subquery that prints the full names 
-- of all customers who made bookings in the restaurant on the following date: 2021-11-11

SELECT FullName FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Bookings WHERE BookingDate = '2021-11-11');

-- Task 8: Create the "BookingsView" virtual table to print all bookings IDs, bookings dates 
-- and the number of guests for bookings made in the restaurant before 2021-11-13 
-- and where number of guests is larger than 3. 

CREATE VIEW BookingsView AS
SELECT BookingID, BookingDate, NumberOfGuests
FROM Bookings
WHERE BookingDate < "2021-11-13" AND NumberOfGuests > 3;

SELECT * FROM BookingsView;

-- Task 9: Create a stored procedure called 'GetBookingsData'. 
-- The procedure must contain one date parameter called "InputDate". 
-- This parameter retrieves all data from the Bookings table based 
-- on the user input of the date.  
-- After executing the query, call the "GetBookingsData" with '2021-11-13' 
-- as the input date passed to the stored procedure to show all bookings made on that date
DELIMITER //

CREATE PROCEDURE GetBookingsData(IN InputDate DATE)
BEGIN
    SELECT * FROM Bookings
    WHERE BookingDate = InputDate;
END //

DELIMITER ;

CALL GetBookingsData('2021-11-13');

-- Task 10: Create a SQL SELECT query using appropriate MySQL string function 
-- to list "Booking Details" including booking ID, booking date and number of guests. 
-- The data must be listed in the same format as the following example: 
-- ID: 10, Date: 2021-11-10, Number of guests: 5

SELECT 
    CONCAT(
        "ID: ",
        BookingID,
        ", ",
        "Date: ",
        BookingDate,
        ", ",
        "Number of guests: ",
        NumberOfGuests
    ) AS `Booking Details`
FROM Bookings;
