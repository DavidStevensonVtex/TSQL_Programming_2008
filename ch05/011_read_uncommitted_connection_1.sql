USE testdb ;
GO

---------------------------------------------------------------------
-- Read Uncommitted
---------------------------------------------------------------------

-- Connection 1
BEGIN TRAN
  UPDATE dbo.T1 SET col2 = 'Version 2' WHERE keycol = 2;
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
----------------------------------------------------
--Version 2

---- Connection 1
--ROLLBACK TRAN
--GO