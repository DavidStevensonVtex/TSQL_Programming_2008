---------------------------------------------------------------------
-- Minimally Logged Inserts
---------------------------------------------------------------------

-- Check amount of logging (count, size)
CHECKPOINT;
GO

DECLARE @numrecords AS INT, @size AS BIGINT;

SELECT 
  @numrecords = COUNT(*),
  @size       = COALESCE(SUM([Log Record Length]), 0)
FROM fn_dblog(NULL, NULL) AS D;

PRINT 'Num records: ' + CAST(@numrecords AS VARCHAR) + '  Size: ' + CAST(@size AS VARCHAR);

-- <operation>

SELECT 
  COUNT(*) - @numrecords AS numrecords,
  CAST((COALESCE(SUM([Log Record Length]), 0) - @size)
    / 1024. / 1024. AS NUMERIC(12, 2)) AS size_mb
FROM fn_dblog(NULL, NULL) AS D;