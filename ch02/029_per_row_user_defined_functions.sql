---------------------------------------------------------------------
-- Per-Row UDFs
---------------------------------------------------------------------

-- Non-deterministic functions run per statement not per row,
-- except NEWID

-- Nondeterministic functions are functions that are not guaranteed to return the same output
-- when invoked multiple times with the same input. When you invoke nondetermistic built-in
-- functions in a query (such as RAND and GETDATE), those functions are invoked once for the
-- whole query and not once per row. The only exception to this rule is the NEWID function,
-- which generates a globally unique identifier (GUID). NEWID is the only nondetermistic
-- built-in function that will be invoked once per row.

USE InsideTSQL2008;

SELECT n, RAND() AS rnd, GETDATE() AS dt, NEWID() AS guid
FROM dbo.Nums
WHERE n <= 10;
GO