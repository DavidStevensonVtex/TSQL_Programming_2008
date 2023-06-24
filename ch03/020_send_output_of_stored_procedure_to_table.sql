USE InsideTSQL2008;
GO

-- Send Output of GetCustOrders to a Temporary Table
IF OBJECT_ID('tempdb..#CustOrders', 'U') IS NOT NULL
  DROP TABLE #CustOrders;

CREATE TABLE #CustOrders
(
  orderid    INT      NOT NULL PRIMARY KEY,
  custid INT NOT NULL,
  empid INT      NOT NULL,
  orderdate  DATETIME NOT NULL
);
GO

DECLARE @myerr AS INT, @mynumrows AS INT;

INSERT INTO #CustOrders(orderid, custid, empid, orderdate)
  EXEC @myerr = dbo.GetCustOrders
    @custid   = 1,
    @fromdate = '20070101',
    @todate   = '20080101',
    @numrows  = @mynumrows OUTPUT;

SELECT orderid, custid, empid, orderdate
FROM #CustOrders;

SELECT @myerr AS err, @mynumrows AS rc;
GO

--orderid     custid      empid       orderdate
------------- ----------- ----------- -----------------------
--10643       1           6           2007-08-25 00:00:00.000
--10692       1           4           2007-10-03 00:00:00.000
--10702       1           4           2007-10-13 00:00:00.000

--(3 rows affected)

--err         rc
------------- -----------
--0           3

--(1 row affected)