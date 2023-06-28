-- Creation Script for CreateGlobals Procedure
USE master; 
IF OBJECT_ID('dbo.CreateGlobals', 'P') IS NOT NULL DROP PROC dbo.CreateGlobals 
GO 
CREATE PROC dbo.CreateGlobals 
AS 
 
CREATE TABLE ##Globals 
( 
  varname sysname NOT NULL PRIMARY KEY, 
  val     SQL_VARIANT NULL 
); 
GO 
 
EXEC dbo.sp_procoption 'dbo.CreateGlobals', 'startup', 'true';
GO

-- Restart SQL Server