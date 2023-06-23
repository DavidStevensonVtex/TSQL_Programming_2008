USE tempdb ;
GO

-- Calculate a grouping factor
IF OBJECT_ID('dbo.SalesGrp', 'V') IS NOT NULL DROP VIEW dbo.SalesGrp;
GO
CREATE VIEW dbo.SalesGrp
AS

SELECT mnth, sgn,
  (SELECT MIN(mnth) FROM dbo.SalesTrendSgn AS V2
   WHERE V2.sgn <> V1.sgn
     AND V2.mnth > V1.mnth) AS grp
FROM dbo.SalesTrendSgn AS V1;
GO

SELECT * FROM dbo.SalesGrp;