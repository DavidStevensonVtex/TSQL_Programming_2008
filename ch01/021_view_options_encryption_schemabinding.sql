---------------------------------------------------------------------
-- View Options
---------------------------------------------------------------------

---------------------------------------------------------------------
-- ENCRYPTION, SCHEMABINDING 
---------------------------------------------------------------------

USE InsideTSQL2008;
IF OBJECT_ID('Sales.CustsWithOrders') IS NOT NULL
  DROP VIEW Sales.CustsWithOrders;
GO

CREATE VIEW Sales.CustsWithOrders WITH ENCRYPTION, SCHEMABINDING
AS

SELECT custid, companyname, contactname, contacttitle, 
  address, city, region, postalcode, country, phone, fax 
FROM Sales.Customers AS C
WHERE EXISTS
  (SELECT 1 FROM Sales.Orders AS O
   WHERE O.custid = C.custid);
GO

-- Try to get the view's text
EXEC sp_helptext 'Sales.CustsWithOrders';
SELECT OBJECT_DEFINITION(OBJECT_ID('Sales.CustsWithOrders'));
GO