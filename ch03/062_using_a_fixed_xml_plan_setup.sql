---------------------------------------------------------------------
-- Using A Fixed XML Plan
---------------------------------------------------------------------

IF OBJECT_ID('dbo.GetOrders', 'P') IS NOT NULL DROP PROC dbo.GetOrders;
GO

CREATE PROC dbo.GetOrders
  @odate AS DATETIME
AS
    SELECT orderid, custid, empid, orderdate
    /* 33145F87-1109-4959-91D6-F1EC81F8428F */
    FROM Sales.Orders
    WHERE orderdate >= @odate;
GO