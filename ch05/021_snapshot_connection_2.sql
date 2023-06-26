-- Connection 2
SET NOCOUNT ON;
USE testdb;
GO
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRAN
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
----------------------------------------------------
--Version 1

-- Connection 2
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
----------------------------------------------------
--Version 1

-- Connection 2
COMMIT TRAN
SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
----------------------------------------------------
--Version 2