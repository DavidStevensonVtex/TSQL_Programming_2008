USE master ;

IF OBJECT_ID('dbo.sp_Proc1', 'P') IS NOT NULL DROP PROC dbo.sp_Proc1 ;
GO

CREATE PROC dbo.sp_Proc1
AS
    PRINT 'master.dbo.sp_Proc1 executing in ' + DB_NAME() ;
    SELECT orderid FROM Sales.Orders ;
GO

EXEC sp_MS_marksystemobject 'dbo.sp_Proc1' ;