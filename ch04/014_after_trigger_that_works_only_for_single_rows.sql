---------------------------------------------------------------------
-- INSTEAD OF Triggers
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Per-Row Triggers
---------------------------------------------------------------------

-- Create table T1
USE tempdb; 
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1; 

CREATE TABLE dbo.T1 
( 
    keycol  INT NOT NULL PRIMARY KEY, 
    datacol INT NOT NULL 
);
GO

-- Create trigger trg_T1_i
CREATE TRIGGER trg_T1_i ON T1 AFTER INSERT
AS
    DECLARE @msg AS VARCHAR(100);
    SET @msg = 'Key: ' + CAST((SELECT keycol FROM inserted) AS VARCHAR(10)) + ' inserted.';
    PRINT @msg;
GO