USE tempdb;
GO

-- Double the quantities in the OrderDetails table by using an instead of trigger 
-- when doubling the quantities in the OrderTotals view.

-- Test trg_VOrderTotals_iou trigger
SELECT oid, pid, qty FROM dbo.OrderDetails;
SELECT oid, totalqty FROM dbo.OrderTotals;

UPDATE dbo.OrderTotals
  SET totalqty *= 2;

SELECT oid, pid, qty FROM dbo.OrderDetails;
SELECT oid, totalqty FROM dbo.OrderTotals;
GO

--oid         pid         qty
------------- ----------- -----------
--10248       1           10
--10248       2           20
--10248       3           30
--10249       1           5
--10249       2           10
--10249       3           15
--10250       1           20
--10250       2           20
--10250       3           20

--(9 rows affected)

--oid         totalqty
------------- -----------
--10248       60
--10249       30
--10250       60

--oid         pid         qty
------------- ----------- -----------
--10248       1           20
--10248       2           40
--10248       3           60
--10249       1           10
--10249       2           20
--10249       3           30
--10250       1           40
--10250       2           40
--10250       3           40

--oid         totalqty
------------- -----------
--10248       120
--10249       60
--10250       120