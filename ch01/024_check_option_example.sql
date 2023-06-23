USE InsideTSQL2008;
GO

---------------------------------------------------------------------
-- CHECK OPTION
---------------------------------------------------------------------

--  Specifying WITH CHECK OPTION hwne creating a view prevents INSERT and UPDATE
--  statements that conflict with the view's query filter. Without this option, 
--  a view normally accepts modifications that do not meet the query's filter.
--  For example, the CustsWithOrders view accepts the following INSERT even 
--  though it inserts a new customer that has no orders yet.

-- Notice that you can insert a row through the view
INSERT INTO Sales.CustsWithOrders(
         companyname, contactname, contacttitle, address, city, region,
         postalcode, country, phone, fax)
  VALUES(N'Customer ABCDE', N'ABCDE', N'ABCDE', N'ABCDE', N'ABCDE', 
         N'ABCDE', N'ABCDE', N'ABCDE', N'ABCDE', N'ABCDE');

-- But when you query the view, you won't see it
SELECT custid, companyname
FROM Sales.CustsWithOrders
WHERE companyname = N'Customer ABCDE';

-- You can see it in the table, though
SELECT custid, companyname
FROM Sales.Customers
WHERE companyname = N'Customer ABCDE';
GO