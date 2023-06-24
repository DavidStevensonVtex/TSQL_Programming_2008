USE InsideTSQL2008;

-- Following succeeds

-- Note that SQL Server cares about side effects but not about non-determinism.
-- For example, the GETDATE function is non-determistic, but it doesn't have 
-- any side effects. Therefore, SQL Server allows you to use the GETDATE function
-- in a UDF:

IF OBJECT_ID('dbo.PerRowGetdate') IS NOT NULL
  DROP FUNCTION dbo.PerRowGetdate;
GO
CREATE FUNCTION dbo.PerRowGetdate() RETURNS DATETIME
AS
BEGIN
  RETURN GETDATE();
END
GO

SELECT DISTINCT GETDATE() AS dt
FROM dbo.Nums
WHERE n <= 1000000 ;

SELECT DISTINCT dbo.PerRowGetdate() AS PerRowGetdate
FROM dbo.Nums
WHERE n <= 1000000 ;

--dt
-------------------------
--2023-06-24 12:07:22.733

--(1 row affected)

--PerRowGetdate
-------------------------
--2023-06-24 12:07:22.890
--2023-06-24 12:07:22.957
--2023-06-24 12:07:23.007
--2023-06-24 12:07:23.063
--...
--2023-06-24 12:07:26.400
--2023-06-24 12:07:26.417

--(1073 rows affected)