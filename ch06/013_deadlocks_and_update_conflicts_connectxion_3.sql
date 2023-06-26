-- Error Handling Retry Logic, Connection 3
SET NOCOUNT ON;
USE testdb;
GO

SET LOCK_TIMEOUT 30000;
DECLARE @j AS INT;

BEGIN TRAN

  UPDATE dbo.T2 SET col1 += 1;
  UPDATE dbo.T2 SET col1 += 1;
  UPDATE dbo.T2 SET col1 += 1;

  WAITFOR DELAY '00:00:05';

  WHILE 1 = 1
  BEGIN
    SET @j = (SELECT SUM(col1) FROM dbo.T1);
    WAITFOR DELAY '00:00:01';
  END

ROLLBACK

-- Stop and rollback the transaction in connection 3
ROLLBACK TRAN

-- Allow snapshot isolation
ALTER DATABASE testdb SET ALLOW_SNAPSHOT_ISOLATION ON;