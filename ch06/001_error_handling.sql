---------------------------------------------------------------------
-- Error Handling without the TRY/CATCH Construct
---------------------------------------------------------------------

-- Error that doesn't terminate the batch
SELECT 1/0;
PRINT 'Still here...';
GO

-- Errors that terminates the batch
SELECT 'A' + 1;
PRINT 'Still here...';
GO

SELECT * FROM NonExistingObject;
PRINT 'Still here...';
GO

--Msg 8134, Level 16, State 1, Line 6
--Divide by zero error encountered.
--Still here...
--Msg 245, Level 16, State 1, Line 11
--Conversion failed when converting the varchar value 'A' to data type int.
--Msg 208, Level 16, State 1, Line 15
--Invalid object name 'NonExistingObject'.