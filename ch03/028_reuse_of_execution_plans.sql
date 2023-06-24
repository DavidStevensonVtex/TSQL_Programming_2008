---------------------------------------------------------------------
-- Compilations, Recompilations and Reuse of Execution Plans
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Reuse of Execution Plans
---------------------------------------------------------------------

-- Creating GetOrders Procedure
USE InsideTSQL2008;
IF OBJECT_ID('dbo.GetOrders', 'P') IS NOT NULL DROP PROC dbo.GetOrders;
GO

CREATE PROC dbo.GetOrders
  @odate AS DATETIME
AS
	SELECT orderid, custid, empid, orderdate /* 33145F87-1109-4959-91D6-F1EC81F8428F */
	FROM Sales.Orders
	WHERE orderdate >= @odate;
GO