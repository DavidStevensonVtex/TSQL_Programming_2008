USE tempdb ;

-- Msg 2729, Level 16, State 1, Line 9
-- Column 'col1' in table 'dbo.T1' cannot be used in an index or statistics or as a partition key because it is non-deterministic.
-- Msg 1750, Level 16, State 1, Line 9
-- Could not create constraint or index.

-- Create AddOne function
IF OBJECT_ID('dbo.AddOne', 'FN') IS NOT NULL
  DROP FUNCTION dbo.AddOne;
GO
CREATE FUNCTION dbo.AddOne(@i AS INT) 
    RETURNS INT WITH SCHEMABINDING
AS
BEGIN
  RETURN @i + 1;
END
GO

SELECT OBJECTPROPERTY(OBJECT_ID('dbo.AddOne'), 'IsDeterministic') AS 'Is AddOne UDF Deterministic' ;
