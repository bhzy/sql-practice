USE AdventureWorks2019;
GO

CREATE VIEW Person.vPerson
AS
SELECT p.Title
	,p.FirstName
	,p.LastName
	,em.EmailAddress
FROM Person.Person AS p
JOIN Person.EmailAddress AS em
	ON p.BusinessEntityID = em.BusinessEntityID;
GO

WITH Person_CTE (
	FirstName
	,LastName
	,BusinessEntityID
	)
AS (
	SELECT FirstName
		,LastName
		,BusinessEntityID
	FROM Person.Person
	)
,
Phone_CTE (
	PhoneNumber
	,BusinessEntityID
	)
AS (
	SELECT PhoneNumber
		,BusinessEntityID
	FROM Person.PersonPhone
	)
SELECT e.BusinessEntityID
	,e.NationalIdNumber
	,e.JobTitle
	,Person_CTE.FirstName
	,Person_CTE.LastName
	,Phone_CTE.PhoneNumber
FROM HumanResources.Employee AS e
JOIN Person_CTE
	ON e.BusinessEntityID = Person_CTE.BusinessEntityID
JOIN Phone_CTE
	ON e.BusinessEntityID = Phone_CTE.BusinessEntityID;
GO