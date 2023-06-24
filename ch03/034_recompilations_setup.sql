USE InsideTSQL2008;
GO

---------------------------------------------------------------------
-- Recompilations
---------------------------------------------------------------------

-- Creating CustCities Procedure
IF OBJECT_ID('dbo.CustCities', 'P') IS NOT NULL
  DROP PROC dbo.CustCities;
GO

CREATE PROC dbo.CustCities
AS
    SELECT custid, country, region, city, /* 97216686-F90E-4D5A-9A9E-CFD9E548AE81 */
    country + '.' + region + '.' + city AS CRC
    FROM Sales.Customers
    ORDER BY country, region, city;
GO
