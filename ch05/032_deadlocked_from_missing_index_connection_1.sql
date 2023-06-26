---------------------------------------------------------------------
-- Deadlock for missing index
---------------------------------------------------------------------
USE testdb ;
GO

-- Connection 1 - Step 1
BEGIN TRAN
  UPDATE dbo.T1 SET col2 = col2 + 'A' WHERE col1 = 101;
GO

-- (2 rows affected)

-- Connection 1 - Step 3
  SELECT col2 FROM dbo.T2 WHERE col1 = 201;
COMMIT TRAN
GO
-- hangs

--col2
----------------------------------------------------
--X
--X

--(2 rows affected)