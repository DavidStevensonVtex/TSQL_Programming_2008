USE InsideTSQL2008 ;

-- Can Update Data Through Function

-- Like Views, inline UDFs can be a target of a modification statement.
BEGIN TRAN
  SELECT custid, orderid, shipperid FROM CustOrders(1) AS O;
  UPDATE dbo.CustOrders(1) SET shipperid = 2;
  SELECT custid, orderid, shipperid FROM CustOrders(1) AS O;
ROLLBACK

--custid      orderid     shipperid
------------- ----------- -----------
--1           10643       1
--1           10692       2
--1           10702       1
--1           10835       3
--1           10952       1
--1           11011       1

--(6 rows affected)

--(6 rows affected)

--custid      orderid     shipperid
------------- ----------- -----------
--1           10643       2
--1           10692       2
--1           10702       2
--1           10835       2
--1           10952       2
--1           11011       2

--(6 rows affected)