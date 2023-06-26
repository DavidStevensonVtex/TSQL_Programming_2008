USE testdb ;
GO

---------------------------------------------------------------------
-- Read Uncommitted
---------------------------------------------------------------------

-- Connection 2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
----------------------------------------------------
--Version 2