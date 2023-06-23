USE tempdb ;
GO

-- Identify ranges of months with the same trend
-- (up, same, down, unknown)

-- Solution using views

-- Calculate the sign of the difference between
-- the current qty and the previous month's
IF OBJECT_ID('dbo.SalesTrendSgn', 'V') IS NOT NULL DROP VIEW dbo.SalesTrendSgn;
GO
CREATE VIEW dbo.SalesTrendSgn
AS

SELECT mnth, qty,
  SIGN((S1.qty -
         (SELECT TOP (1) qty
          FROM dbo.Sales AS S2
          WHERE S2.mnth < S1.mnth
          ORDER BY S2.mnth DESC))) AS sgn
FROM dbo.Sales AS S1;
GO

SELECT * FROM dbo.SalesTrendSgn;