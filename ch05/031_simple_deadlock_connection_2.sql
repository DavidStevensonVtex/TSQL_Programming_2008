---------------------------------------------------------------------
-- Deadlocks
---------------------------------------------------------------------

--keycol      col1        col2
------------- ----------- --------------------------------------------------
--1           101         A
--2           102         Version 2
--3           103         C
--4           101         C

---------------------------------------------------------------------
-- Simple Deadlock Example
---------------------------------------------------------------------

-- Connection 2 - Step 2
SET NOCOUNT ON;
USE testdb;
GO
BEGIN TRAN
  UPDATE dbo.T2 SET col1 = col1 + 1 WHERE keycol = 2;
GO

-- Connection 2 - Step 4
  SELECT col1 FROM dbo.T1 WHERE keycol = 2;
COMMIT TRAN
GO

-- hangs

--col1
-------------
--Msg 1205, Level 13, State 51, Line 25
--Transaction (Process ID 51) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction.