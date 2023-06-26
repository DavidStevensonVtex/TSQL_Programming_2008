-- Cleanup

-- Close all connections

-- Make sure you're back in default mode
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Restore the testdb database to its default settings:
ALTER DATABASE testdb SET ALLOW_SNAPSHOT_ISOLATION OFF;
ALTER DATABASE testdb SET READ_COMMITTED_SNAPSHOT OFF;
GO

SELECT name, snapshot_isolation_state_desc, is_read_committed_snapshot_on  FROM sys.databases WHERE name = 'testdb' ;
--name                                                                                                                             snapshot_isolation_state_desc                                is_read_committed_snapshot_on
---------------------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------------ -----------------------------
--testdb                                                                                                                           OFF                                                          0

--(1 row affected)

--SELECT * FROM sys.databases ;
