USE tempdb ;
GO

-- Solution using CTEs

-- Calculate row numbers based on the order of m
IF OBJECT_ID('dbo.SalesRN', 'V') IS NOT NULL
  DROP VIEW dbo.SalesRN;
GO
CREATE VIEW dbo.SalesRN
AS

SELECT mnth, qty, ROW_NUMBER() OVER(ORDER BY mnth) AS rn
FROM dbo.Sales;
GO

SELECT * FROM dbo.SalesRN;