-- Solution based on temporary tables

-- Book: You realize that if you imlement a similar solution, except using a temporary table instead
-- of the table expression, the data will have to be scanned more than once -- one time to
-- produce the aggregated information you store in the temporary table, and another time 
-- to process the outer reference to oRders representing the base data that you join with the 
-- temporary table. 

USE InsideTSQL2008 ;
GO

SET STATISTICS IO ON ;

CREATE TABLE #CustMax
(
  custid INT      NOT NULL PRIMARY KEY,
  mx     DATETIME NOT NULL
);


INSERT INTO #CustMax(custid, mx)
  SELECT custid, MAX(orderdate) AS mx
  FROM Sales.Orders
  GROUP BY custid;

SELECT O.orderid, O.orderdate, O.custid, O.empid
FROM Sales.Orders AS O
  JOIN #CustMax AS M
    ON O.custid = M.custid
   AND O.orderdate = M.mx;

SET STATISTICS IO OFF ;

--Table '#CustMax____________________________________________________________________________________________________________00000000000D'. Scan count 0, logical reads 179, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
--Table 'Orders'. Scan count 1, logical reads 5, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--(89 rows affected)


--(1 row affected)
--orderid     orderdate               custid      empid
------------- ----------------------- ----------- -----------
--11078       2023-06-24 16:21:49.720 1           1
--10926       2008-03-04 00:00:00.000 2           4
--10856       2008-01-28 00:00:00.000 3           3
--11016       2008-04-10 00:00:00.000 4           9
--10924       2008-03-04 00:00:00.000 5           3
--11058       2008-04-29 00:00:00.000 6           9
--10826       2008-01-12 00:00:00.000 7           6
--10970       2008-03-24 00:00:00.000 8           9
--11076       2008-05-06 00:00:00.000 9           4
--11048       2008-04-24 00:00:00.000 10          7
--11023       2008-04-14 00:00:00.000 11          1
--11054       2008-04-28 00:00:00.000 12          8
--10259       2006-07-18 00:00:00.000 13          4
--11041       2008-04-22 00:00:00.000 14          3
--11042       2008-04-22 00:00:00.000 15          2
--10848       2008-01-23 00:00:00.000 16          7
--11067       2008-05-04 00:00:00.000 17          1
--10890       2008-02-16 00:00:00.000 18          7
--11056       2008-04-28 00:00:00.000 19          8
--11072       2008-05-05 00:00:00.000 20          4
--10725       2007-10-31 00:00:00.000 21          4
--10789       2007-12-22 00:00:00.000 23          1
--11050       2008-04-27 00:00:00.000 24          8
--11012       2008-04-09 00:00:00.000 25          1
--10971       2008-03-24 00:00:00.000 26          2
--11060       2008-04-30 00:00:00.000 27          2
--10963       2008-03-19 00:00:00.000 28          9
--10928       2008-03-05 00:00:00.000 29          1
--11037       2008-04-21 00:00:00.000 30          7
--11049       2008-04-24 00:00:00.000 31          3
--11061       2008-04-30 00:00:00.000 32          4
--10785       2007-12-18 00:00:00.000 33          1
--11052       2008-04-27 00:00:00.000 34          3
--11055       2008-04-28 00:00:00.000 35          7
--10660       2007-09-08 00:00:00.000 36          8
--11063       2008-04-30 00:00:00.000 37          3
--10933       2008-03-06 00:00:00.000 38          6
--11028       2008-04-16 00:00:00.000 39          2
--10972       2008-03-24 00:00:00.000 40          4
--10973       2008-03-24 00:00:00.000 40          6
--11051       2008-04-27 00:00:00.000 41          7
--10810       2008-01-01 00:00:00.000 42          2
--10545       2007-05-22 00:00:00.000 43          8
--11070       2008-05-05 00:00:00.000 44          2
--10884       2008-02-12 00:00:00.000 45          4
--11071       2008-05-05 00:00:00.000 46          1
--11039       2008-04-21 00:00:00.000 47          1
--11018       2008-04-13 00:00:00.000 48          4
--10950       2008-03-16 00:00:00.000 49          1
--11004       2008-04-07 00:00:00.000 50          3
--10724       2007-10-30 00:00:00.000 51          8
--10945       2008-03-12 00:00:00.000 52          4
--11057       2008-04-29 00:00:00.000 53          3
--10986       2008-03-30 00:00:00.000 54          8
--11034       2008-04-20 00:00:00.000 55          8
--11020       2008-04-14 00:00:00.000 56          2
--11073       2008-05-05 00:00:00.000 58          2
--11053       2008-04-27 00:00:00.000 59          2
--11007       2008-04-08 00:00:00.000 60          8
--10989       2008-03-31 00:00:00.000 61          2
--11068       2008-05-04 00:00:00.000 62          8
--11021       2008-04-14 00:00:00.000 63          3
--11019       2008-04-13 00:00:00.000 64          6
--11077       2008-05-06 00:00:00.000 65          1
--11062       2008-04-30 00:00:00.000 66          4
--11059       2008-04-29 00:00:00.000 67          2
--11075       2008-05-06 00:00:00.000 68          8
--11013       2008-04-09 00:00:00.000 69          2
--11015       2008-04-10 00:00:00.000 70          2
--11064       2008-05-01 00:00:00.000 71          1
--10869       2008-02-04 00:00:00.000 72          5
--11074       2008-05-06 00:00:00.000 73          7
--11043       2008-04-22 00:00:00.000 74          5
--10974       2008-03-25 00:00:00.000 75          3
--11038       2008-04-21 00:00:00.000 76          1
--10992       2008-04-01 00:00:00.000 77          1
--11003       2008-04-06 00:00:00.000 78          3
--10967       2008-03-23 00:00:00.000 79          2
--11069       2008-05-04 00:00:00.000 80          1
--10839       2008-01-19 00:00:00.000 81          3
--10822       2008-01-08 00:00:00.000 82          6
--10994       2008-04-02 00:00:00.000 83          2
--10850       2008-01-23 00:00:00.000 84          1
--10739       2007-11-12 00:00:00.000 85          3
--11046       2008-04-23 00:00:00.000 86          8
--11025       2008-04-15 00:00:00.000 87          6
--10935       2008-03-09 00:00:00.000 88          4
--11066       2008-05-01 00:00:00.000 89          7
--11005       2008-04-07 00:00:00.000 90          2
--11044       2008-04-23 00:00:00.000 91          4

--(90 rows affected)

--Table 'Orders'. Scan count 1, logical reads 5, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
--Table '#CustMax____________________________________________________________________________________________________________00000000000D'. Scan count 1, logical reads 2, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.


--(1 row affected)


DROP TABLE #CustMax;