-- Turn on "Discard results after execution"
-- Clear data cache, run twice, and measure both runs (cold/warm cache)
CHECKPOINT;
DBCC DROPCLEANBUFFERS;
GO

-- Set-Based, 10/1 seconds
-- Run the following set-based code twice -- the first run measures performance against
-- a cold cache, and the second measures it against a warm cache.

SET STATISTICS TIME ON ;
SELECT keycol, filler FROM dbo.T1;
SET STATISTICS TIME OFF ;
GO
 --SQL Server Execution Times:
 --  CPU time = 563 ms,  elapsed time = 911 ms.
--SQL Server Execution Times:
-- CPU time = 437 ms,  elapsed time = 765 ms.

DBCC DROPCLEANBUFFERS;
GO

-- Cursor-Based, 10/7 seconds
DECLARE @keycol AS INT, @filler AS CHAR(200);
DECLARE C CURSOR FAST_FORWARD FOR SELECT keycol, filler FROM dbo.T1;
OPEN C;
FETCH NEXT FROM C INTO @keycol, @filler;
WHILE @@FETCH_STATUS = 0
BEGIN
  -- Process data here
  FETCH NEXT FROM C INTO @keycol, @filler;
END
CLOSE C;
DEALLOCATE C;
GO

-- This code ran for 10 seconds against a cold cache and 7 seconds against a warm cache.
