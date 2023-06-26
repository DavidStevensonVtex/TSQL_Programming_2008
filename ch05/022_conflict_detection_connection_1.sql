---------------------------------------------------------------------
-- Conflict Detection
---------------------------------------------------------------------

-- Connection 1, Step 1
SET NOCOUNT ON;
USE testdb;
GO

SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

BEGIN TRAN
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
------------
--Version 2

-- Connection 1, Step 2
  UPDATE dbo.T1 SET col2 = 'Version 3' WHERE keycol = 2;
COMMIT
GO

-- Connection 1, Step 3
BEGIN TRAN
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
------------
--Version 3

-- Connection 1, Step 4
  UPDATE dbo.T1 SET col2 = 'Version 5' WHERE keycol = 2;
GO

--Msg 3960, Level 16, State 2, Line 35
--Snapshot isolation transaction aborted due to update conflict. 
--You cannot use snapshot isolation to access table 'dbo.T1' directly or indirectly in database 'testdb' 
--to update, delete, or insert the row that has been modified or deleted by another transaction. 
--Retry the transaction or change the isolation level for the update/delete statement.

-- Book

--You can write error-handling code that will reissue the transaction in the event that it fails
--after an update conflict. In the next chapter, you can find coverage of error handling with
--examples of the treatment of update conflicts.

--Note that the snapshot isolation level is not suitable for modification intensive environments
--with the potential for many update conflicts. Rather, it is recommended for environments
--that mainly read data and insert data, with occasional deletes and updates, and infrequent
--update conflicts.

 SELECT col2 FROM dbo.T1 WHERE keycol = 2;

-- col2
-------------
--Version 4

-- Cleanup
 --UPDATE dbo.T1 SET col2 = 'Version 1' WHERE keycol = 2;
 --GO

-- Close all connections