---------------------------------------------------------------------
-- Dealing with each Row Individually
---------------------------------------------------------------------

DBCC DROPCLEANBUFFERS;
GO

-- Listing 8-1: Code iterating through rows without a cursor
DECLARE @keycol AS INT, @filler AS CHAR(200);

SELECT TOP (1) @keycol = keycol, @filler = filler
FROM dbo.T1
ORDER BY keycol;

WHILE @@ROWCOUNT = 1
BEGIN
  -- Process data here

  -- Get next row
  SELECT TOP (1) @keycol = keycol, @filler = filler
  FROM dbo.T1
  WHERE keycol > @keycol
  ORDER BY keycol;
END
GO
-- This took 11 seconds on the first run. The second run took 8 seconds (without DBCC command).
-- Turn "Discard results after execution" back on