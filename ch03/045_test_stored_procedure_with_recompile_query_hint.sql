USE InsideTSQL2008;
GO

SET STATISTICS IO ON ;

-- Test proc
EXEC dbo.GetOrders @d = 1;
EXEC dbo.GetOrders @d = 365;
GO

--(1 row affected)
--Table 'Orders'. Scan count 1, logical reads 4, physical reads 3, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, 
-- lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--(1 row affected)

--(1 row affected)
--Table 'Orders'. Scan count 1, logical reads 4, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, 
-- lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--(1 row affected)

-- Logical reads are low at 4.
-- Execution plans are good for low selectivity, using a Nonclustered index (50%) Orders.idx_nc_orderdate, 
-- and Key Lookup (Clustered) Orders.PK_orders (50%).