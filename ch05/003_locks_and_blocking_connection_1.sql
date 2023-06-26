---------------------------------------------------------------------
-- Locks and Blocking
---------------------------------------------------------------------

-- Connection 1
SET NOCOUNT ON;
USE testdb;
GO
BEGIN TRAN
  UPDATE dbo.T1 SET col2 = 'BB' WHERE keycol = 2;
GO

--ROLLBACK TRANSACTION ;
--GO