
---------------------------------------------------------------------
-- Chapter 4: Triggers
---------------------------------------------------------------------

---------------------------------------------------------------------
-- AFTER Triggers
---------------------------------------------------------------------

---------------------------------------------------------------------
-- The inserted and deleted Special Tables
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Identifying the Number of affected Rows
---------------------------------------------------------------------

-- Create table T1
SET NOCOUNT ON; 
USE tempdb; 
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1; 

CREATE TABLE dbo.T1 
( 
  keycol  INT         NOT NULL PRIMARY KEY, 
  datacol VARCHAR(10) NOT NULL 
);
GO

-- Creation Script for trg_T1_i Trigger
CREATE TRIGGER trg_T1_i ON T1 FOR INSERT
AS
    DECLARE @rc AS INT = 
        (SELECT COUNT(*) FROM (SELECT TOP (2) * FROM inserted) AS D);

    IF @rc = 0 RETURN;

    DECLARE @keycol AS INT, @datacol AS VARCHAR(10);

    IF @rc = 1 -- single row
    BEGIN
        SELECT @keycol = keycol, @datacol = datacol FROM inserted;

        PRINT 'Handling keycol: '
            + CAST(@keycol AS VARCHAR(10))
            + ', datacol: ' + @datacol;
    END
    ELSE -- multi row
    BEGIN
    
        DECLARE @C AS CURSOR;

        SET @C = CURSOR FAST_FORWARD FOR
            SELECT keycol, datacol FROM inserted;

        OPEN @C;
        
        FETCH NEXT FROM @C INTO @keycol, @datacol;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            PRINT 'Handling keycol: '
                + CAST(@keycol AS VARCHAR(10))
                + ', datacol: ' + @datacol;

            FETCH NEXT FROM @C INTO @keycol, @datacol;
        END

    END
GO
