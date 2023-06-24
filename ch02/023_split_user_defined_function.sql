---------------------------------------------------------------------
-- Split Array
---------------------------------------------------------------------

---------------------------------------------------------------------
-- T-SQL Split UDF
---------------------------------------------------------------------

-- Create SplitTSQL function
-- USE CLRUtilities;
USE InsideTSQL2008 ;

IF OBJECT_ID('dbo.SplitTSQL', 'IF') IS NOT NULL
  DROP FUNCTION dbo.SplitTSQL; 
GO
CREATE FUNCTION dbo.SplitTSQL
  (@string NVARCHAR(MAX), @separator NCHAR(1) = N',') RETURNS TABLE
AS
RETURN
  SELECT
    (n - 1) - DATALENGTH(REPLACE(LEFT(@string, n - 1), @separator, ''))/2
      + 1 AS pos,
    SUBSTRING(@string, n, 
      CHARINDEX(@separator, @string + @separator, n) - n) AS element
  FROM dbo.Nums
  WHERE n <= DATALENGTH(@string)/2 + 1
    AND SUBSTRING(@separator + @string, n, 1) = @separator;
GO