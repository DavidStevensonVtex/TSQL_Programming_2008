USE testdb ;
GO

---------------------------------------------------------------------
-- Read Committed
---------------------------------------------------------------------

-- Connection 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
----------------------------------------------------
--Version 1

-- Attempting to read the data will be blocked until the transaction
-- in connection 1 is committed. Go back to connection 1 and issue the
-- COMMIT TRANSACTION.

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
----------------------------------------------------
--Version 2

-- Cleanup
--UPDATE dbo.T1 SET col2 = 'Version 1' WHERE keycol = 2;
--GO