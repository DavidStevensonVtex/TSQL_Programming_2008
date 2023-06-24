USE tempdb ;
GO

-- Fails
CREATE PROC dbo.Proc2
AS

SELECT col2 FROM dbo.T1;
GO

--Msg 207, Level 16, State 1, Procedure Proc2, Line 6 [Batch Start Line 2]
--Invalid column name 'col2'.