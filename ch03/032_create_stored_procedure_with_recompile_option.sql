USE InsideTSQL2008;
GO

-- CREATE WITH RECOMPILE
ALTER PROC dbo.GetOrders
  @odate AS DATETIME
WITH RECOMPILE
AS
    SELECT orderid, custid, empid, orderdate /* 33145F87-1109-4959-91D6-F1EC81F8428F */
    FROM Sales.Orders
    WHERE orderdate >= @odate;
GO