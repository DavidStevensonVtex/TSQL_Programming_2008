-- Do not rely on TOP
ALTER VIEW Sales.CustsWithOrders
AS

SELECT TOP (100) PERCENT
  country, custid, companyname, contactname, contacttitle,
  address, city, region, postalcode, phone, fax
FROM Sales.Customers AS C
WHERE EXISTS
  (SELECT * FROM Sales.Orders AS O
   WHERE O.custid = C.custid)
ORDER BY country;
GO

-- Query CustsWithOrders
-- When querying the view, SQL Server does not have to guarantee any order of the output
-- unless the outer query has an ORDER BY clause.
-- SQL Server 2008 Books Online
-- "The ORDER BY clause is used only to determine the rows that are returned by the TOP clause
-- in the view definition. The ORDER BY clause does not guarantee ordered results when the view
-- is queried, unless ORDER BY is also specified in the query [using the view] itself."
SELECT country, custid, companyname
FROM Sales.CustsWithOrders;
GO