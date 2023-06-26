USE testdb;
GO

-- Run transaction and observe only 1 lock reported indicating escalation
BEGIN TRAN

  DELETE FROM dbo.TestEscalation WHERE col1 <= 20000;

  SELECT COUNT(*) CountTranLocks
  FROM sys.dm_tran_locks
  WHERE request_session_id = @@SPID;
--CountTranLocks
----------------
--2
ROLLBACK
GO