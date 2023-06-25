USE InsideTSQL2008 ;
GO

-- Parameterizing Sort Order, Solution 2
ALTER PROC dbo.GetSortedShippers
  @colname AS sysname, @sortdir AS CHAR(1) = 'A'
AS
    SELECT shipperid, companyname, phone
    FROM Sales.Shippers
    ORDER BY
    CASE WHEN @colname = N'shipperid'   AND @sortdir = 'A'
        THEN shipperid   END,
    CASE WHEN @colname = N'companyname' AND @sortdir = 'A'
        THEN companyname END,
    CASE WHEN @colname = N'phone'       AND @sortdir = 'A'
        THEN phone       END,
    CASE WHEN @colname = N'shipperid'   AND @sortdir = 'D'
        THEN shipperid   END DESC,
    CASE WHEN @colname = N'companyname' AND @sortdir = 'D'
        THEN companyname END DESC,
    CASE WHEN @colname = N'phone'       AND @sortdir = 'D'
    THEN phone       END DESC;
GO


-- Test solution 2
EXEC dbo.GetSortedShippers @colname = N'shipperid', @sortdir = N'D';
GO

--shipperid   companyname                              phone
------------- ---------------------------------------- ------------------------
--3           Shipper ZHISN                            (415) 555-0138
--2           Shipper ETYNR                            (425) 555-0136
--1           Shipper GVSUA                            (503) 555-0137

--(3 rows affected)