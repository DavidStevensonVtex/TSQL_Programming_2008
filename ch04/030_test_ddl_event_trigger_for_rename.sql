USE testdb ;
GO

-- test

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
CREATE TABLE dbo.T1(col1 INT PRIMARY KEY);
EXEC sp_rename 'dbo.T1.col1', 'col2', 'COLUMN';
GO

--Caution: Changing any part of an object name could break scripts and stored procedures.
--RENAME event occurred.
--    SchemaName      : dbo
--    TargetObjectName: T1
--    ObjectName      : col1
--    NewObjectName   : col2