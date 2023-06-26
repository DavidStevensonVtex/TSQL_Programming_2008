---------------------------------------------------------------------
-- Read Committed Snapshot
---------------------------------------------------------------------

-- Turn on READ_COMMITTED_SNAPSHOT
ALTER DATABASE testdb SET READ_COMMITTED_SNAPSHOT ON;
GO

SELECT name, snapshot_isolation_state_desc, is_read_committed_snapshot_on  FROM sys.databases WHERE name = 'testdb' ;
--SELECT * FROM sys.databases ;