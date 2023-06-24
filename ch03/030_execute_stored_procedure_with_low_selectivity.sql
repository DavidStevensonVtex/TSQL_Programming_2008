SET STATISTICS IO ON;

-- Next run with low selectivity
EXEC dbo.GetOrders '20060101';

--(830 rows affected)
--Table 'Orders'. Scan count 1, logical reads 21, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, 
--lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.