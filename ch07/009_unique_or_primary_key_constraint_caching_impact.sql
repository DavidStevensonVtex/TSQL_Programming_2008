-- Use a UNIQUE constraint as part of the table definition instead of creating an index explicitly
ALTER PROC dbo.TestCaching
AS
    CREATE TABLE #T1(n INT, filler CHAR(2000), UNIQUE(n));

    INSERT INTO #T1 VALUES
    (1, 'a'),
    (2, 'a'),
    (3, 'a');
GO

-- Execute proc
EXEC dbo.TestCaching;

-- Query temporary objects, should get name of cached temp table
SELECT name FROM tempdb.sys.objects WHERE name LIKE '#%';
GO


--(3 rows affected)
--name
----------------------------------------------------------------------------------------------------------------------------------
--#BF46A232

--(1 row affected)

-- Boook: Note that you can create composite indexes implicitly without sacrificing caching by
-- including a composote UNIQUE or PRIMARY KEY constraint in your table definition, as in
-- UNIQUE(col1, col2, col3).

-- As for named constraints, you might find this restriction odd, but naming a constraint
-- prevents SQL Server from caching your temporary objects.