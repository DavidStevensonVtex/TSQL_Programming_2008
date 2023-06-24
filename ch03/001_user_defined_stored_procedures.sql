---------------------------------------------------------------------
-- User Defined Procedures
---------------------------------------------------------------------

-- Creation Script for GetSortedShippers
USE InsideTSQL2008;

IF OBJECT_ID('dbo.GetSortedShippers', 'P') IS NOT NULL
  DROP PROC dbo.GetSortedShippers;
GO
-- Stored procedure GetSortedShippers
-- Returns shippers sorted by requested sort column
-- "You can perform input validation in stored procedures."

CREATE PROC dbo.GetSortedShippers
  @colname AS sysname = NULL
AS

    DECLARE @msg AS NVARCHAR(500);

    -- Input validation
    IF @colname IS NULL
    BEGIN
        SET @msg = N'A value must be supplied for parameter @colname.';
        RAISERROR(@msg, 16, 1);
        RETURN;
    END

    IF @colname NOT IN(N'shipperid', N'companyname', N'phone')
    BEGIN
        SET @msg =
            N'Valid values for @colname are: '
            + N'N''shipperid'', N''companyname'', N''phone''.';
        RAISERROR(@msg, 16, 1);
    RETURN;
    END

    -- Return shippers sorted by requested sort column
    IF @colname = N'shipperid'
        SELECT shipperid, companyname, phone
        FROM Sales.Shippers
        ORDER BY shipperid;
    ELSE IF @colname = N'companyname'
        SELECT shipperid, companyname, phone
        FROM Sales.Shippers
        ORDER BY companyname;
    ELSE IF @colname = N'phone'
        SELECT shipperid, companyname, phone
        FROM Sales.Shippers
        ORDER BY phone;
GO