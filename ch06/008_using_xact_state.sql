---------------------------------------------------------------------
-- Errors in Transactions
---------------------------------------------------------------------

USE testdb ;
GO

---------------------------------------------------------------------
-- Using XACT_STATE
---------------------------------------------------------------------

-- Run Listing 6-3 two times, then turn XACT_ABORT ON and run again

-- Listing 6-3: Error Handling with Transaction States
BEGIN TRY

  BEGIN TRAN
    INSERT INTO dbo.Employees(empid, empname, mgrid)
      VALUES(3, 'Emp3', 1);
    /* other activity */
  COMMIT TRAN

  PRINT 'Code completed successfully.';

END TRY
BEGIN CATCH

  PRINT 'Error: ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + ' found.';

  IF (XACT_STATE()) = -1
  BEGIN
	  PRINT 'Transaction is open but uncommittable.';
	  /* ...investigate data... */
	  ROLLBACK TRAN; -- can only ROLLBACK
	  /* ...handle the error... */
  END
  ELSE IF (XACT_STATE()) = 1
  BEGIN
	  PRINT 'Transaction is open and committable.';
	  /* ...handle error... */
	  COMMIT TRAN; -- or ROLLBACK
  END
  ELSE
  BEGIN
	  PRINT 'No open transaction.';
	  /* ...handle error... */
  END

END CATCH
GO

 --SET XACT_ABORT ON;
-- Run Listing 6-3
 --SET XACT_ABORT OFF;
GO

-- First run:
--(1 row affected)
--Code completed successfully.

--Second run:
--(0 rows affected)
--Error: 2627 found.
--Transaction is open and committable.

--Third run: with SET XACT_ABORT ON ;

--(0 rows affected)
--Error: 2627 found.
--Transaction is open but uncommittable.