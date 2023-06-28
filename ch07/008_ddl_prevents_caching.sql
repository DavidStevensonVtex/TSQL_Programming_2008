-- DDL prevents caching
ALTER PROC dbo.TestCaching
AS
    CREATE TABLE #T1(n INT, filler CHAR(2000));
    CREATE UNIQUE INDEX idx1 ON #T1(n);

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

--name
--#T1_________________________________________________________________________________________________________________00000000002D