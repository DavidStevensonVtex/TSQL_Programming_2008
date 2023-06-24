USE InsideTSQL2008;
GO

-- Use inline expressions
ALTER PROC dbo.GetOrders
  @d AS INT = 0
AS
    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE orderdate >= DATEADD(day, -@d, CONVERT(VARCHAR(8), CURRENT_TIMESTAMP, 112));
GO

SET STATISTICS IO ON ;

-- Run GetOrders and notice use of the index Figure 7-1 (4 logical reads)
EXEC dbo.GetOrders;
GO
