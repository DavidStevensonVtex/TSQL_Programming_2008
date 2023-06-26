---------------------------------------------------------------------
-- Conflict Detection
---------------------------------------------------------------------

-- Connection 1, Step 1
SET NOCOUNT ON;
USE testdb;
GO

-- Connection 2, Step 1
SET NOCOUNT ON;
USE testdb;
GO
UPDATE dbo.T1 SET col2 = 'Version 4' WHERE keycol = 2;
GO

 SELECT col2 FROM dbo.T1 WHERE keycol = 2;

-- col2
-------------
--Version 4

-- Cleanup
 --UPDATE dbo.T1 SET col2 = 'Version 1' WHERE keycol = 2;
 --GO

-- Close all connections