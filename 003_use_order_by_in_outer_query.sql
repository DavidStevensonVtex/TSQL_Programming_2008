---------------------------------------------------------------------
-- ORDER BY in a View
---------------------------------------------------------------------

-- ORDER BY in a View is not Allowed
ALTER VIEW Sales.CustsWithOrders
AS

SELECT country, custid, companyname, contactname, contacttitle,
  address, city, region, postalcode, phone, fax
FROM Sales.Customers AS C
WHERE EXISTS
  (SELECT * FROM Sales.Orders AS O
   WHERE O.custid = C.custid)
ORDER BY country;
GO

--Msg 1033, Level 15, State 1, Procedure CustsWithOrders, Line 10 [Batch Start Line 5]
--The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.

-- Instead, use ORDER BY in Outer Query
-- Note: Can't use ORDER BY in VIEW unless TOP or FOR XML is used.
SELECT country, custid, companyname
FROM Sales.CustsWithOrders
ORDER BY country;
GO