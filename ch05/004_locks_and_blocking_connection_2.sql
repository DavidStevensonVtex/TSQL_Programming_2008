---------------------------------------------------------------------
-- Locks and Blocking
---------------------------------------------------------------------

-- Connection 2
SET NOCOUNT ON;
USE testdb;
GO

SELECT keycol, col1, col2 FROM dbo.T1;
GO

--SELECT @@LOCK_TIMEOUT AS [Lock Timeout];  
--GO  

--SET LOCK_TIMEOUT 1800;  
--SELECT @@LOCK_TIMEOUT AS [Lock Timeout];  
--GO  

-- Connection 2
-- Stop, then set the LOCK_TIMEOUT, then retry
-- SET LOCK_TIMEOUT 5000;
-- SELECT keycol, col1, col2 FROM dbo.T1;
-- GO

-- Remove timeout
-- SET LOCK_TIMEOUT -1;
-- GO