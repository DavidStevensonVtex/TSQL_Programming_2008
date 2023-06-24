-- Ensure that plan guide was used
SET SHOWPLAN_XML ON;
GO
SELECT empid, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY empid;
GO
SET SHOWPLAN_XML OFF;
GO