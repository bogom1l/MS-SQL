----------------------------------------------------------------------------
USE [Gringotts]
----------------------------------------------------------------------------

--Problem 01

Select COUNT(*) AS [Count] 
from [WizzardDeposits]

--Problem 02

SELECT MAX([MagicWandSize]) AS [LongestMagicWand]
  FROM [WizzardDeposits]

--Problem 03

SELECT 
 DepositGroup, 
 MAX([MagicWandSize]) AS [LongestMagicWand]
FROM [WizzardDeposits]
GROUP BY DepositGroup

--Problem 04

SELECT TOP 2
 DepositGroup
FROM [WizzardDeposits]
GROUP BY DepositGroup
ORDER BY AVG([MagicWandSize])

--Problem 05

SELECT
w.DepositGroup, 
SUM(w.DepositAmount) As TotalSum
FROM [WizzardDeposits] as w
GROUP BY w.DepositGroup

--Problem 06

  SELECT [w].[DepositGroup], 
         SUM([w].[DepositAmount]) AS [TotalSum]
    FROM [WizzardDeposits] AS [w]
   WHERE [w].[MagicWandCreator] = 'Ollivander family'
GROUP BY [w].[DepositGroup]

--Problem 07

SELECT 
[DepositGroup],
SUM([DepositAmount]) AS [TotalSum]
FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]
HAVING SUM(DepositAmount) < 150000
ORDER BY [TotalSum] DESC

--Problem 08

  SELECT [w].[DepositGroup], 
         [w].[MagicWandCreator],
	 MIN([w].[DepositCharge]) AS [MinDepositCharge]
    FROM [WizzardDeposits] AS [w]
GROUP BY [w].[DepositGroup], [w].[MagicWandCreator]
ORDER BY [w].[MagicWandCreator], [w].[DepositGroup]

--Problem 09

Select 
[AgeGroup],
COUNT(*) AS [WizardCount]
FROM 
(
SELECT
CASE 
	 WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
	 WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
	 WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
	 WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
	 WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
	 WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
	 ELSE '[61+]'
END  
AS [AgeGroup]
FROM [WizzardDeposits]
) AS [AgeGroupSubquery]
GROUP BY [AgeGroup]

--Problem 10

 SELECT LEFT([FirstName], 1) AS [FirstLetter]
    FROM [WizzardDeposits]
   WHERE [DepositGroup] = 'Troll Chest'
GROUP BY SUBSTRING([FirstName], 1, 1)
ORDER BY [FirstLetter]

--Problem 11

Select 
DepositGroup,
IsDepositExpired,
AVG(DepositInterest) AS AverageInterest
from WizzardDeposits
Where DepositStartDate > '01-01-1985'
Group by DepositGroup, IsDepositExpired
Order by DepositGroup desc, IsDepositExpired asc

--Problem 12

SELECT SUM([Difference])  AS [SumDifference]
  FROM 
	(
SELECT [FirstName] AS [Host Wizard], 
       [DepositAmount] AS [Host Wizard Deposit],
       LEAD([FirstName]) OVER(ORDER BY [Id])
    AS [Guest Wizard],
       LEAD([DepositAmount]) OVER(ORDER BY [Id])
    AS [Guest Wizard Deposit],
       [DepositAmount] - LEAD([DepositAmount]) OVER(ORDER BY [Id])
    AS [Difference]
  FROM [WizzardDeposits]
	)  AS [DifferenceSubquery]

----------------------------------------------------------------------------
USE [Softuni]
----------------------------------------------------------------------------
--Problem 13

  SELECT [DepartmentID],
         SUM([Salary]) AS [TotalSalary]
    FROM [Employees]
GROUP BY [DepartmentID]
ORDER BY [DepartmentID]

--Problem 14

  SELECT [DepartmentID],
         MIN([Salary]) AS [MinimumSalary]
    FROM [Employees]
   WHERE [DepartmentID] IN (2, 5, 7) AND [HireDate] > '01/01/2000'
GROUP BY [DepartmentID]

--Problem 15
--not neccessarrryu9ey34urhesjay cause it changes tables data a lot 

--Problem 16
  SELECT [DepartmentID], MAX([Salary]) AS [MaxSalary]
    FROM [Employees]
GROUP BY [DepartmentID]
  HAVING MAX([Salary]) < 30000 OR MAX([Salary]) > 70000


-- Problem 17

SELECT COUNT(*) AS [Count] 
  FROM [Employees] 
 WHERE [ManagerID] IS NULL



--Problem 18
SELECT DISTINCT
[DepartmentID],
[Salary] AS [ThirdHighestSalary]
FROM 
(
	SELECT
	[DepartmentID],
	[Salary],
	DENSE_RANK() OVER(PARTITION BY [DepartmentID] ORDER BY [Salary] DESC)
	AS [SalaryRank]
	From [Employees]
)
AS [SalaryRankingSubquery]
WHERE [SalaryRank] = 3

--Problem 19

SELECT TOP 10
e.FirstName,
e.LastName,
e.DepartmentID
FROM Employees AS e
WHERE Salary > ( 
				SELECT AVG(Salary) AS AverageSalary
				FROM Employees AS eSub
				WHERE eSub.DepartmentID = e.DepartmentID
				GROUP BY DepartmentID
)
ORDER BY e.DepartmentID
