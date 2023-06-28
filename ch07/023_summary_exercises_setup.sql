---------------------------------------------------------------------
-- Summary Exercises
---------------------------------------------------------------------

-- Listing 7-1: Code that creates realistic table sizes for summary exercises 
SET NOCOUNT ON;
USE tempdb;

IF SCHEMA_ID('Sales') IS NULL EXEC('CREATE SCHEMA Sales');
IF OBJECT_ID('Sales.Customers', 'U') IS NOT NULL DROP TABLE Sales.Customers;
IF OBJECT_ID('Sales.Orders', 'U') IS NOT NULL DROP TABLE Sales.Orders;
GO

SELECT n AS custid
INTO Sales.Customers
FROM InsideTSQL2008.dbo.Nums
WHERE n <= 10000;

ALTER TABLE Sales.Customers ADD PRIMARY KEY(custid);

SELECT n AS orderid,
    DATEADD(day, ABS(CHECKSUM(NEWID())) % (4*365), '20060101') AS orderdate,
    1 + ABS(CHECKSUM(NEWID())) % 10000 AS custid,
    1 + ABS(CHECKSUM(NEWID())) % 40    AS empid,
    CAST('a' AS CHAR(200)) AS filler
INTO Sales.Orders
FROM InsideTSQL2008.dbo.Nums
WHERE n <= 1000000;

ALTER TABLE Sales.Orders ADD PRIMARY KEY(orderid);
CREATE INDEX idx_cid_eid ON Sales.Orders(custid, empid);
GO