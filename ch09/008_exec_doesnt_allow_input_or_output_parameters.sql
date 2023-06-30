-- Book: In addition to supporting no input parameters in the dynamic batch, EXEC doesn't 
-- support output parameters. If you want to return the scalar result of a calculation that
-- you stored in a variable in the dynamic batch to the caller, you can't do this through 
-- a parameter. You could, if you wanted, return the value of the variable as a result set
-- by using a query, like so:

-- Returning output
DECLARE @sql AS VARCHAR(500) = 
  'DECLARE @result AS INT = 42;
SELECT @result AS result;';
EXEC(@sql);
GO

--result
-------------
--42

-- Book: But then you would face some challenges trying to return the value to a variable in the
-- calling batch. To achieve this, you must first insert hte output to a target table using the 
-- INSERT EXEC syntax, and then retrieve the value from the table into the variable as in:

-- Using INSERT EXEC
DECLARE @sql AS VARCHAR(500) =
  'DECLARE @result AS INT = 42;
SELECT @result AS result;';

DECLARE @myresult AS INT;
CREATE TABLE #T(result INT);
INSERT INTO #T(result) EXEC(@sql);
SET @myresult = (SELECT result FROM #T);
SELECT @myresult AS result;
DROP TABLE #T;
PRINT '@myresult = ' + CAST(@myresult AS VARCHAR) ;
GO

--result
-------------
--42

--(1 row affected)

--@myresult = 42