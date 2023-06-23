USE tempdb ;
GO

-- Calculate the sign of the difference between
-- the current qty and the previous month's
IF OBJECT_ID('dbo.SalesTrendSgn', 'V') IS NOT NULL
  DROP VIEW dbo.SalesTrendSgn;
GO
CREATE VIEW dbo.SalesTrendSgn
AS

SELECT Cur.mnth, Cur.qty, SIGN(Cur.qty - Prv.qty) AS sgn
FROM dbo.SalesRN AS Cur
  LEFT OUTER JOIN dbo.SalesRN AS Prv
    ON Cur.rn = Prv.rn + 1;
GO

SELECT *
FROM dbo.SalesTrendSgn
ORDER BY mnth ;