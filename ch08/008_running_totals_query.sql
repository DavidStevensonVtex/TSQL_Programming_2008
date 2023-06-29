-- Set-Based Code Using Subquery for Running Aggregate
SELECT empid, dt, qty,
  (SELECT SUM(S2.qty)
   FROM dbo.Sales AS S2
   WHERE S2.empid = S1.empid
     AND S2.dt <= S1.dt) AS sumqty
FROM dbo.Sales AS S1;
GO

-- This solution takes about 1 second.