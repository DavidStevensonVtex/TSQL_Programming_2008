USE InsideTSQL2008 ;
GO

-- Parameterizing Sort Order, Solution 4
CREATE PROC dbo.GetSortedShippers_shipperid_A
AS
  SELECT shipperid, companyname, phone
  FROM Sales.Shippers
  ORDER BY shipperid;
GO
CREATE PROC dbo.GetSortedShippers_companyname_A
AS
  SELECT shipperid, companyname, phone
  FROM Sales.Shippers
  ORDER BY companyname;
GO
CREATE PROC dbo.GetSortedShippers_phone_A
AS
  SELECT shipperid, companyname, phone
  FROM Sales.Shippers
  ORDER BY phone;
GO
CREATE PROC dbo.GetSortedShippers_shipperid_D
AS
  SELECT shipperid, companyname, phone
  FROM Sales.Shippers
  ORDER BY shipperid   DESC;
GO
CREATE PROC dbo.GetSortedShippers_companyname_D
AS
  SELECT shipperid, companyname, phone
  FROM Sales.Shippers
  ORDER BY companyname DESC;
GO
CREATE PROC dbo.GetSortedShippers_phone_D
AS
  SELECT shipperid, companyname, phone
  FROM Sales.Shippers
  ORDER BY phone       DESC;
GO

ALTER PROC dbo.GetSortedShippers
  @colname AS sysname, @sortdir AS CHAR(1) = 'A'
AS
  IF @colname = N'shipperid'        AND @sortdir = 'A'
    EXEC dbo.GetSortedShippers_shipperid_A;
  ELSE IF @colname = N'companyname' AND @sortdir = 'A'
    EXEC dbo.GetSortedShippers_companyname_A;
  ELSE IF @colname = N'phone'       AND @sortdir = 'A'
    EXEC dbo.GetSortedShippers_phone_A;
  ELSE IF @colname = N'shipperid'   AND @sortdir = 'D'
    EXEC dbo.GetSortedShippers_shipperid_D;
  ELSE IF @colname = N'companyname' AND @sortdir = 'D'
    EXEC dbo.GetSortedShippers_companyname_D;
  ELSE IF @colname = N'phone'       AND @sortdir = 'D'
    EXEC dbo.GetSortedShippers_phone_D;
GO

-- Test
EXEC dbo.GetSortedShippers @colname = N'shipperid', @sortdir = N'D';
GO

--shipperid   companyname                              phone
------------- ---------------------------------------- ------------------------
--3           Shipper ZHISN                            (415) 555-0138
--2           Shipper ETYNR                            (425) 555-0136
--1           Shipper GVSUA                            (503) 555-0137

--(3 rows affected)