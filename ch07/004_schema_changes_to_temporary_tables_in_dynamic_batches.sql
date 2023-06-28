-----------------------------------------------------------------------
-- Schema Changes of Temporary Tables in Dynamic Batches
---------------------------------------------------------------------

-- Sample Code
 
-- Assume @column_defs and @insert were constructed dynamically
-- with appropriate safeguards against SQL injection
DECLARE @column_defs AS VARCHAR(1000), @insert AS VARCHAR(1000);
SET @column_defs = 'col1 INT, col2 DECIMAL(10, 2)';
SET @insert = 'INSERT INTO #T VALUES(10, 20.30)';

--	In the outer level, create temp table #T with a single dummy column
CREATE TABLE #T(dummycol INT);

--	Within a dynamic batch:
--    Alter #T adding the columns you need
--    Alter #T dropping the dummy column
--    Open another level of dynamic execution
--      Populate #T

EXEC('
ALTER TABLE #T ADD ' + @column_defs + ';
ALTER TABLE #T DROP COLUMN dummycol;
EXEC(''' + @insert + ''')');
GO

--	Back in the outer level, access #T in a new batch
SELECT * FROM #T;

-- Cleanup
 DROP TABLE #T;
 GO

-- col1        col2
------------- ---------------------------------------
--10          20.30