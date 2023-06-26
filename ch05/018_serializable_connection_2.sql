USE testdb ;
GO

---------------------------------------------------------------------
-- Serializable
---------------------------------------------------------------------

-- Connection 2
INSERT INTO dbo.T1(keycol, col1, col2) VALUES(5, 102, 'D');
GO
-- You will be blocked.

-- After commit in Connection 1.
--(1 row affected)

SELECT * FROM dbo.T1 ;
GO


--keycol      col1        col2
------------- ----------- --------------------------------------------------
--1           101         A
--2           102         Version 1
--3           103         C
--4           101         C
--5           102         D

--(5 rows affected)

-- Cleanup
--DROP INDEX dbo.T1.idx_col1;

-- In all connections issue:
 --SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
 --GO