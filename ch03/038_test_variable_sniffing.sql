USE InsideTSQL2008;
GO

SET STATISTICS IO ON ;

-- Run GetOrders and notice Table Scan (23 logical reads)
EXEC dbo.GetOrders;
GO

--(1 row affected)
--Table 'Orders'. Scan count 1, logical reads 21, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, 
--lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
