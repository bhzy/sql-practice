USE AdventureWorks2019;
GO

-- Query 1
SELECT GroupName, COUNT(*) As NumDeps
FROM HumanResources.Department
GROUP BY GroupName
GO

-- Query 2
SELECT eph.BusinessEntityId
	,e.JobTitle
	,MAX(eph.Rate) AS MaxRate
FROM HumanResources.EmployeePayHistory AS eph
JOIN HumanResources.Employee AS e
ON eph.BusinessEntityID = e.BusinessEntityID
GROUP BY eph.BusinessEntityID, e.JobTitle;
GO

-- Query 3
SELECT ps.Name, MIN(sod.UnitPrice) AS MinPrice
FROM Sales.SalesOrderDetail as sod
JOIN Production.Product as p
ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory as ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.Name;
GO


-- Query 4
SELECT pc.Name, COUNT(ps.ProductSubcategoryID) as NumSubcategories
FROM Production.ProductSubcategory as ps
JOIN Production.ProductCategory as pc
ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name;
GO


-- Query 5
SELECT ps.Name, AVG(sod.LineTotal) AS AvgTotal
FROM Sales.SalesOrderDetail as sod
JOIN Production.Product as p
ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory as ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.Name;
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


