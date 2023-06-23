USE tempdb ;
GO

-- Calculate a grouping factor
IF OBJECT_ID('dbo.SalesGrp', 'V') IS NOT NULL
  DROP VIEW dbo.SalesGrp;
GO
CREATE VIEW dbo.SalesGrp
AS

SELECT mnth, sgn,
  DATEADD(month,
    -1 * ROW_NUMBER() OVER(PARTITION BY sgn ORDER BY mnth),
    mnth) AS grp
FROM dbo.SalesTrendSgn;
GO

SELECT * 
FROM dbo.SalesGrp 
ORDER BY mnth ;