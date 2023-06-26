USE InsideTSQL2008 ;
GO

-- Using a Stored Procedure
IF OBJECT_ID('dbo.GetCustomerOrders', 'P') IS NOT NULL
  DROP PROC dbo.GetCustomerOrders;
GO

CREATE PROC dbo.GetCustomerOrders
  @custid   AS INT,
  @fromdate AS DATETIME = '19000101',
  @todate   AS DATETIME = '99991231 23:59:59.997',
  @numrows  AS INT OUTPUT
AS
    -- Input validation goes here

    DECLARE @err AS INT;

    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE custid = @custid
        AND orderdate >= @fromdate
        AND orderdate < @todate;

    SELECT @numrows = @@ROWCOUNT, @err = @@ERROR;

    RETURN @err;
GO