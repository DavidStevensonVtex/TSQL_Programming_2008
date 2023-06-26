---------------------------------------------------------------------
-- Deadlock for missing index
---------------------------------------------------------------------

--SELECT * FROM dbo.T1 ;
--keycol      col1        col2
------------- ----------- --------------------------------------------------
--1           101         AA
--2           103         Version 2
--3           103         C
--4           101         CA

--SELECT * FROM dbo.T2 ;
--keycol      col1        col2
------------- ----------- --------------------------------------------------
--1           201         X
--2           202         Y
--3           203         Z
--4           201         X

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

--col2
----------------------------------------------------
--Msg 1205, Level 13, State 51, Line 33
--Transaction (Process ID 53) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction.