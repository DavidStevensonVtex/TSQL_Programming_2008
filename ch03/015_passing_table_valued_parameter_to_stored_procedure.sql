USE InsideTSQL2008;

-- Table-valued parameters
IF OBJECT_ID('dbo.GetOrders', 'P') IS NOT NULL DROP PROC dbo.GetOrders;
GO

CREATE PROC dbo.GetOrders(@T AS dbo.OrderIDs READONLY)
AS
    SELECT O.orderid, O.orderdate, O.custid, O.empid
    FROM Sales.Orders AS O
        JOIN @T AS K
            ON O.orderid = K.orderid
    ORDER BY K.pos;
GO