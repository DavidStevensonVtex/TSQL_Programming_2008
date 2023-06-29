---------------------------------------------------------------------
-- Cursor Overhead
---------------------------------------------------------------------

-- Compare simple table scan using set-based query vs. cursor
SET NOCOUNT ON;
USE tempdb;

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
GO

SELECT n AS keycol, CAST('a' AS CHAR(200)) AS filler
INTO InsideTSQL2008.dbo.T1
FROM dbo.Nums
WHERE n <= 1000000;

CREATE UNIQUE CLUSTERED INDEX idx_keycol ON dbo.T1(keycol);
GO