---------------------------------------------------------------------
-- EXECUTE AS
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Parameterizing Sort Order
---------------------------------------------------------------------

-- Parameterizing Sort Order, Solution 1
USE InsideTSQL2008;
IF OBJECT_ID('dbo.GetSortedShippers', 'P') IS NOT NULL
  DROP PROC dbo.GetSortedShippers;
GO

CREATE PROC dbo.GetSortedShippers
  @colname AS sysname, @sortdir AS CHAR(1) = 'A'
AS

IF @sortdir = 'A'
  SELECT shipperid, companyname, phone
  FROM Sales.Shippers
  ORDER BY
    CASE @colname
      WHEN N'shipperid'   THEN shipperid
      WHEN N'companyname' THEN companyname
      WHEN N'phone'       THEN phone
      ELSE CAST(NULL AS SQL_VARIANT)
    END
ELSE
  SELECT shipperid, companyname, phone
  FROM Sales.Shippers
  ORDER BY
    CASE @colname
      WHEN N'shipperid'   THEN shipperid
      WHEN N'companyname' THEN companyname
      WHEN N'phone'       THEN phone
      ELSE CAST(NULL AS SQL_VARIANT)
    END DESC;
GO