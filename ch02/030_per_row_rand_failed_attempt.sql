USE InsideTSQL2008;

-- Following fails
IF OBJECT_ID('dbo.PerRowRand', 'FN') IS NOT NULL
  DROP FUNCTION dbo.PerRowRand;
GO
CREATE FUNCTION dbo.PerRowRand() RETURNS FLOAT
AS
BEGIN
  RETURN RAND();
END
GO

--Msg 443, Level 16, State 1, Procedure PerRowRand, Line 4 [Batch Start Line 6]
--Invalid use of a side-effecting operator 'rand' within a function.
