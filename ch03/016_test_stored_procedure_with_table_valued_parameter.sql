USE InsideTSQL2008;

-- Execute procedure
DECLARE @Myorderids AS dbo.OrderIDs;

INSERT INTO @Myorderids(pos, orderid)
  VALUES(1, 10248),(2, 10250),(3, 10249);

EXEC dbo.GetOrders @T = @Myorderids;
GO

--orderid     orderdate               custid      empid
------------- ----------------------- ----------- -----------
--10248       2006-07-04 00:00:00.000 85          5
--10250       2006-07-08 00:00:00.000 34          4
--10249       2006-07-05 00:00:00.000 79          6

--(3 rows affected)