USE InsideTSQL2008 ;
EXEC dbo.sp_Proc1 ;

USE AdventureWorks ;
EXEC dbo.sp_Proc1 ;

--master.dbo.sp_Proc1 executing in InsideTSQL2008

--(830 rows affected)
--master.dbo.sp_Proc1 executing in AdventureWorks
--Msg 208, Level 16, State 1, Procedure dbo.sp_Proc1, Line 5 [Batch Start Line 0]
--Invalid object name 'Sales.Orders'.
