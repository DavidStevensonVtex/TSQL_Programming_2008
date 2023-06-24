USE InsideTSQL2008;
GO

-- Original procedure
IF OBJECT_ID('dbo.GetOrders', 'P') IS NOT NULL DROP PROC dbo.GetOrders;
GO

CREATE PROC dbo.GetOrders
  @odate AS DATETIME
AS
    SELECT orderid, custid, empid, orderdate /* 33145F87-1109-4959-91D6-F1EC81F8428F */
    FROM Sales.Orders
    WHERE orderdate >= @odate;
GO

-- Run proc first time when set option is ON
EXEC dbo.GetOrders '20080506';

-- Set session option OFF
SET CONCAT_NULL_YIELDS_NULL OFF;

-- Run proc second time when set option is OFF
EXEC dbo.GetOrders '20080506';

-- Inspect cached plans and observe that there are two plans
SELECT cacheobjtype, objtype, usecounts, setopts, sql
FROM sys.syscacheobjects
WHERE sql NOT LIKE '%sys%'
  AND sql LIKE '%33145F87-1109-4959-91D6-F1EC81F8428F%';

-- Set session option back ON
SET CONCAT_NULL_YIELDS_NULL ON;