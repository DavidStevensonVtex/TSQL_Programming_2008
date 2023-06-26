USE testdb;
GO

-- Disable lock escalation and run transaction again
ALTER TABLE dbo.TestEscalation SET (LOCK_ESCALATION = DISABLE);

BEGIN TRAN

  DELETE FROM dbo.TestEscalation WHERE col1 <= 20000;

  SELECT COUNT(*) AS CountTranLocks
  FROM sys.dm_tran_locks
  WHERE request_session_id = @@SPID;
--CountTranLocks
----------------
--20529
ROLLBACK
GO