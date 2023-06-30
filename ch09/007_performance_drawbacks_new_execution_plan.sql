USE InsideTSQL2008;

-- Add GUID as a comment

-- Run with Davis
DECLARE @lastname AS NVARCHAR(40) = N'Davis';
DECLARE @sql AS NVARCHAR(500) =
  N'SELECT empid, firstname, lastname
/* 65353E43-7E73-4094-84AC-D632ABB0FF7F */
FROM HR.Employees
WHERE lastname = ' + QUOTENAME(@lastname, N'''') + N';';
PRINT @sql ;
EXEC(@sql);
GO

--SELECT empid, firstname, lastname
--/* 65353E43-7E73-4094-84AC-D632ABB0FF7F */
--FROM HR.Employees
--WHERE lastname = 'Davis';
--empid       firstname  lastname
------------- ---------- --------------------
--1           Sara       Davis

USE InsideTSQL2008;

-- Run with King
DECLARE @lastname AS NVARCHAR(40) = N'King';
DECLARE @sql AS NVARCHAR(500) =
  N'SELECT empid, firstname, lastname
/* 65353E43-7E73-4094-84AC-D632ABB0FF7F */
FROM HR.Employees
WHERE lastname = ' + QUOTENAME(@lastname, N'''') + N';';
PRINT @sql ;
EXEC(@sql);
GO

--SELECT empid, firstname, lastname
--/* 65353E43-7E73-4094-84AC-D632ABB0FF7F */
--FROM HR.Employees
--WHERE lastname = 'King';
--empid       firstname  lastname
------------- ---------- --------------------
--7           Russell    King

-- Examine cached objects
SELECT cacheobjtype, objtype, usecounts, sql
FROM sys.syscacheobjects
WHERE sql LIKE N'%65353E43-7E73-4094-84AC-D632ABB0FF7F%'
  AND sql NOT LIKE N'%sys%';
GO

--cacheobjtype                                       objtype              usecounts   sql
---------------------------------------------------- -------------------- ----------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Compiled Plan                                      Adhoc                1           SELECT empid, firstname, lastname
--/* 65353E43-7E73-4094-84AC-D632ABB0FF7F */
--FROM HR.Employees
--WHERE lastname = 'Davis';
--Compiled Plan                                      Adhoc                1           SELECT empid, firstname, lastname
--/* 65353E43-7E73-4094-84AC-D632ABB0FF7F */
--FROM HR.Employees
--WHERE lastname = 'King';

--(2 rows affected)