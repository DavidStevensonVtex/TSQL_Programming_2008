---------------------------------------------------------------------
-- Not firing Triggers for Specific Statements
---------------------------------------------------------------------

-- Create table T1
USE tempdb; 
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1; 
CREATE TABLE dbo.T1(col1 INT);
GO

-- Create trg_T1_i trigger using temp table
CREATE TRIGGER trg_T1_i ON dbo.T1 FOR INSERT
AS

IF OBJECT_ID('tempdb..#do_not_fire_trg_T1_i') IS NOT NULL RETURN;

PRINT 'trg_T1_i in action...';
GO