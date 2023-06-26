-- Allow snapshot isolation
ALTER DATABASE testdb SET ALLOW_SNAPSHOT_ISOLATION ON;

-- Connection 4
SET NOCOUNT ON;
USE testdb;

SET LOCK_TIMEOUT 30000;

WHILE 1 = 1
BEGIN
  UPDATE dbo.T1 SET col1 += 1;
  WAITFOR DELAY '00:00:01';
END
GO

Msg 1205, Level 13, State 45, Line 12
Transaction (Process ID 54) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction.
