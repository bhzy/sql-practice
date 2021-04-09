USE AdventureWorks2019;
GO

-- Query 1
SELECT t.ProductID
	,t.Name
	,t.SumTotal
FROM (
	SELECT p.ProductID
		,p.Name
		,NTILE(10) OVER (
			ORDER BY SUM(LineTotal)
			) AS Percentile
		,SUM(LineTotal) AS SumTotal
	FROM Sales.SalesOrderDetail AS sod
	JOIN Production.Product AS p
		ON p.ProductID = sod.ProductID
	JOIN Sales.SalesOrderHeader AS soh
		ON sod.SalesOrderID = soh.SalesOrderID
	WHERE MONTH(soh.OrderDate) = 1
		AND YEAR(soh.OrderDate) = 2013
	GROUP BY p.ProductID
		,p.Name
	) t
WHERE t.Percentile NOT IN (
		1
		,10
		);
GO

-- Query 2
SELECT t.Name
	,t.ListPrice
	,t.ProductSubcategoryID
FROM (
	SELECT Name
		,ListPrice
		,MIN(ListPrice) OVER (PARTITION BY ProductSubcategoryID) AS MinPrice
		,ProductSubcategoryID
	FROM Production.Product
	WHERE ProductSubcategoryID IS NOT NULL
	) t
WHERE t.ListPrice = t.MinPrice;
GO

-- Query 3
SELECT t.Name
	,t.ListPrice
FROM (
	SELECT Name
		,ListPrice
		,DENSE_RANK() OVER (
			ORDER BY ListPrice DESC
			) AS rank
	FROM Production.Product
	WHERE ProductSubcategoryID = 1
	) t
WHERE t.rank = 2;
GO

-- Query 4
SELECT t.ProductCategoryID
	,t.Sales
	,(t.Sales - t.PrevSales) / t.Sales YearOverYear
FROM (
	SELECT pc.ProductCategoryID
		,YEAR(soh.OrderDate) Year
		,SUM(sod.LineTotal) Sales
		,LAG(SUM(sod.LineTotal)) OVER (
			ORDER BY pc.ProductCategoryID, YEAR(soh.OrderDate)
			) PrevSales
	FROM Sales.SalesOrderHeader AS soh
	JOIN Sales.SalesOrderDetail AS sod
		ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Production.Product AS p
		ON sod.ProductID = p.ProductID
	JOIN Production.ProductSubcategory AS ps
		ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN Production.ProductCategory AS pc
		ON ps.ProductCategoryID = pc.ProductCategoryID
	GROUP BY pc.ProductCategoryID
		,YEAR(soh.OrderDate)
	) t
WHERE t.Year = 2013;
GO

-- Query 5
SELECT DISTINCT CONVERT(DATE, soh.OrderDate) DATE
	,MAX(soh.SubTotal) OVER (PARTITION BY soh.OrderDate) AS MaxDailyTotal
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
	ON soh.SalesOrderID = sod.SalesOrderID
WHERE YEAR(soh.OrderDate) = 2013
	AND MONTH(soh.OrderDate) = 1
ORDER BY DATE;
GO

-- Query 6
SELECT DISTINCT ps.Name SubcategoryName
	,FIRST_VALUE(p.Name) OVER (
		PARTITION BY ps.Name ORDER BY SUM(sod.OrderQty) DESC
		) TopProductName
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
	ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product AS p
	ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory AS ps
	ON p.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE YEAR(soh.OrderDate) = 2013
	AND MONTH(soh.OrderDate) = 1
GROUP BY ps.Name
	,p.Name;
GO

