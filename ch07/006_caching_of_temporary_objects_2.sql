SET NOCOUNT ON;
USE tempdb;

-- Execute proc
EXEC dbo.TestCaching;

-- Query temporary objects, should get name of cached temp table
SELECT name FROM tempdb.sys.objects WHERE name LIKE '#%';

--name
-------------------------
--#BC6A3587

-- Book: The stored procedure terminated, but the temporary table was cached --
-- or more specifically, SQL Server kept its entry in the system catalog, an IAM
-- page, and a data page.