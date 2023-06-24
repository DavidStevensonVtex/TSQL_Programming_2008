-- Invoke GetCustOrders procedure
DECLARE @myerr AS INT, @mynumrows AS INT;

EXEC @myerr = dbo.GetCustOrders
  @custid   = 1,
  @fromdate = '20070101',
  @todate   = '20080101',
  @numrows  = @mynumrows OUTPUT;

--SELECT @myerr AS err, @mynumrows AS rc;
--GO

--orderid     custid      empid       orderdate
------------- ----------- ----------- -----------------------
--10643       1           6           2007-08-25 00:00:00.000
--10692       1           4           2007-10-03 00:00:00.000
--10702       1           4           2007-10-13 00:00:00.000

--err         rc
------------- -----------
--0           3

--(1 row affected)