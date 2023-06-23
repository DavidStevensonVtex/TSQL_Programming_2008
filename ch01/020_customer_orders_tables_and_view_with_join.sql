USE tempdb ;
GO

-- Updating 1 Side of 1-M Relationship

-- Creating Sales.Customers, Orders and CustOrders
SET NOCOUNT ON;
USE tempdb;
IF OBJECT_ID('dbo.CustOrders', 'V') IS NOT NULL DROP VIEW dbo.CustOrders;
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers
(
  cid   INT         NOT NULL PRIMARY KEY,
  cname VARCHAR(25) NOT NULL,
  /* other columns */
)
INSERT INTO dbo.Customers(cid, cname) VALUES
  (1, 'Cust 1'),
  (2, 'Cust 2');

CREATE TABLE dbo.Orders
(
  oid INT NOT NULL PRIMARY KEY,
  cid INT NOT NULL REFERENCES dbo.Customers,
  /* other columns */
)
INSERT INTO dbo.Orders(oid, cid) VALUES
  (1001, 1),
  (1002, 1),
  (1003, 1),
  (2001, 2),
  (2002, 2),
  (2003, 2);
GO

CREATE VIEW dbo.CustOrders
AS

SELECT C.cid, C.cname, O.oid
FROM dbo.Customers AS C
  JOIN dbo.Orders AS O
    ON O.cid = C.cid;
GO

-- Query CustOrders
SELECT cid, cname, oid FROM dbo.CustOrders;

-- Update CustOrders
UPDATE dbo.CustOrders
  SET cname = 'Cust 42'
WHERE oid = 1001;

-- Query CustOrders
SELECT cid, cname, oid FROM dbo.CustOrders;