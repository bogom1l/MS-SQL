--Using SQL query create table Users with columns:
--•	Id – unique number for every user. There will be no more than 263-1 users (auto incremented).
--•	Username – unique identifier of the user. It will be no more than 30 characters (non Unicode)  (required).
--•	Password – password will be no longer than 26 characters (non Unicode) (required).
--•	ProfilePicture – image with size up to 900 KB. 
--•	LastLoginTime
--•	IsDeleted – shows if the user deleted his/her profile. Possible states are true or false.
--Make the Id a primary key. Populate the table with exactly 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.


CREATE TABLE Users
(
	Id BIGINT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	LastLoginTime DATETIME2,
	IsDeleted BIT
);

INSERT INTO Users
VALUES
('Petar1', '123456', null, '10-20-2022', 0),
('Petar2', '1234566', null, '10-21-2022', 0),
('Petar3', '12345666', null, '10-22-2022', 0),
('Petar4', '1234577', null, '10-23-2022', 0),
('Petar5', '1234588', null, '11-24-2022', 0)

--Select * from Users

ALTER TABLE [Users] DROP CONSTRAINT PK__Users__3214EC07A9B8E32E;
ALTER TABLE [Users] ADD CONSTRAINT PK_IdUsername PRIMARY KEY (Id, Username);

ALTER TABLE [Users] ADD CONSTRAINT CHK_PasswordMinLen CHECK(LEN(Password) >= 5);

INSERT INTO Users
VALUES
('Gosho', '122236', null, '10-20-2022', 0);

ALTER TABLE [Users] ADD CONSTRAINT DF_LastLoginTime DEFAULT GETDATE() FOR [LastLoginTime];

ALTER TABLE [Users] DROP CONSTRAINT PK_IdUsername;
ALTER TABLE [Users] ADD CONSTRAINT PK_Id PRIMARY KEY(Id);
ALTER TABLE [Users] ADD CONSTRAINT UC_Username UNIQUE(Username);
