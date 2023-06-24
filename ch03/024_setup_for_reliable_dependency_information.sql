---------------------------------------------------------------------
-- Reliable Dependency Information
---------------------------------------------------------------------

-- Create objects
USE tempdb;

IF OBJECT_ID('dbo.Proc1', 'P') IS NOT NULL DROP PROC dbo.Proc1;
IF OBJECT_ID('dbo.Proc2', 'P') IS NOT NULL DROP PROC dbo.Proc2;
IF OBJECT_ID('dbo.V1', 'V') IS NOT NULL DROP VIEW dbo.V1;
IF OBJECT_ID('dbo.V2', 'V') IS NOT NULL DROP VIEW dbo.V2;
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
IF OBJECT_ID('dbo.T2', 'U') IS NOT NULL DROP TABLE dbo.T2;
GO

CREATE PROC dbo.Proc1
AS
	SELECT * FROM dbo.T1;
	EXEC('SELECT * FROM dbo.T2');
GO
CREATE PROC dbo.Proc2
AS
	SELECT * FROM dbo.T3;
GO
CREATE TABLE dbo.T1(col1 INT);
CREATE TABLE dbo.T2(col2 INT);
GO
CREATE VIEW dbo.V1
AS
	SELECT col1 FROM dbo.T1;
GO
CREATE VIEW dbo.V2
AS
	SELECT col1 FROM dbo.T1;
GO