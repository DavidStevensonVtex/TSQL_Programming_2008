-- Alter proc2; T1 and T2 with Different Schemas
ALTER PROC dbo.proc2
AS
	CREATE TABLE #T1(col1 INT NULL, col2 INT NOT NULL);
	INSERT INTO #T1 VALUES(2, 2);
	SELECT * FROM #T1;
GO

-- Execute proc1, fails
EXEC dbo.proc1;
GO

-- Execute proc2, succeeds
EXEC dbo.proc2;
GO

-- Execute proc1, succeeds
EXEC dbo.proc1;
GO

-- Execute proc1 after proc2 recompiles
EXEC sp_recompile 'dbo.proc2';
EXEC dbo.proc1;

--(1 row affected)
--col1
-------------
--1

--(1 row affected)

--Msg 213, Level 16, State 1, Procedure dbo.proc2, Line 5 [Batch Start Line 7]
--Column name or number of supplied values does not match table definition.

--(1 row affected)
--col1        col2
------------- -----------
--2           2

--(1 row affected)


--(1 row affected)
--col1
-------------
--1

--(1 row affected)

--(1 row affected)

--col1        col2
------------- -----------
--2           2

--(1 row affected)

--Object 'dbo.proc2' was successfully marked for recompilation.

--(1 row affected)
--col1
-------------
--1

--(1 row affected)

--Msg 213, Level 16, State 1, Procedure dbo.proc2, Line 5 [Batch Start Line 19]
--Column name or number of supplied values does not match table definition.

-- Book: In short, I hope that you realize it's wise to avoid naming temporary tables
-- the same in different stored procedure/levels. A way to avoid such issues is to 
-- add a unique proc identifier to the names of temporary tables. For example, you could
-- name the temporary table in proc1 #T1_proc, and in proc2 name the temporary table #T1_proc2.

