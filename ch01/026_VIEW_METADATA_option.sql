USE InsideTSQL2008;
GO

-- Add CHECK OPTION to the View
ALTER VIEW Sales.CustsWithOrders WITH ENCRYPTION, SCHEMABINDING, VIEW_METADATA
AS

SELECT custid, companyname, contactname, contacttitle, 
  address, city, region, postalcode, country, phone, fax 
FROM Sales.Customers AS C
WHERE EXISTS
  (SELECT 1 FROM Sales.Orders AS O
   WHERE O.custid = C.custid)
WITH CHECK OPTION;
GO