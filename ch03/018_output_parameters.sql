---------------------------------------------------------------------
-- Output Parameters
---------------------------------------------------------------------

-- Altering GetCustOrders Procedure
USE InsideTSQL2008;
GO

ALTER PROC dbo.GetCustOrders
    @custid   AS INT,
    @fromdate AS DATETIME = '19000101',
    @todate   AS DATETIME = '99991231',
    @numrows  AS INT OUTPUT
AS
    SET NOCOUNT ON;

    DECLARE @err AS INT;

    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE custid = @custid
        AND orderdate >= @fromdate
        AND orderdate < @todate;

    SELECT @numrows = @@rowcount, @err = @@error;

    RETURN @err;
GO