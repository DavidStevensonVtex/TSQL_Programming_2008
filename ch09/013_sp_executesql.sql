
---------------------------------------------------------------------
-- sp_executesql
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Has Interface
---------------------------------------------------------------------

-- Input Parameters

USE InsideTSQL2008;
GO

DECLARE @mylastname AS NVARCHAR(40) = N'Davis';
DECLARE @sql AS NVARCHAR(500) =
  N'SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = @lastname';

EXEC sp_executesql
  @stmt = @sql,
  @params = N'@lastname AS NVARCHAR(40)',
  @lastname = @mylastname;
GO

--empid       firstname  lastname
------------- ---------- --------------------
--1           Sara       Davis