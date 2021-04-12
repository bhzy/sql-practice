USE TestDb;
GO

-- Query 1
CREATE TABLE dbo.Customer (
	CustomerID INT PRIMARY KEY
	,FirstName VARCHAR(50)
	,LastName VARCHAR(50)
	,Email VARCHAR(50)
	,ModifiedDate DATE
	);
GO

-- Query 2
CREATE INDEX IX_Customer_FirstName_LastName ON dbo.Customer (
	FirstName ASC
	,LastName ASC
	);
GO

-- Query 3
CREATE INDEX IX_Customer_ModifiedDate ON dbo.Customer (ModifiedDate) INCLUDE (
	FirstName
	,LastName
	);
GO

-- Query 4
CREATE TABLE dbo.Customer2 (
	CustomerID INT PRIMARY KEY NONCLUSTERED
	,AccountNumber VARCHAR(10)
	,FirstName VARCHAR(50)
	,LastName VARCHAR(50)
	,Email VARCHAR(50)
	,ModifiedDate DATE
	,INDEX IX_Customer2_AccountNumber CLUSTERED (AccountNumber)
	);
GO

-- Query 5
EXEC sp_rename N'dbo.Customer2.IX_Customer2_AccountNumber'
	,N'CI_CustomerID'
	,N'INDEX';
GO

-- Query 6
DROP INDEX CI_CustomerID
	ON dbo.Customer2;
GO

-- Query 7
CREATE UNIQUE NONCLUSTERED INDEX AK_Customer_Email ON dbo.Customer2 (Email);
GO

-- Query 8
CREATE NONCLUSTERED INDEX IX_Customer_ModifiedDate ON dbo.Customer2 (ModifiedDate)
	WITH (FILLFACTOR = 70);
GO


