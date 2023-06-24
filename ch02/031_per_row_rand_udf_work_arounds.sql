USE InsideTSQL2008;

-- Following succeeds
IF OBJECT_ID('dbo.VRand', 'V') IS NOT NULL
  DROP VIEW dbo.VRand;
GO
CREATE VIEW dbo.VRand AS SELECT RAND() AS r;
GO

IF OBJECT_ID('dbo.PerRowRand', 'FN') IS NOT NULL
  DROP FUNCTION dbo.PerRowRand;
GO
CREATE FUNCTION dbo.PerRowRand() RETURNS FLOAT
AS
BEGIN
  RETURN (SELECT r FROM dbo.VRand);
END
GO

USE InsideTSQL2008;

SELECT n, (SELECT r FROM dbo.VRand) AS 'VRand View', dbo.PerRowRand() AS PerRowRand, GETDATE() AS dt, NEWID() AS guid
FROM dbo.Nums
WHERE n <= 10;
GO