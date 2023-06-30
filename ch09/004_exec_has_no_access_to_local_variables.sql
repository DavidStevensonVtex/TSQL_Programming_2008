---------------------------------------------------------------------
-- EXEC Has No Interface
---------------------------------------------------------------------

-- Accessing input arguments

-- Book: Remember that a dynamic batch has no access to local variables
-- defined in the calling batch.

-- Doesn't work
USE InsideTSQL2008;

DECLARE @lastname AS NVARCHAR(40) = N'Davis';
DECLARE @sql AS NVARCHAR(500) =
  N'SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = @lastname;';
EXEC(@sql);
GO

--Msg 137, Level 15, State 2, Line 3
--Must declare the scalar variable "@lastname".