USE InsideTSQL2008;

-- Test the ConcatOrders function
SELECT custid, dbo.ConcatOrders(custid) AS orders
FROM Sales.Customers;

--custid      orders
------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1           10643;10692;10702;10835;10952;11011;
--2           10308;10625;10759;10926;
--3           10365;10507;10535;10573;10677;10682;10856;