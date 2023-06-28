-- Solution with table variables
DECLARE @YearlyCounts AS TABLE
(
  orderyear INT PRIMARY KEY,
  numorders INT
);

SET STATISTICS IO ON ;

INSERT INTO @YearlyCounts(orderyear, numorders)
    SELECT YEAR(orderdate) AS orderyear, COUNT(*) AS numorders
    FROM Sales.Orders
    GROUP BY YEAR(orderdate);

SELECT C.orderyear, C.numorders, C.numorders - P.numorders AS diff
FROM @YearlyCounts AS C
    LEFT OUTER JOIN @YearlyCounts AS P
        ON C.orderyear = P.orderyear + 1
ORDER BY C.orderyear ;

SET STATISTICS IO OFF ;

--Table 'Orders'. Scan count 1, logical reads 28624, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
--Table '#A32EE5CE'. Scan count 0, logical reads 9, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--(4 rows affected)
--orderyear   numorders   diff
------------- ----------- -----------
--2006        250105      NULL
--2007        249966      -139
--2008        251090      1124
--2009        248839      -2251

--(4 rows affected)

--Table '#A32EE5CE'. Scan count 2, logical reads 11, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.


-- Book: Because the base data from the clustered index on the Orders table was scanned only once,
-- STATISTICS IO reports only about halft the number of reads (28,621) compared to the preveious
-- solution. It also reports a very small number of reads (11) from the table variable.