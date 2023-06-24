---------------------------------------------------------------------
-- Table-Valued UDFs
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Inline Table-Valued UDFs
---------------------------------------------------------------------

-- Creating CustOrders function
SET NOCOUNT ON;
USE InsideTSQL2008;

IF OBJECT_ID('dbo.CustOrders', 'IF') IS NOT NULL
  DROP FUNCTION dbo.CustOrders;
GO
CREATE FUNCTION dbo.CustOrders
  (@custid AS INT) RETURNS TABLE
AS
RETURN
  SELECT orderid, custid, empid, orderdate, requireddate,
    shippeddate, shipperid, freight, shipname, shipaddress, shipcity,
    shipregion, shippostalcode, shipcountry
  FROM Sales.Orders
  WHERE custid = @custid;
GO