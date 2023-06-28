-- SELECT INTO with Temporary Table
USE tempdb;
CHECKPOINT;
GO

DECLARE @numrecords AS INT, @size AS BIGINT;

SELECT 
  @numrecords = COUNT(*),
  @size       = COALESCE(SUM([Log Record Length]), 0)
FROM fn_dblog(NULL, NULL) AS D;

PRINT 'Num records: ' + CAST(@numrecords AS VARCHAR) + '  Size: ' + CAST(@size AS VARCHAR);

SELECT n, CAST('a' AS CHAR(2000)) AS filler
INTO #TestLogging
FROM InsideTSQL2008.dbo.Nums
WHERE n <= 100000;

SELECT 
  COUNT(*) - @numrecords AS numrecords,
  CAST((COALESCE(SUM([Log Record Length]), 0) - @size)
    / 1024. / 1024. AS NUMERIC(12, 2)) AS size_mb
FROM fn_dblog(NULL, NULL) AS D;
GO

DROP TABLE #TestLogging;
GO

--Num records: 3  Size: 260

--(100000 rows affected)
--numrecords  size_mb
------------- ---------------------------------------
--11961       0.81
