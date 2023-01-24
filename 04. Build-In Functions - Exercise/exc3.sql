USE [SoftUni]

--Problem 01

Select [FirstName], [LastName] 
FROM [Employees]
WHERE LEFT([FirstName], 2) = 'Sa';


Select [FirstName], [LastName] 
FROM [Employees]
WHERE [FirstName] LIKE '%Sa';

--Problem 02

Select [FirstName], [LastName] 
FROM [Employees]
WHERE [LastName] LIKE '%ei%';

--Problem 03

SELECT [FirstName] 
from [Employees]
WHERE ([DepartmentID] = 3 OR [DepartmentID] = 10) AND YEAR([HireDate]) BETWEEN 1995 AND 2005;

--Problem 04

SELECT [FirstName], [LastName]
from [Employees]
WHERE [JobTitle] NOT LIKE '%engineer%';


--Problem 05
Select [Name]
From [Towns]
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name]


--Problem 06

SELECT *
From [Towns]
WHERE LEFT([Name],1) IN ('M','K','B','E')
ORDER BY [Name]


--Problem 10

SELECT [EmployeeID], [FirstName], [LastName], [Salary],
DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID]) 
AS [Rank]
FROM [Employees]
WHERE [Salary] BETWEEN 10000 AND 50000
ORDER BY [Salary] DESC



--Problem 12

USE [Geography]

Select 
[CountryName] 
AS [Country Name],
[ISOCode] 
AS [ISO Code]
FROM [Countries]
WHERE LOWER([CountryName]) LIKE '%a%a%a'
ORDER BY [ISO Code]

--Problem 13
SELECT [p].[PeakName],
[r].[RiverName],
LOWER(CONCAT(SUBSTRING([p].[PeakName],1,LEN([p].[PeakName]) - 1),[r].[RiverName]))
AS [Mix]
FROM [Peaks]
AS [p], 
[Rivers] 
AS [r]
WHERE RIGHT(LOWER([p].[PeakName]),1) = LEFT(LOWER([r].[RiverName]),1)
ORDER BY [Mix]












