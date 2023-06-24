---------------------------------------------------------------------
-- Scalar UDFs
---------------------------------------------------------------------

---------------------------------------------------------------------
-- T-SQL Scalar UDFs
---------------------------------------------------------------------

-- Creating the ConcatOrders function
SET NOCOUNT ON;
USE InsideTSQL2008;

IF OBJECT_ID('dbo.ConcatOrders', 'FN') IS NOT NULL
  DROP FUNCTION dbo.ConcatOrders;
GO

CREATE FUNCTION dbo.ConcatOrders
  (@custid AS INT) RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @orders AS VARCHAR(MAX);
  SET @orders = '';

  SELECT @orders = @orders + CAST(orderid AS VARCHAR(10)) + ';'
  FROM Sales.Orders
  WHERE custid = @custid;

  RETURN @orders;
END
GO