--Using SQL queries create Hotel database with the following entities:
--•	Employees (Id, FirstName, LastName, Title, Notes)
--•	Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
--•	RoomStatus (RoomStatus, Notes)
--•	RoomTypes (RoomType, Notes)
--•	BedTypes (BedType, Notes)
--•	Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
--•	Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
--•	Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
--Set the most appropriate data types for each column. Set a primary key to each table. Populate each table with only 3 records. 
--Make sure the columns that are present in 2 tables would be of the same data type. 
--Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.


CREATE DATABASE Hotel
USE Hotel

CREATE TABLE Employees
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	Title NVARCHAR(50),
	Notes NVARCHAR(MAX)
);

INSERT INTO Employees(FirstName,LastName)
VALUES
('w', 'e'),
('fd', 'g'),
('sdf', 'g')

Select * from employees

CREATE TABLE Customers
(
	AccountNumber INT PRIMARY KEY, 
	FirstName NVARCHAR(100) NOT NULL, 
	LastName NVARCHAR(100) NOT NULL, 
	PhoneNumber CHAR(10) NOT NULL, 
	EmergencyName NVARCHAR(100) NOT NULL, 
	EmergencyNumber CHAR(10) NOT NULL, 
	Notes NVARCHAR(MAX)
);

INSERT INTO Customers(AccountNumber, FirstName,LastName, PhoneNumber, EmergencyName, EmergencyNumber)
VALUES
(1, 'ivancho', 'petrov', '1234', 'ivanchoWE', '12345'),
(2, 'ivancho2', 'petrov2', '12345', 'ivanchoWE11', '1234589'),
(3, 'ivancho3', 'petrov3', '12346', 'ivanchoWE34', '1234555')

Select * from customers

-----------------------------------------------------------------------
--TODO: insert data in the rest tables

CREATE TABLE RoomStatus
(
	RoomStatus NVARCHAR(10) NOT NULL, 
	Notes NVARCHAR(MAX)
);

CREATE TABLE RoomTypes
(
	RoomType NVARCHAR(10) NOT NULL,  
	Notes NVARCHAR(MAX)
);

CREATE TABLE BedTypes
(
	BedType NVARCHAR(10) NOT NULL,   
	Notes NVARCHAR(MAX)
);

CREATE TABLE Rooms
(
	RoomNumber INT PRIMARY KEY, 
	RoomType NVARCHAR(10) NOT NULL, 
	BedType NVARCHAR(10) NOT NULL, 
	Rate TINYINT, 
	RoomStatus NVARCHAR(10) NOT NULL, 
	Notes NVARCHAR(MAX)
);

CREATE TABLE Payments
(
	Id INT PRIMARY KEY, 
	EmployeeId INT NOT NULL, 
	PaymentDate DATETIME2, 
	AccountNumber INT, 
	FirstDateOccupied DATETIME2, 
	LastDateOccupied DATETIME2, 
	TotalDays TINYINT, 
	AmountCharged DECIMAL(15,2), 
	TaxRate INT, 
	TaxAmount DECIMAL(15,2), 
	PaymentTotal DECIMAL(15,2), 
	Notes NVARCHAR(MAX)
);

CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY, 
	EmployeeId INT, 
	DateOccupied DATETIME2, 
	AccountNumber int, 
	RoomNumber int, 
	RateApplied int, 
	PhoneCharge decimal, 
	Notes nvarchar(max)
);




