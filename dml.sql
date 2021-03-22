USE TestDb
GO
INSERT INTO TestSchema.TestTable
VALUES 
	(4, 'Bicycle', 0, '2020-08-23'),
	(5, 'Rocket', 1, '2020-01-01'),
	(6, 'Motorcycle', null, '2020-08-26'),
	(7, 'Submarine', 0, '1999-05-16');
GO
INSERT INTO TestSchema.TestTable (Id, InvoiceDate)
VALUES
	(8, '2020-08-25');
GO
INSERT INTO TestSchema.TestTable (Id, Name)
VALUES
	(9, 'Scooter');
GO
UPDATE TestSchema.TestTable
SET IsSold = 0
WHERE IsSold IS NULL
GO
DELETE FROM TestSchema.TestTable
WHERE (Name IS NULL) OR (InvoiceDate IS NULL)
GO
MERGE TestSchema.TestTable as t
USING TestSchema.TestTable2 as t2
ON t.Id = t2.Id
WHEN MATCHED AND t.Name != t2.Name
THEN UPDATE SET t.Name = t2.Name, 
	t.IsSold = t2.IsSold, 
	t.InvoiceDate = t2.InvoiceDate
WHEN NOT MATCHED 
THEN INSERT VALUES
	(t2.Id, t2.Name, t2.IsSold, t2.InvoiceDate);
GO
