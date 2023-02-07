
CREATE DATABASE Zoo

GO

USE Zoo

GO

--Problem 01

create table Owners
(
	Id int primary key identity,
	[Name] varchar(50) not null,
	PhoneNumber varchar(15) not null,
	[Address] varchar(50)
)


create table AnimalTypes
(
	Id int primary key identity,
	AnimalType varchar(30) not null
)

create table Cages
(
	Id int primary key identity,
	AnimalTypeId int foreign key references AnimalTypes(Id) not null
)

create table Animals
(
	Id int primary key identity,
	[Name] varchar(30) not null,
	BirthDate date not null,
	OwnerId int foreign key references Owners(Id),
	AnimalTypeId int foreign key references AnimalTypes(Id) not null
)

create table AnimalsCages
(
	CageId int foreign key references Cages(Id),
	AnimalId int foreign key references Animals(Id),
	primary key(CageId, AnimalId)
)

create table VolunteersDepartments
(
	Id int primary key identity,
	DepartmentName varchar(30) not null
)


create table Volunteers
(
	Id int primary key identity,
	[Name] varchar(50) not null,
	PhoneNumber varchar(15) not null,
	[Address] varchar(50),
	AnimalId int foreign key references Animals(Id),
	DepartmentId int foreign key references VolunteersDepartments(Id) not null
)

--Problem 02

insert into Animals([Name], BirthDate, OwnerId, AnimalTypeId)
values
('Giraffe', '2018-09-21', 21, 1),
('Harpy Eagle', '2015-04-17', 15, 3),
('Hamadryas Baboon', '2017-11-02', null, 1),
('Tuatara', '2021-06-30', 2, 4)

insert into Volunteers([Name], PhoneNumber, [Address], AnimalId, DepartmentId)
values
('Anita Kostova', '0896365412', 'Sofia, 5 Rosa str', 15, 1),
('Dimitur Stoev', '0877564223', null, 42, 4),
('Kalina Evtimova', '0896321112', 'Silistra, 21 Breza str.', 9, 7),
('Stoyan Tomov', '0898564100', 'Montana, 1 Bor str.', 18, 8),
('Boryana Mileva', '0888112233', null, 31, 5)

--Problem 03

select * from Owners where [Name] = 'Kaloqn Stoqnov'

select * from Animals where OwnerId is null

update Animals 
set OwnerId = (select Id from Owners where [Name] = 'Kaloqn Stoqnov')
where OwnerId is null

--Problem 04

select * from VolunteersDepartments where DepartmentName = 'Education program assistant'

select * from Volunteers where DepartmentId = 2

delete from Volunteers where DepartmentId = ( select Id from VolunteersDepartments where DepartmentName = 'Education program assistant' )

delete from VolunteersDepartments where DepartmentName = 'Education program assistant'

--Problem 05

select [Name], PhoneNumber, [Address], AnimalId, DepartmentId
from Volunteers
order by [Name], AnimalId, DepartmentId

--Problem 06

select 
a.[Name], 
ats.AnimalType, 
FORMAT(a.BirthDate, 'dd.MM.yyyy') as BirthDate
from Animals as a
join AnimalTypes as ats
on a.AnimalTypeId = ats.Id
order by a.[Name]

--Problem 07

select top (5)
o.[Name] as [Owner],
COUNT(a.Id) as CountOfAnimals
from Owners as o
left join Animals as a
on o.Id = a.OwnerId
group by o.[Name]
order by CountOfAnimals desc, [Owner]

--Problem 08

select 
concat(o.[Name], '-', a.[Name]) as OwnersAnimals,
o.PhoneNumber,
ac.CageId
from Owners as o
join Animals as a
on o.Id = a.OwnerId
join AnimalTypes as ats
on a.AnimalTypeId = ats.Id
join AnimalsCages as ac
on a.Id = ac.AnimalId
where ats.AnimalType = 'Mammals'
order by o.[Name], a.[Name] desc

--Problem 09

select 
v.[Name], 
v.PhoneNumber, 
ltrim(replace(replace(v.[Address], 'Sofia', ''), ',', '')) as [Address]
from Volunteers as v
join VolunteersDepartments as vd
on v.DepartmentId = vd.Id
where vd.DepartmentName = 'Education program assistant' 
and v.[Address] like '%Sofia%'
order by v.[Name]

--Problem 10

select
a.[Name],
datepart(year, a.BirthDate) as BirthYear,
ats.AnimalType
from Animals as a
join AnimalTypes as ats
on a.AnimalTypeId = ats.Id
where ats.AnimalType <> 'Birds'
and a.OwnerId is null
and datediff(year, a.BirthDate, '01/01/2022') < 5
order by a.[Name]

--Problem 11
GO

CREATE FUNCTION udf_GetVolunteersCountFromADepartment (@VolunteersDepartment varchar(30))
returns int
as
begin
	
declare @departmentId int;
set @departmentId = (
 select Id
 from VolunteersDepartments
 where DepartmentName = @VolunteersDepartment
)

declare @departmentVolunteersCount int;
set @departmentVolunteersCount = (
 select 
 count(*)
 from Volunteers
 where DepartmentId = @departmentId
)

return @departmentVolunteersCount

end

GO

SELECT dbo.udf_GetVolunteersCountFromADepartment ('Education program assistant')
SELECT dbo.udf_GetVolunteersCountFromADepartment ('Guest engagement')
SELECT dbo.udf_GetVolunteersCountFromADepartment ('Zoo events')


-- Problem 12
GO

CREATE PROCEDURE [usp_AnimalsWithOwnersOrNot] (@AnimalName VARCHAR(30))
              AS
           BEGIN
                  SELECT 
				  [a].[Name],
                  ISNULL([o].[Name], 'For adoption') AS [OwnersName]                           
                  FROM [Animals] AS [a]
				  LEFT JOIN [Owners] AS [o]
				  ON [a].[OwnerId] = [o].[Id]
                  WHERE [a].[Name] = @AnimalName
           END
 
GO
 
EXEC usp_AnimalsWithOwnersOrNot 'Pumpkinseed Sunfish'
EXEC usp_AnimalsWithOwnersOrNot 'Hippo'


