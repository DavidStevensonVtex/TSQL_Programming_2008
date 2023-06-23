USE tempdb ;
GO

-- Group ranges and return their trends
IF OBJECT_ID('dbo.SalesTrends', 'V') IS NOT NULL
  DROP VIEW dbo.SalesTrends;
GO
CREATE VIEW dbo.SalesTrends
AS

SELECT 
  CONVERT(VARCHAR(6), MIN(mnth), 112) AS start_range,
  CONVERT(VARCHAR(6), MAX(mnth), 112) AS end_range,
  CASE sgn
    WHEN -1 THEN 'down'
    WHEN  0 THEN 'same'
    WHEN  1 THEN 'up'
    ELSE         'unknown'
  END AS trend
FROM dbo.SalesGrp
GROUP BY sgn, grp;
GO

-- Query SalesTrends
SELECT start_range, end_range, trend
FROM dbo.SalesTrends
ORDER BY start_range;
GO