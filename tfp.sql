USE AdventureWorks2019;
GO

-- Query 1
CREATE TRIGGER notifier ON HumanResources.Department
INSTEAD OF INSERT, UPDATE
AS
	THROW 50001, 'Disable the trigger ''notifier'' to modify the table.', 1;
GO

-- Query 2
CREATE TRIGGER notifier2 ON DATABASE
FOR ALTER_TABLE
AS 
	THROW 50002, 'Disable the trigger ''notifier2'' to alter tables', 2;
	ROLLBACK;
GO

-- Query 3
CREATE FUNCTION dbo.ufnConcatStrings (
	@Col1 NVARCHAR(50)
	,@Col2 NVARCHAR(50)
	)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @Result NVARCHAR(50);
	SELECT @Result = CONCAT_WS(' - ', @Col1, @Col2)
	RETURN @Result
END;
GO

-- Query 4
CREATE FUNCTION HumanResources.ufnEmployeeByDepartment (@DepartmentID INT)
RETURNS TABLE
AS
RETURN (
		WITH DepartmentEmployees AS (
				SELECT BusinessEntityID
				FROM HumanResources.EmployeeDepartmentHistory
				WHERE DepartmentID = @DepartmentID
					AND EndDate IS NULL
				)
		SELECT e.*
		FROM HumanResources.Employee AS e
		JOIN DepartmentEmployees AS de
			ON e.BusinessEntityID = de.BusinessEntityID
		);
GO

-- Query 5
CREATE PROCEDURE Person.uspSearchByName (@Name NVARCHAR(50))
AS
	DECLARE @SearchName NVARCHAR(50)
	SET @SearchName = '%' + @Name + '%'
	SELECT BusinessEntityId
		,FirstName
		,LastName
	FROM Person.Person
	WHERE FirstName LIKE @SearchName
		OR LastName LIKE @SearchName;
GO


