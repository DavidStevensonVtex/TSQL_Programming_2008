-- Preserving both @@ERROR and @@ROWCOUNT
SET NOCOUNT ON;
USE InsideTSQL2008;

DECLARE @custid AS INT, @err AS INT, @rc AS INT;
SET @custid = 1;

SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE custid = @custid;

SELECT @err = @@ERROR, @rc = @@ROWCOUNT;
-- error handling code goes here 
SELECT @err AS error_number, @rc AS row_count;
GO