USE testdb;
GO

---------------------------------------------------------------------
-- Lock Escalation
---------------------------------------------------------------------

-- Create and populate table TestEscalation
IF OBJECT_ID('dbo.TestEscalation', 'U') IS NOT NULL
  DROP TABLE dbo.TestEscalation;
GO

SELECT n AS col1, CAST('a' AS CHAR(200)) AS filler
INTO dbo.TestEscalation
FROM dbo.Nums
WHERE n <= 100000;

CREATE UNIQUE CLUSTERED INDEX idx1 ON dbo.TestEscalation(col1);
GO