-- Create database
CREATE DATABASE Lucky_Shrub; 

-- Use database
USE Lucky_Shrub; 

-- Create Products table
CREATE TABLE Products (ProductID VARCHAR(10), ProductName VARCHAR(100),BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems) 
VALUES ("P1", "Artificial grass bags ", 40, 50, 100), 
("P2", "Wood panels", 15, 20, 250), 
("P3", "Patio slates",35, 40, 60), 
("P4", "Sycamore trees ", 7, 10, 50), 
("P5", "Trees and Shrubs", 35, 50, 75), 
("P6", "Water fountain", 65, 80, 15);

-- Create Notifications table
CREATE TABLE Notifications (NotificationID INT AUTO_INCREMENT, Notification VARCHAR(255), DateTime TIMESTAMP NOT NULL, PRIMARY KEY(NotificationID));

-- Task 1: Create an INSERT trigger called "ProductSellPriceInsertCheck". 
-- This trigger must check if the SellPrice of the product is less than the BuyPrice after a new product is inserted in the Products table. 
-- If this occurs, then a notification must be added to the notifications table to inform the sales department. 
-- The sales department can then ensure that the incorrect values were not inserted by mistake.
-- The notification message should be in the following format: 'A SellPrice less than the BuyPrice was inserted for ProductID ' + ProductID

DELIMITER //

CREATE TRIGGER ProductSellPriceInsertCheck
AFTER INSERT ON Products FOR EACH ROW
BEGIN

DECLARE `notification` VARCHAR(100);

IF NEW.SellPrice <= NEW.BuyPrice THEN
    SET `notification` = CONCAT('A SellPrice same or less than the BuyPrice was inserted for ProductID ', NEW.ProductID);
    INSERT INTO Notifications (Notification, DateTime)
    VALUES (`notification`, NOW());
END IF;

END //

DELIMITER ;

-- Confirm that the trigger works

INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems)
VALUES ("P7", "Product P7", 40, 40, 100);

SELECT NotificationID, Notification, DateTime FROM Notifications;

-- Task 2: Create an UPDATE trigger called "ProductSellPriceUpdateCheck". 
-- This trigger must check that products are not updated with a SellPrice 
-- that is less than or equal to the BuyPrice. 
-- If this occurs, add a notification to the notifications table for the 
-- sales department so they can ensure that product prices were not updated 
-- with the incorrect values. This trigger sends a notification to the Notifications 
-- table that warns the sales department of the issue.
-- The notification message should be in the following format: 
-- ProductID + 'was updated with a SellPrice of ' + SellPrice + ' which is the same or less than the BuyPrice' 

DELIMITER //

CREATE TRIGGER ProductSellPriceUpdateCheck
BEFORE UPDATE ON Products FOR EACH ROW
BEGIN

DECLARE `notification` VARCHAR(100);

IF NEW.SellPrice <= NEW.BuyPrice THEN
    SET `notification` = CONCAT(NEW.ProductID, ' was updated with a SellPrice of ', NEW.SellPrice, ' which is the same or less than the BuyPrice');
    INSERT INTO Notifications (Notification, DateTime)
    VALUES (`notification`, NOW());
END IF;

END //

DELIMITER ;

-- Confirm that the trigger works

UPDATE Products SET SellPrice = 60 WHERE ProductID = "P6";

SELECT NotificationID, Notification, DateTime FROM Notifications;

-- Task 3: Create a DELETE trigger called "NotifyProductDelete". 
-- This trigger must insert a notification in the notifications table 
-- for the sales department after a product has been deleted from the Products table.
-- The notification message should be in the following format: 
-- 'The product with a ProductID ' + ProductID + ' was deleted'

DELIMITER //

CREATE TRIGGER NotifyProductDelete
AFTER DELETE ON Products FOR EACH ROW
BEGIN

DECLARE `notification` VARCHAR(100);

SET `notification` = CONCAT('The product with a ProductID ', OLD.ProductID, ' was deleted');

INSERT INTO Notifications (Notification, DateTime)
VALUES (`notification`, NOW());

END //

DELIMITER ;

-- Confirm that the trigger works

DELETE FROM Products WHERE ProductID = "P7";

SELECT NotificationID, Notification, DateTime FROM Notifications;
