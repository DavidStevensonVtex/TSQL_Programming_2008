USE tempdb ;
GO

-- Implementing SalesTrends with a view and CTE
ALTER VIEW dbo.SalesTrends
AS

WITH SalesRN AS
(
  SELECT mnth, qty, ROW_NUMBER() OVER(ORDER BY mnth) AS rn
  FROM dbo.Sales
),
SalesTrendSgn AS
(
  SELECT Cur.mnth, Cur.qty, SIGN(Cur.qty - Prv.qty) AS sgn
  FROM SalesRN AS Cur
    LEFT OUTER JOIN SalesRN AS Prv
      ON Cur.rn = Prv.rn + 1
),
SalesGrp AS
(
  SELECT mnth, sgn,
    DATEADD(month,
      -1 * ROW_NUMBER() OVER(PARTITION BY sgn ORDER BY mnth),
      mnth) AS grp
  FROM SalesTrendSgn
)
SELECT 
  CONVERT(VARCHAR(6), MIN(mnth), 112) AS start_range,
  CONVERT(VARCHAR(6), MAX(mnth), 112) AS end_range,
  CASE sgn
    WHEN -1 THEN 'down'
    WHEN  0 THEN 'same'
    WHEN  1 THEN 'up'
    ELSE         'unknown'
  END AS trend
FROM SalesGrp
GROUP BY sgn, grp;
GO

-- Query SalesTrends
SELECT start_range, end_range, trend
FROM dbo.SalesTrends
ORDER BY start_range;
GO
