-- Sample data
USE tempdb;

-- Book: So it's good practice to always construct the code in a variable, where such limitations don't
-- apply, and then provide the variable name as input to the EXEC command, as shown here:

-- Construct code in a variable
DECLARE @sql AS VARCHAR(500) =
  'SELECT orderid FROM dbo.Orders'
     + CAST(YEAR(CURRENT_TIMESTAMP) AS CHAR(4)) + ';';
EXEC(@sql);
GO

--orderid
-------------

--(0 rows affected)