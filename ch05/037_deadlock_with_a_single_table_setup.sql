---------------------------------------------------------------------
-- Deadlock with a Single table
---------------------------------------------------------------------
USE testdb ;
GO

-- First make sure row with keycol = 2 has col = 102
UPDATE dbo.T1 SET col1 = 102, col2 = 'B' WHERE keycol = 2;
GO

SELECT * FROM dbo.T1 ;

--keycol      col1        col2
------------- ----------- --------------------------------------------------
--1           101         AAA
--2           102         B
--3           103         C
--4           101         CAA