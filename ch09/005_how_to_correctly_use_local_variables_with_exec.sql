USE InsideTSQL2008;

-- Works
DECLARE @lastname AS NVARCHAR(40) = N'Davis';
DECLARE @sql AS NVARCHAR(500) =
  N'SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = ' + QUOTENAME(@lastname, N'''') + N';';
PRINT @sql ;
EXEC(@sql);
GO

--SELECT empid, firstname, lastname
--FROM HR.Employees
--WHERE lastname = 'Davis';

--empid       firstname  lastname
------------- ---------- --------------------
--1           Sara       Davis