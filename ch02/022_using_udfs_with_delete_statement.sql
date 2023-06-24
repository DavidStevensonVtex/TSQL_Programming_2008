USE InsideTSQL2008 ;

BEGIN TRANSACTION;

SELECT custid, YEAR(orderdate) AS OrderDateYear FROM dbo.CustOrders(1) ;
-- Can Delete Data Through Function

-- Book: Don't run this code because it will fail with a foreign key violation.
-- I just wanted to provide you with a code sample.
DELETE FROM dbo.CustOrders(1) WHERE YEAR(orderdate) = 2007;

--Msg 547, Level 16, State 0, Line 7
--The DELETE statement conflicted with the REFERENCE constraint "FK_OrderDetails_Orders". 
--The conflict occurred in database "InsideTSQL2008", table "Sales.OrderDetails", column 'orderid'.

SELECT custid, YEAR(orderdate) AS OrderDateYear FROM dbo.CustOrders(1) ;

ROLLBACK TRANSACTION ;

