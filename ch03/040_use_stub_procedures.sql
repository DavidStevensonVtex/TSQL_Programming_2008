USE InsideTSQL2008;
GO

-- Another wa to deal with the problem is to use a stub procedure--that is, create two 
-- procedures. The first procedure accepts the original parameter, assigns the result of the
-- calculation to a local variable, and invokes a second procedure providing it with the variable
-- as input. The second procedure accepts an input order date passed to it and invokes the
-- query that refers directly to the input parameter. When a plan is generated for the procedure
-- that actually invokes the query (the second procedure), the value of the parameter will, in
-- fact, be known at optimization time.

-- Using a Stub Procedure
IF OBJECT_ID('dbo.GetOrdersQuery', 'P') IS NOT NULL
  DROP PROC dbo.GetOrdersQuery;
GO

CREATE PROC dbo.GetOrdersQuery
  @odate AS DATETIME
AS
    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE orderdate >= @odate;
GO

ALTER PROC dbo.GetOrders
  @d AS INT = 0
AS
    DECLARE @odate AS DATETIME;
    SET @odate = DATEADD(day, -@d, CONVERT(VARCHAR(8), CURRENT_TIMESTAMP, 112));

    EXEC dbo.GetOrdersQuery @odate;
GO