---------------------------------------------------------------------
-- Deadlock with a Single table
---------------------------------------------------------------------

-- Connection 1
SET NOCOUNT ON;
USE testdb;

WHILE 1 = 1
  UPDATE dbo.T1 SET col1 = 203 - col1 WHERE keycol = 2;
GO

