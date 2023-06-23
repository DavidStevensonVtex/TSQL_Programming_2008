-- Create T1 and V1
USE tempdb;
GO

IF OBJECT_ID('dbo.V1', 'V') IS NOT NULL DROP VIEW dbo.V1;
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
GO

CREATE TABLE dbo.T1(col1 INT, col2 INT);
INSERT INTO dbo.T1(col1, col2) VALUES(1, 2);
GO

CREATE VIEW dbo.V1
AS

SELECT * FROM dbo.T1;
GO

-- Query V1, Notice 2 Columns
SELECT * FROM dbo.V1;
GO