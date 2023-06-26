USE testdb ;
GO

---------------------------------------------------------------------
-- Read Committed
---------------------------------------------------------------------

--Read committed is the default isolation level of SQL Server. In this isolation level, processes
--request a shared lock to read data and release it as soon as the data has been read --
--not when the statement of the transaction finishes. This means that dirty reads cannot
--happen -- the only changes you can read are those that have been committed. However
--all other concurrency-related problems can happen at this isolation level.

SELECT * FROM dbo.T1 ;

--keycol      col1        col2
------------- ----------- --------------------------------------------------
--1           101         A
--2           102         Version 1
--3           103         C
--4           101         C

-- Connection 1
BEGIN TRAN
  UPDATE dbo.T1 SET col2 = 'Version 2' WHERE keycol = 2;
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;

--  col2
----------------------------------------------------
--Version 2
GO

-- Connection 1
 --COMMIT TRAN
 --GO