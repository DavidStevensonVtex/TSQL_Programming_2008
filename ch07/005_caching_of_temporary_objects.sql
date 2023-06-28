---------------------------------------------------------------------
-- Caching of Temporary Objects
---------------------------------------------------------------------

-- Create proc TestCaching
SET NOCOUNT ON;
USE tempdb;

IF OBJECT_ID('dbo.TestCaching', 'P') IS NOT NULL
  DROP PROC dbo.TestCaching;
GO
CREATE PROC dbo.TestCaching
AS
    CREATE TABLE #T1(n INT, filler CHAR(2000));

    INSERT INTO #T1 VALUES
    (1, 'a'),
    (2, 'a'),
    (3, 'a');
GO

-- Query temporary objects, should get no output
SELECT name FROM tempdb.sys.objects WHERE name LIKE '#%';