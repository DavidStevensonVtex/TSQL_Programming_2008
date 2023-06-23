USE InsideTSQL2008;

-- Enforcing UNIQUE with Multiple NULLs

-- Creating Table T1 and View V1
USE tempdb;
IF OBJECT_ID('dbo.V1', 'V') IS NOT NULL DROP VIEW dbo.V1;
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
GO

CREATE TABLE dbo.T1
(
  keycol  INT         NULL,
  datacol VARCHAR(10) NOT NULL
);
GO

CREATE VIEW dbo.V1 WITH SCHEMABINDING
AS

SELECT keycol FROM dbo.T1 WHERE keycol IS NOT NULL;
GO

CREATE UNIQUE CLUSTERED INDEX idx_uc_keycol ON dbo.V1(keycol);

-- Test Inserts
INSERT INTO dbo.T1(keycol, datacol) VALUES(1,    'a');
INSERT INTO dbo.T1(keycol, datacol) VALUES(1,    'b'); -- fails
--Msg 2601, Level 14, State 1, Line 28
--Cannot insert duplicate key row in object 'dbo.V1' with unique index 'idx_uc_keycol'. The duplicate key value is (1).
--The statement has been terminated.
INSERT INTO dbo.T1(keycol, datacol) VALUES(NULL, 'c');
INSERT INTO dbo.T1(keycol, datacol) VALUES(NULL, 'd');

-- Query T1
SELECT keycol, datacol FROM dbo.T1;
