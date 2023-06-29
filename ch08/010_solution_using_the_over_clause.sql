-- Solution using the OVER clause
SELECT empid, dt, qty,
  SUM(qty) OVER(PARTITION BY empid
                ORDER BY dt
                ROWS BETWEEN UNBOUNDED PRECEDING
                         AND CURRENT ROW) AS sumqty
FROM dbo.Sales;
GO

-- This solution took under 1 second.