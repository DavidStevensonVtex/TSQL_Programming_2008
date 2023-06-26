-- Listing 6-1: Handling Errors in GetCustomerOrders Procedure
SET LOCK_TIMEOUT 5000;
DECLARE @err AS INT, @rc AS INT;

EXEC @err = dbo.GetCustomerOrders
  @custid   = 1, -- Also try with 999
  @fromdate = '20070101',
  @todate   = '20080101',
  @numrows  = @rc OUTPUT;

SELECT -- For batch-aborting errors
  @err = COALESCE(@err, @@ERROR),
  @rc  = COALESCE(@rc, @@ROWCOUNT);

SELECT @err AS error_number, @rc AS row_count;

IF @err = 0 AND @rc > 0 BEGIN
  PRINT 'Processing Successful';
  RETURN;
END

IF @err = 0 AND @rc = 0 BEGIN
  PRINT 'No rows were selected.';
  RETURN;
END

IF @err = 1222
BEGIN
  PRINT 'Handling lock time out expired error.';
  RETURN;
END

-- other errors
-- IF @err = ...

BEGIN
  PRINT 'Unhandled error detected.';
  RETURN;
END
GO

-- With table locked...
--Msg 1222, Level 16, State 56, Procedure dbo.GetCustomerOrders, Line 12 [Batch Start Line 0]
--Lock request time out period exceeded.

--(1 row affected)
--Handling lock time out expired error.