-- Returning output
DECLARE @sql AS NVARCHAR(500), @myresult AS INT

SET @sql = N'SET @result = 42;';

EXEC sp_executesql
  @stmt   = @sql,
  @params = N'@result AS INT OUTPUT',
  @result = @myresult OUTPUT;

SELECT @myresult AS 'My Result';
GO

--My Result
-------------
--42
