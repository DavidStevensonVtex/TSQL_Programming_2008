-- Using a cursor variable

-- Book
-- Tip: SQL Server allows you to delare a cursor variable, assign it with a cursor definition, and
-- manipulate the curosr through the variable. Because variables are local to the batch, SQL Server
-- automatically closes and deallocates the cursor after the batch expires, even if you don't specify
-- the CLOSE and DEALLOCATE commands explicitly. Here's the code you would use to substitute the 
-- cursor from the previous example with a cursor variable.

DBCC DROPCLEANBUFFERS;
GO

DECLARE @C AS CURSOR, @keycol AS INT, @filler AS CHAR(200);
SET @C = CURSOR FAST_FORWARD FOR SELECT keycol, filler FROM dbo.T1;
OPEN @C;
FETCH NEXT FROM @C INTO @keycol, @filler;
WHILE @@FETCH_STATUS = 0
BEGIN
  -- Process data here
  FETCH NEXT FROM @C INTO @keycol, @filler;
END
GO

-- This code took 10 seconds against a cold cache and 8 seconds against a warm cache.