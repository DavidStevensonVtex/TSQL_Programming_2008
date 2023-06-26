
---------------------------------------------------------------------
-- New Error Handling Functions
---------------------------------------------------------------------

USE testdb;
GO

-- Listing 6-2: New Error Handling Functions
PRINT 'Before TRY/CATCH block.';

BEGIN TRY

  PRINT '  Entering TRY block.';

  --INSERT INTO dbo.Employees(empid, empname, mgrid)
  --  VALUES(2, 'Emp2', 1);
  -- Also try with empid = 0, 'A', NULL

     INSERT INTO dbo.Employees(empid, empname, mgrid)
     VALUES(0, 'A', NULL);

  PRINT '    After INSERT.';

  PRINT '  Exiting TRY block.';

END TRY
BEGIN CATCH

  PRINT '  Entering CATCH block.';

  IF ERROR_NUMBER() = 2627
  BEGIN
    PRINT '    Handling PK violation...';
  END
  ELSE IF ERROR_NUMBER() = 547
  BEGIN
    PRINT '    Handling CHECK/FK constraint violation...';
  END
  ELSE IF ERROR_NUMBER() = 515
  BEGIN
    PRINT '    Handling NULL violation...';
  END
  ELSE IF ERROR_NUMBER() = 245
  BEGIN
    PRINT '    Handling conversion error...';
  END
  ELSE
  BEGIN
    PRINT '    Handling unknown error...';
  END

  PRINT '    Error Number  : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
  PRINT '    Error Message : ' + ERROR_MESSAGE();
  PRINT '    Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
  PRINT '    Error State   : ' + CAST(ERROR_STATE() AS VARCHAR(10));
  PRINT '    Error Line    : ' + CAST(ERROR_LINE() AS VARCHAR(10));
  PRINT '    Error Proc    : ' + ISNULL(ERROR_PROCEDURE(), 'Not within proc');

  PRINT '  Exiting CATCH block.';

END CATCH

PRINT 'After TRY/CATCH block.';
GO

-- First Run:
--Before TRY/CATCH block.
--  Entering TRY block.

--(1 row affected)
--    After INSERT.
--  Exiting TRY block.
--After TRY/CATCH block.

--Second run, using alternate INSERT statement.

--Before TRY/CATCH block.
--  Entering TRY block.

--(0 rows affected)
--  Entering CATCH block.
--    Handling CHECK/FK constraint violation...
--    Error Number  : 547
--    Error Message : The INSERT statement conflicted with the CHECK constraint "CHK_Employees_empid". The conflict occurred in database "testdb", table "dbo.Employees", column 'empid'.
--    Error Severity: 16
--    Error State   : 0
--    Error Line    : 13
--    Error Proc    : Not within proc
--  Exiting CATCH block.
--After TRY/CATCH block.