USE InsideTSQL2008;
GO

-- OPTIMIZE FOR UNKNOWN
IF OBJECT_ID('dbo.GetOrders', 'P') IS NOT NULL DROP PROC dbo.GetOrders;
GO

CREATE PROC dbo.GetOrders
  @odate AS DATETIME
AS
    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE orderdate >= @odate
    OPTION(OPTIMIZE FOR (@odate UNKNOWN));
GO

SET STATISTICS IO ON ;

EXEC dbo.GetOrders @odate = '20080506';

--Table 'Orders'. Scan count 1, logical reads 21, physical reads 1, page server reads 0, read-ahead reads 12, page server read-ahead reads 0, lob logical reads 0, 
--lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--(1 row affected)

-- Number of rows returned was 5 (high selectivity) but the selection of the Clustered Index Scan was best for low selectivity.
-- This will work well if subsequent invocatons are typically for low selectivity queries.