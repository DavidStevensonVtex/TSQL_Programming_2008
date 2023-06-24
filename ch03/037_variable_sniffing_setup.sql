USE InsideTSQL2008;
GO

---------------------------------------------------------------------
-- Variable Sniffing
---------------------------------------------------------------------

-- First load an order from today
INSERT INTO Sales.Orders
  (custid, empid, orderdate, requireddate, shippeddate, shipperid, freight,
   shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
 VALUES
  (1, 1, CURRENT_TIMESTAMP, '20100212 00:00:00.000', NULL, 1, 1,
   N'a', N'a', N'a', N'a', N'a', N'a');
GO

IF OBJECT_ID('dbo.GetOrders', 'P') IS NOT NULL DROP PROC dbo.GetOrders;
GO

CREATE PROC dbo.GetOrders
  @d AS INT = 0
AS
    DECLARE @odate AS DATETIME;
    SET @odate = DATEADD(day, -@d, CONVERT(VARCHAR(8), CURRENT_TIMESTAMP, 112));

    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE orderdate >= @odate;
GO