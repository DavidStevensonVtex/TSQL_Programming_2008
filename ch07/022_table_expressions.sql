---------------------------------------------------------------------
-- Table Expressions
---------------------------------------------------------------------

-- Return for each Employee, the Row with the Highest orderid
USE InsideTSQL2008;

WITH EmpMax AS
(
  SELECT empid, MAX(orderid) AS maxoid
  FROM Sales.Orders
  GROUP BY empid
)
SELECT O.orderid, O.empid, O.custid, O.orderdate
FROM Sales.Orders AS O
  JOIN EmpMax AS EM
    ON O.orderid = EM.maxoid;
GO

--orderid     empid       custid      orderdate
------------- ----------- ----------- -----------------------
--11078       1           1           2023-06-24 16:21:49.720
--11073       2           58          2008-05-05 00:00:00.000
--11063       3           37          2008-04-30 00:00:00.000
--11076       4           9           2008-05-06 00:00:00.000
--11043       5           74          2008-04-22 00:00:00.000
--11045       6           10          2008-04-23 00:00:00.000
--11074       7           73          2008-05-06 00:00:00.000
--11075       8           68          2008-05-06 00:00:00.000
--11058       9           6           2008-04-29 00:00:00.000

--(9 rows affected)