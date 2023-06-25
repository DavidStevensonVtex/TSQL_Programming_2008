USE InsideTSQL2008 ;
GO

-- Parameterizing Sort Order, Solution 3
ALTER PROC dbo.GetSortedShippers
  @colname AS sysname, @sortdir AS CHAR(1) = 'A'
AS
	IF @colname NOT IN (N'shipperid', N'companyname', N'phone')
	BEGIN
	  RAISERROR('Possible SQL injection attempt.', 16, 1);
	  RETURN;
	END

	DECLARE @sql AS NVARCHAR(500);

	SET @sql = N'SELECT shipperid, companyname, phone
	FROM Sales.Shippers
	ORDER BY '
	  + QUOTENAME(@colname)
	  + CASE @sortdir WHEN 'D' THEN N' DESC' ELSE '' END
	  + ';';

	EXEC sp_executesql @sql;
GO

-- Test solution 3
EXEC dbo.GetSortedShippers @colname = N'shipperid', @sortdir = N'D';
GO

--shipperid   companyname                              phone
------------- ---------------------------------------- ------------------------
--3           Shipper ZHISN                            (415) 555-0138
--2           Shipper ETYNR                            (425) 555-0136
--1           Shipper GVSUA                            (503) 555-0137

--(3 rows affected)