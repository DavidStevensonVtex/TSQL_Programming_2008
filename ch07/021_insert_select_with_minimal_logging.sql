-- INSERT SELECT with Table Variable
USE tempdb;
CHECKPOINT;
GO

DECLARE @numrecords AS INT, @size AS BIGINT;

SELECT 
  @numrecords = COUNT(*),
  @size       = COALESCE(SUM([Log Record Length]), 0)
FROM fn_dblog(NULL, NULL) AS D;

DECLARE @TestLogging AS TABLE(n INT, filler CHAR(2000));

INSERT INTO @TestLogging(n, filler)
  SELECT n, CAST('a' AS CHAR(2000))
  FROM InsideTSQL2008.dbo.Nums
  WHERE n <= 100000;

SELECT 
  COUNT(*) - @numrecords AS numrecords,
  CAST((COALESCE(SUM([Log Record Length]), 0) - @size)
    / 1024. / 1024. AS NUMERIC(12, 2)) AS size_mb
FROM fn_dblog(NULL, NULL) AS D;
GO

--(100000 rows affected)
--numrecords  size_mb
------------- ---------------------------------------
--234407      18.74

--(1 row affected)