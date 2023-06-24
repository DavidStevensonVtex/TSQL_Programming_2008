USE InsideTSQL2008;
GO

-- Create a plan guide
EXEC sp_create_plan_guide
  @name = N'PG_GetOrders_Selective',
  @stmt = N'SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderdate >= @odate;',
  @type = N'OBJECT',
  @module_or_batch = N'dbo.GetOrders',
  @hints = N'OPTION (OPTIMIZE FOR (@odate = ''99991231''))';
GO