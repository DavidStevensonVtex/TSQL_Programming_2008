
-- Named constraints prevent caching
ALTER PROC dbo.TestCaching
AS
	CREATE TABLE #T1(n INT, filler CHAR(2000), CONSTRAINT UNQ_#T1_n UNIQUE(n));

	INSERT INTO #T1 VALUES
	  (1, 'a'),
	  (2, 'a'),
	  (3, 'a');
GO

-- Execute proc
EXEC dbo.TestCaching;

-- Query temporary objects, should get name of cached temp table
SELECT name FROM tempdb.sys.objects WHERE name LIKE '#%';

--(3 rows affected)
--name
-----------------------------

--(0 rows affected)

-- Book: This time the temporary object wasn't cached 9again, it may take a few seconds for the
-- temporary object that was cached previously to be removed from cache). So, even though naming
-- constraints is in general a good practice, bear in mind that if you want to benefit from
-- caching of temporary objects, you shouldn't name them.