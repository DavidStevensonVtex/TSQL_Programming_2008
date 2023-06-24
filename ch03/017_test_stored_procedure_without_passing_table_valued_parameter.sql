USE InsideTSQL2008;

-- Executing without input uses an empty table by default
EXEC dbo.GetOrders;
GO

--orderid     orderdate               custid      empid
------------- ----------------------- ----------- -----------

--(0 rows affected)