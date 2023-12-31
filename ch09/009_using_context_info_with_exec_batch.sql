
-- Example with static code
DECLARE @ci AS VARBINARY(128) =
  CAST(42 AS BINARY(4)) + COALESCE(SUBSTRING(CONTEXT_INFO(), 5, 124), 0x);

SET CONTEXT_INFO @ci;
PRINT @ci ;
GO

DECLARE @myval AS INT = 
  CAST(SUBSTRING(CONTEXT_INFO(), 1, 4) AS INT);

SELECT @myval AS val;
GO

--0x0000002A00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
--val
-------------
--42

-- Example with dynamic SQL
DECLARE @sql AS VARCHAR(500) =
  'DECLARE @result AS INT = 42;
DECLARE @ci AS VARBINARY(128) = 
  CAST(@result AS BINARY(4))
         + COALESCE(SUBSTRING(CONTEXT_INFO(), 5, 124), 0x);

SET CONTEXT_INFO @ci;';
EXEC(@sql);

DECLARE @myresult AS INT = 
  CAST(SUBSTRING(CONTEXT_INFO(), 1, 4) AS INT);

SELECT @myresult AS result;
GO

--result
-------------
--42