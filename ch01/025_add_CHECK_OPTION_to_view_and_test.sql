USE InsideTSQL2008;
GO

-- Add CHECK OPTION to the View
ALTER VIEW Sales.CustsWithOrders WITH ENCRYPTION, SCHEMABINDING
AS

SELECT custid, companyname, contactname, contacttitle, 
  address, city, region, postalcode, country, phone, fax 
FROM Sales.Customers AS C
WHERE EXISTS
  (SELECT 1 FROM Sales.Orders AS O
   WHERE O.custid = C.custid)
WITH CHECK OPTION;
GO

-- Notice that you can't insert a row through the view
INSERT INTO Sales.CustsWithOrders(
         companyname, contactname, contacttitle, address, city, region,
         postalcode, country, phone, fax)
  VALUES(N'Customer FGHIJ', N'FGHIJ', N'FGHIJ', N'FGHIJ', N'FGHIJ', 
         N'FGHIJ', N'FGHIJ', N'FGHIJ', N'FGHIJ', N'FGHIJ');


--Msg 550, Level 16, State 1, Line 18
--The attempted insert or update failed because the target view either specifies WITH CHECK OPTION 
--or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation 
--did not qualify under the CHECK OPTION constraint.
--The statement has been terminated.