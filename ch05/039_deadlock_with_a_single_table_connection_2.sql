---------------------------------------------------------------------
-- Deadlock with a Single table
---------------------------------------------------------------------

-- Connection 2
SET NOCOUNT ON;
USE testdb;

DECLARE @i AS VARCHAR(10);
WHILE 1 = 1
  SET @i = (SELECT col2 FROM dbo.T1 WITH (index = idx_col1)
            WHERE col1 = 102);
GO


--Msg 1205, Level 13, State 51, Line 11
--Transaction (Process ID 52) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction.