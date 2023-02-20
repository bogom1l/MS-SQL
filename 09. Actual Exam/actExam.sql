
CREATE DATABASE Boardgames

USE Boardgames

--problem 01

CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)


CREATE TABLE Addresses (
	Id INT PRIMARY KEY IDENTITY,
	StreetName NVARCHAR(100) NOT NULL,
	StreetNumber INT NOT NULL,
	Town VARCHAR(30) NOT NULL,
	Country VARCHAR(50) NOT NULL,
	Zip INT NOT NULL
)



CREATE TABLE Publishers (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) unique NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)  not null,
	Website nvarchar(40) not null,
	Phone nvarchar(20) not null
)


CREATE TABLE PlayersRanges (
	Id INT PRIMARY KEY IDENTITY,
	PlayersMin int not null,
	PlayersMax int not null
)

CREATE TABLE Boardgames (
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,
	YearPublished int not null,
	Rating decimal(18,2) not null,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) not null,
	PublisherId INT FOREIGN KEY REFERENCES Publishers(Id) not null,
	PlayersRangeId INT FOREIGN KEY REFERENCES PlayersRanges(Id) not null
)

CREATE TABLE Creators (
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Email NVARCHAR(30) NOT NULL
)

CREATE TABLE CreatorsBoardgames (
	CreatorId INT FOREIGN KEY REFERENCES Creators(Id) NOT NULL,
	BoardgameId INT FOREIGN KEY REFERENCES Boardgames(Id) NOT NULL,
	PRIMARY KEY (CreatorId, BoardgameId)
)


--problem 02


INSERT INTO Boardgames([Name], YearPublished, Rating, CategoryId, PublisherId, PlayersRangeId)
	 VALUES
	('Deep Blue', 2019, 5.67, 1, 15, 7),
	('Paris', 2016,9.78, 7, 1, 5),
	('Catan: Starfarers', 2021, 9.87, 7, 13, 6),
	('Bleeding Kansas', 2020, 3.25, 3,7, 4),
	('One Small Step', 2019, 5.75, 5, 9, 2)



	
INSERT INTO Publishers([Name],AddressId,Website,Phone)
	 VALUES
	('Agman Games', 5, 'www.agmangames.com', '+16546135542'),
	('Amethyst Games', 7, 'www.amethystgames.com', '+15558889992'),
	('BattleBooks', 13, 'www.battlebooks.com', '+12345678907')



--problem 03

Update PlayersRanges
set PlayersMax = 3
where PlayersMax = 2

update Boardgames
set [Name] = [Name] + 'V2'
where YearPublished >= 2020

select * from Boardgames

--problem 04 ---------



delete from CreatorsBoardgames
where BoardgameId in (47,16,1,31)

delete from Boardgames
where PublisherId = 1 

delete from Publishers
WHERE AddressId = 5

Delete from Addresses
WHERE Town LIKE 'L%'



--problem 05

select [Name], Rating
from Boardgames
order by YearPublished, [Name] desc


--problem 06

select b.Id, b.[Name], b.YearPublished, c.[Name] as CategoryName
from Boardgames as b
join Categories as c
on b.CategoryId = c.Id
where c.[Name] = 'Strategy Games' or c.[Name] = 'Wargames'
order by YearPublished desc


--problem 07

select c.Id,
c.FirstName + ' ' + c.LastName as CreatorName ,
c.Email
from Creators as c
left join CreatorsBoardgames as cb
on c.Id = cb.CreatorId
where cb.BoardgameId is null


--problem 08

select top 5
b.[Name], b.Rating, c.[Name]
from Boardgames as b
join PlayersRanges as pr
on b.PlayersRangeId = pr.Id
join Categories as c
on b.CategoryId = c.Id
where 
b.Rating > 7.00 and b.[Name] like '%a%' 
or 
b.Rating > 7.50 and (pr.PlayersMin >= 2 and pr.PlayersMax <= 5)
order by b.[Name], b.Rating desc


--problem 09

select 
c.FirstName + ' '+ c.LastName as FullName,
c.Email,
max(b.Rating) as Rating
from Creators as c
join CreatorsBoardgames as cb
on c.Id = cb.CreatorId
join Boardgames as b
on cb.BoardgameId = b.Id
where c.Email like '%.com'
group by c.FirstName, c.LastName, c.Email
order by FullName


--problem 10

select 
c.LastName,
CAST(CEILING(avg(b.Rating)) as int) as AverageRating,
p.[Name] as PublisherName
from Creators as c
join CreatorsBoardgames as cb
on c.Id = cb.CreatorId
join Boardgames as b
on cb.BoardgameId = b.Id
join Publishers as p
on b.PublisherId = p.Id
where p.[Name] = 'Stonemaier Games'
group by c.LastName, p.[Name]
order by avg(b.Rating) desc



--problem 11
GO

CREATE FUNCTION udf_CreatorWithBoardgames(@name NVARCHAR(30))
RETURNS INT
AS
BEGIN
	DECLARE @counter INT = (
		SELECT COUNT(c.Id) 
		from Creators as c
		join CreatorsBoardgames as cb
		on c.Id = cb.CreatorId
		join Boardgames as b
		on cb.BoardgameId = b.Id
		where c.FirstName = @name
	)
	RETURN @counter
	
END

GO

SELECT dbo.udf_CreatorWithBoardgames('Bruno')
--13

GO


--problem 12


CREATE PROCEDURE usp_SearchByCategory (@category VARCHAR(50))
AS
BEGIN
	
		select 
		b.[Name], 
		b.YearPublished,
		b.Rating,
		c.[Name] as CategoryName,
		p.[Name] as PublisherName,
		CONVERT(varchar(30), pr.PlayersMin) + ' people' as MinPlayers,
		CONVERT(varchar(30), pr.PlayersMax) + ' people' as MaxPlayers
		from Boardgames as b
		join Publishers as p
		on b.PublisherId = p.Id
		join Categories as c
		on b.CategoryId = c.Id
		join PlayersRanges as pr
		on b.PlayersRangeId = pr.Id
		where c.[Name] = @category
		order by PublisherName, YearPublished desc
	
END

GO


EXEC usp_SearchByCategory 'Wargames'


