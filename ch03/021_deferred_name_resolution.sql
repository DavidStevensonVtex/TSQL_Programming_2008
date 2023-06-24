---------------------------------------------------------------------
-- Resolution
---------------------------------------------------------------------

-- Cleanup
USE tempdb;
IF OBJECT_ID('dbo.Proc1', 'P') IS NOT NULL DROP PROC dbo.Proc1;
IF OBJECT_ID('dbo.Proc2', 'P') IS NOT NULL DROP PROC dbo.Proc2;
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
GO

-- Create Proc1
CREATE PROC dbo.Proc1
AS
	SELECT col1 FROM dbo.T1;
GO

-- Fails
EXEC dbo.Proc1;

--Msg 208, Level 16, State 1, Procedure dbo.Proc1, Line 6 [Batch Start Line 17]
--Invalid object name 'dbo.T1'.