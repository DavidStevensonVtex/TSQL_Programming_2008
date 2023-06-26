-- Connection 2
SET NOCOUNT ON;
USE testdb;
GO


-- Connection 2 - Step 2
SET NOCOUNT ON;
USE testdb;
GO
BEGIN TRAN
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
-------------
--Version 1

-- Connection 2 - Step 4
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
COMMIT TRAN
GO

--col2
--------------
--Version 2