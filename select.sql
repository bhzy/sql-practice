USE AdventureWorks2019
GO
--Query 1
SELECT * 
FROM HumanResources.Department
WHERE GroupName LIKE '%Research%'
ORDER BY DepartmentId DESC
GO
--Query 2
SELECT BusinessEntityID, 
	JobTitle, 
	BirthDate, 
	Gender, 
	NationalIDNumber 
FROM HumanResources.Employee
WHERE NationalIDNumber BETWEEN 500000000 AND 1000000000
GO
--Query 3
SELECT BusinessEntityID, 
	JobTitle, 
	BirthDate, 
	Gender
FROM HumanResources.Employee
WHERE YEAR(BirthDate) IN (1980, 1990)
GO
--Query 4
SELECT BusinessEntityID, 
	ShiftID
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY BusinessEntityID, 
	ShiftID
GO
--Query 5
SELECT BusinessEntityID, 
	ShiftID
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY BusinessEntityID, 
	ShiftID
HAVING COUNT(*) >= 2
