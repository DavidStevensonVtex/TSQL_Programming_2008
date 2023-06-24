USE InsideTSQL2008;

-- Test Function
SELECT O.orderid, O.custid, OD.productid, OD.qty
FROM dbo.CustOrders(1) AS O
  JOIN Sales.OrderDetails AS OD
    ON O.orderid = OD.orderid;

--orderid     custid      productid   qty
------------- ----------- ----------- ------
--10643       1           28          15
--10643       1           39          21
--10643       1           46          2
--10692       1           63          20
--10702       1           3           6
--10702       1           76          15
--10835       1           59          15
--10835       1           77          2
--10952       1           6           16
--10952       1           28          2
--11011       1           58          40
--11011       1           71          20

--(12 rows affected)