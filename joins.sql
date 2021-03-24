USE AdventureWorks2019;
GO
-- Query 1
SELECT
    p.FirstName
  , p.LastName
  , e.JobTitle
  , e.BirthDate
FROM
    Person.Person AS p
    INNER JOIN
        HumanResources.Employee AS e
        ON
            p.BusinessEntityID = e.BusinessEntityID
;

GO
-- Query 2
SELECT
    p.FirstName
  , p.LastName
  , (
        SELECT
            JobTitle
        FROM
            HumanResources.Employee AS e
        WHERE
            e.BusinessEntityID = p.BusinessEntityID
    )
    AS JobTitle
FROM
    Person.Person AS p
;

GO
-- Query 3
SELECT
    t.*
FROM
    (
        SELECT
            p.FirstName
          , p.LastName
          , (
                SELECT
                    e.JobTitle
                FROM
                    HumanResources.Employee AS e
                WHERE
                    e.BusinessEntityID = p.BusinessEntityID
            )
            AS JobTitle
        FROM
            Person.Person AS p
    )
    AS t
WHERE
    t.JobTitle IS NOT NULL
;

GO
-- Query 4
SELECT
    p.FirstName
  , p.LastName
  , e.JobTitle
FROM
    (
        SELECT DISTINCT
            FirstName
          , LastName
        FROM
            Person.Person
    )
    as p
    CROSS JOIN
        (
            SELECT DISTINCT
                JobTitle
            FROM
                HumanResources.Employee
        )
        as e
;

GO
-- Query 5
SELECT
    COUNT(*)
FROM
    (
        SELECT
            p.FirstName
          , p.LastName
          , e.JobTitle
        FROM
            (
                SELECT DISTINCT
                    FirstName
                  , LastName
                FROM
                    Person.Person
            )
            as p
            CROSS JOIN
                (
                    SELECT DISTINCT
                        JobTitle
                    FROM
                        HumanResources.Employee
                )
                as e
    )
    AS t
;

GO