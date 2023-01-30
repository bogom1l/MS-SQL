USE [Softuni]

--Problem 01

SELECT TOP (5) 
	[e].[EmployeeID], 
	[e].[JobTitle],
	[e].[AddressID],
	[a].[AddressText]
FROM [Employees] AS [e]
LEFT JOIN [Addresses] AS [a]
ON [e].[AddressID] = [a].[AddressID]
ORDER BY [e].[AddressID]

--Problem 02

SELECT TOP (50) 
[e].[FirstName],
[e].[LastName],
[t].[Name],
[a].[AddressText]
FROM [Addresses] AS [a]
JOIN [Towns] AS [t]
ON [a].TownID = [t].TownID
JOIN [Employees] as [e]
ON [e].AddressID = [a].AddressID
ORDER BY [e].[FirstName], [e].[LastName]

--Problem 03

Select e.EmployeeID, e.FirstName, e.LastName, d.[Name]
from Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE d.[Name] = 'Sales'
ORDER BY e.EmployeeID

--Problem 04

Select TOP 5
e.EmployeeID, e.FirstName, e.Salary, d.[Name]
from Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY d.DepartmentID

--Problem 05

SELECT TOP (3) 
	[e].[EmployeeID], 
	[e].[FirstName]
FROM [Employees] AS [e]
LEFT JOIN [EmployeesProjects] AS [ep]
ON [e].[EmployeeID] = [ep].[EmployeeID]
WHERE [ep].[EmployeeID] IS NULL
ORDER BY [e].[EmployeeID]

--Problem 06

Select e.FirstName, e.LastName, e.HireDate , d.[Name]
from Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '01-01.1999' AND d.[Name] = 'Sales' OR d.[Name] = 'Finance'
ORDER BY e.HireDate

--Problem 07

SELECT TOP (5) 
	[e].[EmployeeID],
	[e].[FirstName],
	[p].[Name] AS [ProjectName]
FROM [EmployeesProjects] AS [ep]
INNER JOIN [Employees] AS [e]
ON [ep].[EmployeeID] = [e].[EmployeeID]
INNER JOIN [Projects] AS [p]
ON [ep].[ProjectID] = [p].[ProjectID]
WHERE [p].[StartDate] > '08/13/2002' AND [p].[EndDate] IS NULL
ORDER BY [e].[EmployeeID]

--Problem 08

Select 
e.EmployeeID, 
e.FirstName, 
	CASE 
		WHEN YEAR([p].[StartDate]) >= '2005' THEN NULL
		ELSE [p].[Name]
	END AS [ProjectName]
from Employees as e
JOIN EmployeesProjects as ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects as p
ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24 

--Problem 09

select e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName as ManagerName
from Employees as e
join Employees as m
on e.ManagerID = m.EmployeeID
where e.ManagerID in (3,7)
ORDER BY e.EmployeeID

--Problem 10

select top 50
e.EmployeeID, 
CONCAT(e.FirstName,' ', e.LastName) as EmployeeName,
CONCAT(m.FirstName,' ', m.LastName) as ManagerName,
d.[Name] as DepartmentName
from Employees as e
join Employees as m
on e.ManagerID = m.EmployeeID
join Departments d
ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID


--Problem 11

SELECT MIN([AvgSalary]) AS [MinAverageSalary]
FROM
(
 SELECT AVG([Salary]) AS [AvgSalary] 
 FROM [Employees]
 GROUP BY [DepartmentID]
) AS [AverageSalaries]


--Problem 12
USE [Geography]

Select mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation
from MountainsCountries as mc
join Mountains as m
on mc.MountainId = m.Id
join Peaks as p
on m.Id = p.MountainId
WHERE p.Elevation > 2835 AND mc.CountryCode = 'BG'
ORDER BY p.Elevation desc

--Problem 13

select CountryCode,
COUNT(MountainId) as MountainRanges
from MountainsCountries
WHERE CountryCode = 'US' OR CountryCode = 'RU' OR CountryCode = 'BG'
group by CountryCode


--Problem 14

Select top 5
c.CountryName, r.RiverName
from Countries as c
left join CountriesRivers as cr
on c.CountryCode = cr.CountryCode
left join Rivers as r
on cr.RiverId = r.Id
where c.ContinentCode = 'AF'
order by c.CountryName


--Problem 15*



--Problem 16

--SELECT COUNT(c.CountryCode) as [Count]
SELECT COUNT(*) AS [Count]
  FROM [Countries] AS [c]
  LEFT JOIN [MountainsCountries] AS [mc] 
    ON [c].[CountryCode] = [mc].[CountryCode]
 WHERE [mc].[MountainId] IS NULL



-- Problem 17. Highest Peak and Longest River by Country

   SELECT TOP(5)
          [c].[CountryName],
          MAX([p].[Elevation]) AS [HighestPeakElevation],
          MAX([r].[Length]) AS [LongestRiverLength]
     FROM [Countries] AS [c]
LEFT JOIN [MountainsCountries] AS [mc]
       ON [c].[CountryCode] = [mc].[CountryCode]
LEFT JOIN [Peaks] AS [p]
       ON [p].[MountainId] = [mc].[MountainId]
LEFT JOIN [CountriesRivers] AS [cr]
       ON [c].[CountryCode] = [cr].[CountryCode]
LEFT JOIN [Rivers] AS [r]
       ON [cr].[RiverId] = [r].[Id]
 GROUP BY [c].[CountryName]
 ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, [c].[CountryName]


--Problem 18*
























