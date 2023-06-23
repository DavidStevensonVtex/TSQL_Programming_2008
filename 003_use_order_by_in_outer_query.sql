---------------------------------------------------------------------
-- ORDER BY in a View
---------------------------------------------------------------------

-- ORDER BY in a View is not Allowed
--ALTER VIEW Sales.CustsWithOrders
--AS

--SELECT country, custid, companyname, contactname, contacttitle,
--  address, city, region, postalcode, phone, fax
--FROM Sales.Customers AS C
--WHERE EXISTS
--  (SELECT * FROM Sales.Orders AS O
--   WHERE O.custid = C.custid)
--ORDER BY country;
--GO

-- Instead, use ORDER BY in Outer Query
-- Note: Can't use ORDER BY in VIEW unless TOP or FOR XML is used.
SELECT country, custid, companyname
FROM Sales.CustsWithOrders
ORDER BY country;
GO