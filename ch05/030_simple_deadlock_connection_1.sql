---------------------------------------------------------------------
-- Deadlocks
---------------------------------------------------------------------

--Deadlocks occur when two or more processes block each other such that they enter
--a blocking chain that cannot be resolved without the systems intervention. Without
--intervention, processes involved in a deadlock have to wait indefinitely for one 
--another to reqlinquish their locks.

--SQL Server automatically detects deadlock situations and resolves them by terminating
--the transaction that did less work. (error 1205)

--You can set the DEADLOCK_PRIORITY session option to one of 21 possible integer values 
--in the range -10 through 10. You can specify the options LOW (-5), NORMAL (0) or HIGH(5).

--You can use techniques like specifying UPDLOCK hint when reading data to avoid lost updates.

--This particular deadlock can be avoided if you swap the order in which you access the tables.

-- Internet:

--Deadlock can be prevented by eliminating any of the four necessary conditions, which are 
--mutual exclusion, hold and wait, no preemption, and circular wait. 



---------------------------------------------------------------------
-- Simple Deadlock Example
---------------------------------------------------------------------

--keycol      col1        col2
------------- ----------- --------------------------------------------------
--1           101         A
--2           102         Version 2
--3           103         C
--4           101         C


-- Connection 1 - Step 1
SET NOCOUNT ON;
USE testdb;
GO
BEGIN TRAN
  UPDATE dbo.T1 SET col1 = col1 + 1 WHERE keycol = 2;
GO

-- Connection 1 - Step 3
  SELECT col1 FROM dbo.T2 WHERE keycol = 2;
COMMIT TRAN
GO
-- Hangs

--col1
-------------
--202