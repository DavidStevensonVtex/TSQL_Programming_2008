USE InsideTSQL2008;

SET STATISTICS IO ON;

-- Run first with high selectivity
EXEC dbo.GetOrders '20080506';

--(4 rows affected)
--Table 'Orders'. Scan count 1, logical reads 10, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, 
--lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
