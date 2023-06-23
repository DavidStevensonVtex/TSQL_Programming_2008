-- Indexed View Example
USE InsideTSQL2008;
IF OBJECT_ID('dbo.EmpOrders', 'V') IS NOT NULL DROP VIEW dbo.EmpOrders;
IF OBJECT_ID('dbo.EmpOrders', 'U') IS NOT NULL DROP TABLE dbo.EmpOrders;
GO

CREATE VIEW dbo.EmpOrders WITH SCHEMABINDING
AS

SELECT O.empid, SUM(OD.qty) AS totalqty, COUNT_BIG(*) AS cnt
FROM Sales.Orders AS O
  JOIN Sales.OrderDetails AS OD
    ON OD.orderid = O.orderid
GROUP BY O.empid;
GO

CREATE UNIQUE CLUSTERED INDEX idx_uc_empid ON dbo.EmpOrders(empid);