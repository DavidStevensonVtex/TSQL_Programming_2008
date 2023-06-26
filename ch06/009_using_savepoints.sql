---------------------------------------------------------------------
-- Using Savepoints
---------------------------------------------------------------------

USE testdb ;
GO

-- Listing 6-4: Creation Script for AddEmp Stored Procedure
IF OBJECT_ID('dbo.AddEmp', 'P') IS NOT NULL DROP PROC dbo.AddEmp;
GO

CREATE PROC dbo.AddEmp
  @empid AS INT, @empname AS VARCHAR(25), @mgrid AS INT
AS

-- Save tran count aside
DECLARE @tc AS INT;
SET @tc = @@TRANCOUNT;

-- If tran was already active, create a savepoint
IF @tc > 0
  SAVE TRAN S1;
-- If tran was not active, open a new one
ELSE
  BEGIN TRAN

BEGIN TRY;
  -- Modify data
  INSERT INTO dbo.Employees(empid, empname, mgrid)
     VALUES(@empid, @empname, @mgrid);
  -- If proc opened the tran, it's responsible for committing it
  IF @tc = 0
    COMMIT TRAN;

END TRY
BEGIN CATCH
    PRINT 'Error detected.';
    PRINT CASE XACT_STATE()
      WHEN 0 THEN 'No transaction is open.'
      WHEN 1 THEN 'Transaction is open and committable.'
      WHEN -1 THEN 'Transaction is open and uncommittable.'
    END;
    -- Proc opened tran
    IF @tc = 0
    BEGIN
      -- Can react differently based on tran state (XACT_STATE)
      -- In this case, say we just want to roll back
      IF XACT_STATE() <> 0
      BEGIN
        PRINT 'Rollback of tran opened by proc.';
        ROLLBACK TRAN
      END
    END
    -- Proc didn't open tran
    ELSE
    BEGIN
      IF XACT_STATE() = 1
      BEGIN
        PRINT 'Proc was invoked in an open tran.
Roll back only proc''s activity.';
        ROLLBACK TRAN S1
      END
      ELSE IF XACT_STATE() = -1
        PRINT 'Proc was invoked in an open tran, but tran is uncommittable.
Deferring error handling to caller.'
    END

    -- Raise error so that caller will determine what to do with
    -- the failure in the proc
    DECLARE
      @ErrorMessage  NVARCHAR(500),
      @ErrorSeverity INT,
      @ErrorState    INT;
    SELECT
      @ErrorMessage  = ERROR_MESSAGE()
         + QUOTENAME(N'Original error number: '
                     + CAST(ERROR_NUMBER() AS NVARCHAR(10)), N'('),
      @ErrorSeverity = ERROR_SEVERITY(),
      @ErrorState    = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO