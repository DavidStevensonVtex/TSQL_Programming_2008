USE InsideTSQL2008;
-- Query EmpOrders
SET STATISTICS IO ON;
SELECT empid, totalqty, cnt FROM dbo.EmpOrders;

-- Query Base Tables
SELECT O.empid, SUM(OD.qty) AS totalqty, AVG(OD.qty) AS avgqty, COUNT_BIG(*) AS cnt
FROM Sales.Orders AS O
  JOIN Sales.OrderDetails AS OD
    ON OD.orderid = O.orderid
GROUP BY O.empid;

SET STATISTICS IO OFF;

--(9 rows affected)
--Table 'EmpOrders'. Scan count 1, logical reads 2, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--(1 row affected)

--(9 rows affected)
--Table 'EmpOrders'. Scan count 1, logical reads 2, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--(1 row affected)