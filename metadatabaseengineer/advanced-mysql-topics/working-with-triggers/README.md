# Working with triggers

# Lab Instructions

Lucky Shrub need to impose business rules for inserting, updating and deleting product data in their database. You can help them by implementing triggers on the Products table.   

The Products table contains the following information about each product:

the ProductID, 
ProductName, 
BuyPrice, 
SellPrice 
and NumberOfItems

The following screenshot shows the Products table in the Lucky Shrub database:      
  
  
 ![Products table](images/C4M1L3_Item_08_lab_img1_products.png) 


**Note:** Before you begin, make sure you know how to access [MySQL environment](https://www.coursera.org/learn/advanced-mysql-topics/supplement/Xp5Mg/how-to-access-mysql-environment).

### Prerequisites  

To complete this lab, you must have access to the Lucky Shrub database and Products table in MySQL. The database’s Products table must be populated with the relevant data. Follow these steps to create and populate the database:   

1: Use the following code to create the database: 

```SQL 

CREATE DATABASE Lucky_Shrub; 

``` 

2: Use the following code to use the database: 

```SQL 

USE Lucky_Shrub; 

``` 

3: Use the following code to create the Products table: 

```SQL 
CREATE TABLE Products (ProductID VARCHAR(10), ProductName VARCHAR(100),BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT);


``` 

4: Use the following code to populate the Products table with data: 

```SQL 
INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems) 
VALUES ("P1", "Artificial grass bags ", 40, 50, 100), 
("P2", "Wood panels", 15, 20, 250), 
("P3", "Patio slates",35, 40, 60), 
("P4", "Sycamore trees ", 7, 10, 50), 
("P5", "Trees and Shrubs", 35, 50, 75), 
("P6", "Water fountain", 65, 80, 15);

```   

5: Create the Notifications table 

```SQL 
CREATE TABLE Notifications (NotificationID INT AUTO_INCREMENT, Notification VARCHAR(255), DateTime TIMESTAMP NOT NULL, PRIMARY KEY(NotificationID)); 


``` 
 

## This activity aims to achieve the following objective:    

 
* Develop INSERT, UPDATE and DELETE triggers
 
 

## Tasks Instructions 

Please attempt the following tasks: 

### **Task 1** 

Create an INSERT trigger called "ProductSellPriceInsertCheck". This trigger must check if the SellPrice of the product is less than the BuyPrice after a new product is inserted in the Products table. If this occurs, then a notification must be added to the notifications table to inform the sales department. The sales department can then ensure that the incorrect values were not inserted by mistake.

The notification message should be in the following format: 'A SellPrice less than the BuyPrice was inserted for ProductID ' + ProductID

The expected output result should be the same as that generated by the values for the ProductID P7 in the following screenshot.



![Task 1 output](images/C4M1L3_Item_08_lab_img2_task1output.png) 

  
 

### **Task 2** 

Create an UPDATE trigger called "ProductSellPriceUpdateCheck". This trigger must check that products are not updated with a SellPrice that is less than or equal to the BuyPrice. If this occurs, add a notification to the notifications table for the sales department so they can ensure that product prices were not updated with the incorrect values. This trigger sends a notification to the Notifications table that warns the sales department of the issue.

The notification message should be in the following format: ProductID + 'was updated with a SellPrice of ' + SellPrice + ' which is the same or less than the BuyPrice'

The expected output result should be the same as that generated by the values for the ProductID P6 in the following screenshot.



![Task 2 output](images/C4M1L3_Item_08_lab_img3_task2output.png) 




### **Task 3**

Create a DELETE trigger called "NotifyProductDelete". This trigger must insert a notification in the notifications table for the sales department after a product has been deleted from the Products table.

The notification message should be in the following format: 'The product with a ProductID ' + ProductID + ' was deleted'

The expected output result should be the same as that in the following screenshots.



![Task 3 output](images/C4M1L3_Item_08_lab_img4_task3output.png) 


```