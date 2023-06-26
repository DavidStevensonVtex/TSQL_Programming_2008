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

-- Connection 1 - Step 1
BEGIN TRAN
  UPDATE dbo.T1 SET col2 = col2 + 'A' WHERE col1 = 101;
GO

-- (2 rows affected)

-- Connection 1 - Step 3
  SELECT col2 FROM dbo.T2 WHERE col1 = 201;
COMMIT TRAN
GO
-- hangs...

--col2
----------------------------------------------------
--X
--X

--(2 rows affected)