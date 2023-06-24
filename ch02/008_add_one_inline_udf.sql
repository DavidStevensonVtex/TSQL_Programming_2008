USE InsideTSQL2008 ;

-- Use Inline Table-Valued Function
IF OBJECT_ID('dbo.AddOneInline', 'IF') IS NOT NULL
  DROP FUNCTION dbo.AddOneInline;
GO
CREATE FUNCTION dbo.AddOneInline(@n AS INT) RETURNS TABLE
AS
RETURN SELECT @n + 1 AS val;
GO