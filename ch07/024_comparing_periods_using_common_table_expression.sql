---------------------------------------------------------------------
-- Comparing Periods
---------------------------------------------------------------------

USE tempdb ;
GO

-- Solution with table expressions
SET STATISTICS IO ON;

WITH YearlyCounts AS
(
    SELECT YEAR(orderdate) AS orderyear, COUNT(*) AS numorders
    FROM Sales.Orders
    GROUP BY YEAR(orderdate)
)
SELECT C.orderyear, C.numorders, C.numorders - P.numorders AS diff
FROM YearlyCounts AS C
    LEFT OUTER JOIN YearlyCounts AS P
        ON C.orderyear = P.orderyear + 1;

SET STATISTICS IO OFF ;

--orderyear   numorders   diff
------------- ----------- -----------
--2006        250105      NULL
--2007        249966      -139
--2008        251090      1124
--2009        248839      -2251

--(4 rows affected)

--Table 'Orders'. Scan count 10, logical reads 57628, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--(1 row affected)

--With 57,628 logical reads, the Orders table is being scanned twice (see Clustered Index Scan in execution plan).
--This can be reduced by using a Table Variable to hold the results of the Common Table Expression.
