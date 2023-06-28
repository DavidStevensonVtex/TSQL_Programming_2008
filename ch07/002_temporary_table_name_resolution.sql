---------------------------------------------------------------------
-- Temporary Table Name Resolution
---------------------------------------------------------------------

-- Creation Script for proc1 and proc2; T1 and T2 with Same Schema
SET NOCOUNT ON; 
USE tempdb; 

IF OBJECT_ID('dbo.proc1', 'P') IS NOT NULL DROP PROC dbo.proc1; 
IF OBJECT_ID('dbo.proc2', 'P') IS NOT NULL DROP PROC dbo.proc2; 
GO 
 
CREATE PROC dbo.proc1 
AS 
    CREATE TABLE #T1(col1 INT NOT NULL); 
    INSERT INTO #T1 VALUES(1); 
    SELECT * FROM #T1; 
    
    EXEC dbo.proc2; 
GO 
 
CREATE PROC dbo.proc2 
AS 
    CREATE TABLE #T1(col1 INT NULL); 
    INSERT INTO #T1 VALUES(2); 
    SELECT * FROM #T1; 
GO

-- Execute proc1
EXEC dbo.proc1;
GO

--The module 'proc1' depends on the missing object 'dbo.proc2'. The module will still be created; however, it cannot run successfully until the object exists.
--col1
-------------
--1

--col1
-------------
--2
