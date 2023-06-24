USE InsideTSQL2008;
GO

-- Use the OPTIMIZE FOR Hint
ALTER PROC dbo.GetOrders
  @d AS INT = 0
AS
    DECLARE @odate AS DATETIME;
    SET @odate = DATEADD(day, -@d, CONVERT(VARCHAR(8), CURRENT_TIMESTAMP, 112));

    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE orderdate >= @odate
    OPTION(OPTIMIZE FOR(@odate = '99991231'));
GO