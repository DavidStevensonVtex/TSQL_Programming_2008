USE InsideTSQL2008;
GO

SET STATISTICS IO ON ;

-- Test proc
EXEC dbo.GetOrders;
GO

--(1 row affected)
--Table 'Orders'. Scan count 1, logical reads 4, physical reads 4, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, 
--lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

-- Execution plan uses Index Seek on Non-clustered index: Orders.idx_nc_orderdate (50%) and Key Lookup on Clustered index: Orders.PK_Orders.
-- Logical reads are low at 4.