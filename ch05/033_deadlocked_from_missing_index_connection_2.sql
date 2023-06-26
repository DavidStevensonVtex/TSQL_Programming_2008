---------------------------------------------------------------------
-- Deadlock for missing index
---------------------------------------------------------------------
USE testdb ;
GO

-- Connection 2 - Step 2
BEGIN TRAN
  UPDATE dbo.T2 SET col2 = col2 + 'B' WHERE col1 = 203;
GO
-- (1 row affected)

-- Connection 2 - Step 4
  SELECT col2 FROM dbo.T1 WHERE col1 = 103;
COMMIT TRAN
GO
-- hangs

--col2
----------------------------------------------------
--Msg 1205, Level 13, State 51, Line 14
--Transaction (Process ID 53) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction.