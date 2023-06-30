-- Converting between binary and character

-- Character to binary
DECLARE @sql AS NVARCHAR(MAX),
  @b AS VARBINARY(MAX), @s AS NVARCHAR(MAX);
SET @s = N'0x4775696E6E657373';

IF @s NOT LIKE N'0x%' OR @s LIKE N'0x%[^0-9a-fA-F]%'
BEGIN
  RAISERROR('Possible SQL injection attempt.', 16, 1);
  RETURN;
END

SET @sql = N'SET @o = ' + @s + N';';
EXEC sp_executesql
  @stmt = @sql,
  @params = N'@o AS VARBINARY(MAX) OUTPUT',
  @o = @b OUTPUT;

SELECT @s AS String, @b as Binary ;
GO

--String                 Binary
------------------------------------------------
--0x4775696E6E657373     0x4775696E6E657373

-- Prior to SQL Server 2008 you use a scalar user-defined function (UDF) called fn_varbintohexstr to achieve this.

-- Binary to character
DECLARE @sql AS NVARCHAR(MAX),
  @b AS VARBINARY(MAX), @s AS VARCHAR(MAX);
SET @b = 0x4775696E6E657373;
SET @s = sys.fn_varbintohexstr(@b);
SELECT @b AS Binary, @s AS String;
GO

--Binary                   String
-------------------------- ----------------------
--0x4775696E6E657373       0x4775696e6e657373

(1 row affected)