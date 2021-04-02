USE AdventureWorks2019;
GO

-- Query 1
SELECT COUNT(DISTINCT GroupName) AS GroupCount
FROM HumanResources.Department;
GO

-- Query 2
SELECT BusinessEntityId
	,MAX(Rate) AS MaxRate
FROM HumanResources.EmployeePayHistory
GROUP BY BusinessEntityID;
GO

-- Query 3
WITH MinPrices (
	ProductSubcategoryID
	,MinPrice
	)
AS (
	SELECT p.ProductSubcategoryID
		,MIN(sod.UnitPrice) AS MinPrice
	FROM Sales.SalesOrderDetail AS sod
	JOIN Production.Product AS p
		ON p.ProductID = sod.ProductID
	GROUP BY p.ProductSubcategoryID
	)
SELECT ps.ProductSubcategoryID
	,ps.Name
	,MinPrices.MinPrice
FROM Production.ProductSubcategory AS ps
LEFT JOIN MinPrices
	ON ps.ProductSubcategoryID = MinPrices.ProductSubcategoryID;
GO

-- Query 4
SELECT pc.ProductCategoryID
	,pc.Name
	,(
		SELECT COUNT(*)
		FROM Production.ProductSubcategory
		WHERE ProductCategoryID = pc.ProductCategoryID
		GROUP BY ProductCategoryID
		) AS NumOfSubcategories
FROM Production.ProductCategory AS pc;
GO

-- Query 5
WITH AvgTotals (
	ProductSubcategoryID
	,AvgTotal
	)
AS (
	SELECT p.ProductSubcategoryID
		,AVG(sod.LineTotal) AS AvgTotal
	FROM Sales.SalesOrderDetail AS sod
	JOIN Production.Product AS p
		ON p.ProductID = sod.ProductID
	GROUP BY p.ProductSubcategoryID
	)
SELECT ps.ProductSubcategoryID
	,ps.Name
	,AvgTotals.AvgTotal
FROM Production.ProductSubcategory AS ps
LEFT JOIN AvgTotals
	ON ps.ProductSubcategoryID = AvgTotals.ProductSubcategoryID;
GO

-- Query 6
SELECT BusinessEntityID
	,RateChangeDate
	,Rate
FROM HumanResources.EmployeePayHistory
WHERE Rate = (
		SELECT MAX(Rate)
		FROM HumanResources.EmployeePayHistory
		)

