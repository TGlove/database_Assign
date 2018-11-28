--EXISTS 
SELECT column_name(s)
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);

--HAVING 
--The HAVING clause was added to SQL because the WHERE keyword could not be used with aggregate functions.

SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY COUNT(CustomerID) DESC;

--GROUP BY
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);

SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;

--CASE 
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN "The quantity is greater than 30"
    WHEN Quantity = 30 THEN "The quantity is 30"
    ELSE "The quantity is under 30"
END
FROM OrderDetails;

--IFNULL
SELECT ProductName, UnitPrice * (UnitsInStock + IFNULL(UnitsOnOrder, 0))
FROM Products

--Stored Procedure

--A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.
--So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.
--You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.

CREATE PROCEDURE procedure_name
AS
sql_statement
GO;

EXEC procedure_name;

--

CREATE PROCEDURE SelectAllCustomers
AS
SELECT * FROM Customers
GO;

EXEC SelectAllCustomers;

--

CREATE PROCEDURE SelectAllCustomers @City nvarchar(30), @PostalCode nvarchar(10)
AS
SELECT * FROM Customers WHERE City = @City AND PostalCode = @PostalCode
GO;

EXEC SelectAllCustomers City = "London", PostalCode = "WA1 1DP";

--LEFT JOIN

SELECT column_name(s)
FROM table1
LEFT JOIN table2 ON table1.column_name = table2.column_name;
--all table1 and matched table2

--RIGHT JOIN

SELECT column_name(s)
FROM table1
RIGHT JOIN table2 ON table1.column_name = table2.column_name;

--FULL OUTER JOIN

SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2 ON table1.column_name = table2.column_name;

return al table1 and table2 records

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;

--UNION
--The UNION operator is used to combine the result-set of two or more SELECT statements.

SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

--AUTO INCREMENT
--MySQL uses the AUTO_INCREMENT keyword to perform an auto-increment feature.
CREATE TABLE Persons (
    ID int NOT NULL AUTO_INCREMENT,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID)
);
--To let the AUTO_INCREMENT sequence start with another value, use the following SQL statement:
ALTER TABLE Persons AUTO_INCREMENT=100;

--The MS SQL Server uses the IDENTITY keyword to perform an auto-increment feature.
CREATE TABLE Persons (
    ID int IDENTITY(1,1) PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);
--In the example above, the starting value for IDENTITY is 1, and it will increment by 1 for each new record.

--Dates
MySQL comes with the following data types for storing a date or a date/time value in the database:

DATE - format YYYY-MM-DD
DATETIME - format: YYYY-MM-DD HH:MI:SS
TIMESTAMP - format: YYYY-MM-DD HH:MI:SS
YEAR - format YYYY or YY

SQL Server comes with the following data types for storing a date or a date/time value in the database:

DATE - format YYYY-MM-DD
DATETIME - format: YYYY-MM-DD HH:MI:SS
SMALLDATETIME - format: YYYY-MM-DD HH:MI:SS
TIMESTAMP - format: a unique number
Note: The date types are chosen for a column when you create a new table in your database!
--
SELECT * FROM Orders WHERE OrderDate='2008-11-11'

--VIEW 
--In SQL, a view is a virtual table based on the result-set of an SQL statement.
--A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

CREATE VIEW [Products Above Average Price] AS
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

--SQL Injection
" or ""=" " or ""="
1 SELECT * FROM Users WHERE Name ="" or ""="" AND Pass ="" or ""=""
105 or 1=1
2 SELECT UserId, Name, Password FROM Users WHERE UserId = 105 or 1=1;
--To protect a web site from SQL injection, you can use SQL parameters.
--The SQL engine checks each parameter to ensure that it is correct for its column and are treated literally, and not as part of the SQL to be executed.

--functions

CREATE FUNCTION dbo.changeName(@input varchar(50))

RETURNS VARCHAR(50)

AS
BEGIN
	declare @work varchar(50)

	set @work = @input
	set @work = REPLACE(@work,'Peter','Change')
	
	RETURN @work
END
GO

select dbo.changeName(CustName)
from Customer where CustID=1000

reference
https://www.w3schools.com/sql/sql_ref_msaccess.asp

























