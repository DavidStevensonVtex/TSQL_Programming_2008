USE InsideTSQL2008;
GO

-- RECOMPILE Query Hint
ALTER PROC dbo.GetOrders
  @odate AS DATETIME
AS
    SELECT orderid, custid, empid, orderdate /* 33145F87-1109-4959-91D6-F1EC81F8428F */
    FROM Sales.Orders
    WHERE orderdate >= @odate
    OPTION(RECOMPILE);
GO
