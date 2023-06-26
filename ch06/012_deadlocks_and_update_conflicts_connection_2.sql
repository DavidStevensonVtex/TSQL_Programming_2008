-- Listing 6-6: Error Handling Retry Logic, Connection 2
SET NOCOUNT ON;
USE testdb;
GO

SET LOCK_TIMEOUT 30000;

DECLARE @retry AS INT, @i AS INT, @j AS INT, @maxretries AS INT;
SELECT @retry = 1, @i = 0, @maxretries = 3;

WHILE @retry = 1 AND @i <= @maxretries
BEGIN
  SET @retry = 0;
  BEGIN TRY
    BEGIN TRAN
      SET @j = (SELECT SUM(col1) FROM dbo.T2);
      WAITFOR DELAY '00:00:05';
      UPDATE dbo.T2 SET col1 += 1;
      WAITFOR DELAY '00:00:05';
      SET @j = (SELECT SUM(col1) FROM dbo.T1);
    COMMIT TRAN
    PRINT 'Transaction completed successfully.';
  END TRY
  BEGIN CATCH
    -- Lock timeout
    IF ERROR_NUMBER() = 1222
    BEGIN
      PRINT 'Lock timeout detected.';
      IF XACT_STATE() <> 0 ROLLBACK;
    END
    -- Deadlock / Update conflict
    ELSE IF ERROR_NUMBER() IN (1205, 3960)
    BEGIN
      PRINT CASE ERROR_NUMBER()
              WHEN 1205 THEN 'Deadlock'
              WHEN 3960 THEN 'Update conflict'
            END + ' detected.';
      IF XACT_STATE() <> 0 ROLLBACK;
      SELECT @retry = 1, @i += 1;
      IF @i <= @maxretries
      BEGIN
        PRINT 'Retry #' + CAST(@i AS VARCHAR(10)) + '.';
        WAITFOR DELAY '00:00:05';
      END
    END
    ELSE
    BEGIN
      PRINT 'Unhandled error: ' + CAST(ERROR_NUMBER() AS VARCHAR(10))
        + ', ' + ERROR_MESSAGE();
      IF XACT_STATE() <> 0 ROLLBACK;
    END
  END CATCH
END

IF @i > @maxretries
  PRINT 'Failed ' + CAST(@maxretries AS VARCHAR(10)) + ' retries.';
GO

--Deadlock detected.
--Retry #1.
--Deadlock detected.
--Retry #2.
--Deadlock detected.
--Retry #3.
--Deadlock detected.
--Failed 3 retries.