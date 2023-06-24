USE InsideTSQL2008 ;
GO

IF OBJECT_ID('dbo.sp_Proc1', 'P') IS NOT NULL DROP PROCEDURE dbo.sp_Proc1 ;
GO

CREATE PROCEDURE dbo.sp_Proc1 
AS
    PRINT 'InsideTSL2008.dbo.sp_Proc1 executing in ' + DB_NAME() ;
GO

USE InsideTSQL2008 ;
EXEC dbo.sp_Proc1 ;

USE AdventureWorks ;
EXEC dbo.sp_Proc1 ;
