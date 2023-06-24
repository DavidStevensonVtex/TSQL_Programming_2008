USE InsideTSQL2008 ;

-- Test SplitTSQL function
SELECT pos, element FROM dbo.SplitTSQL(N'a,b,c', N',') AS F;
GO

DECLARE @arr AS NVARCHAR(MAX);
SET @arr = N'10248,10249,10250';

SELECT O.orderid, O.custid, O.empid, O.orderdate
FROM dbo.SplitTSQL(@arr, N',') AS F
  JOIN InsideTSQL2008.Sales.Orders AS O
    ON CAST(F.element AS INT) = O.orderid;
GO

--pos                  element
---------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1                    a
--2                    b
--3                    c

--(3 rows affected)

--orderid     custid      empid       orderdate
------------- ----------- ----------- -----------------------
--10248       85          5           2006-07-04 00:00:00.000
--10249       79          6           2006-07-05 00:00:00.000
--10250       34          4           2006-07-08 00:00:00.000

--(3 rows affected)