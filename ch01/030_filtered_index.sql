USE tempdb ;

-- Drop view
IF OBJECT_ID('dbo.V1', 'V') IS NOT NULL DROP VIEW dbo.V1;

-- Create filtered index
CREATE UNIQUE INDEX idx_keycol_notnull ON dbo.T1(keycol)
  WHERE keycol IS NOT NULL;

-- Insert more rows
INSERT INTO dbo.T1(keycol, datacol) VALUES(NULL, 'e');
INSERT INTO dbo.T1(keycol, datacol) VALUES(NULL, 'f');
INSERT INTO dbo.T1(keycol, datacol) VALUES(1, 'g');
--Msg 2601, Level 14, State 1, Line 13
--Cannot insert duplicate key row in object 'dbo.T1' with unique index 'idx_keycol_notnull'. The duplicate key value is (1).

-- Query T1
SELECT keycol, datacol FROM dbo.T1;

-- CLeanup
USE InsideTSQL2008;
IF OBJECT_ID('dbo.EmpOrders', 'V') IS NOT NULL DROP VIEW dbo.EmpOrders;

USE tempdb;
IF OBJECT_ID('dbo.V1', 'V') IS NOT NULL DROP VIEW dbo.V1;
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
