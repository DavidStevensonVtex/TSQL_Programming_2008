SET NOCOUNT ON;
USE InsideTSQL2008;

IF OBJECT_ID('Sales.CustsWithOrders', 'V') IS NOT NULL
  DROP VIEW Sales.CustsWithOrders;
GO

CREATE VIEW Sales.CustsWithOrders
AS

SELECT custid, companyname, contactname, contacttitle,
  address, city, region, postalcode, country, phone, fax
FROM Sales.Customers AS C
WHERE EXISTS
  (SELECT * FROM Sales.Orders AS O
   WHERE O.custid = C.custid);
GO
