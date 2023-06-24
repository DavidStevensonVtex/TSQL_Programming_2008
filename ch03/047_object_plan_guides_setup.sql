USE InsideTSQL2008;
GO

---------------------------------------------------------------------
-- Object Plan Guides setup
---------------------------------------------------------------------

IF OBJECT_ID('dbo.GetOrders', 'P') IS NOT NULL DROP PROC dbo.GetOrders;
GO

CREATE PROC dbo.GetOrders
  @d AS INT = 0
AS
    DECLARE @odate AS DATETIME;
    SET @odate = DATEADD(day, -@d, CONVERT(VARCHAR(8), CURRENT_TIMESTAMP, 112));

    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE orderdate >= @odate;
GO