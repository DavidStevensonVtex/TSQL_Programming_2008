USE InsideTSQL2008;
GO

-- Run with Davis
DECLARE @mylastname AS NVARCHAR(40) = N'Davis';
DECLARE @sql AS NVARCHAR(500) =
  N'SELECT empid, firstname, lastname
/* A2E6C9ED-E75A-42F7-BD22-EB671798B0DC */
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

-- Run with King
DECLARE @mylastname AS NVARCHAR(40) = N'King';
DECLARE @sql AS NVARCHAR(500) =
  N'SELECT empid, firstname, lastname
/* A2E6C9ED-E75A-42F7-BD22-EB671798B0DC */
FROM HR.Employees
WHERE lastname = @lastname';

EXEC sp_executesql
  @stmt = @sql,
  @params = N'@lastname AS NVARCHAR(40)',
  @lastname = @mylastname;
GO
--empid       firstname  lastname
------------- ---------- --------------------
--7           Russell    King


-- Examine cached objects
SELECT cacheobjtype, objtype, usecounts, sql
FROM sys.syscacheobjects
WHERE sql LIKE N'%A2E6C9ED-E75A-42F7-BD22-EB671798B0DC%'
  AND sql NOT LIKE N'%sys%';
GO

--cacheobjtype                                       objtype              usecounts   sql
---------------------------------------------------- -------------------- ----------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Compiled Plan                                      Prepared             5           (@lastname AS NVARCHAR(40))SELECT empid, firstname, lastname
--/* A2E6C9ED-E75A-42F7-BD22-EB671798B0DC */
--FROM HR.Employees
--WHERE lastname = @lastname