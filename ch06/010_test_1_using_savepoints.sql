--TRUNCATE TABLE dbo.Employees ;

--EXEC AddEmp @empid = 1, @empname = 'Emp1', @mgrid = NULL ;

-- The first run succeeds.
--(1 row affected)

-- The second run fails.

--(0 rows affected)
--Error detected.
--Transaction is open and committable.
--Rollback of tran opened by proc.
--Msg 50000, Level 14, State 1, Procedure AddEmp, Line 70 [Batch Start Line 0]
--Violation of PRIMARY KEY constraint 'PK_Employees'. Cannot insert duplicate key in object 'dbo.Employees'. The duplicate key value is (1).(Original error number: 2627)

-- Third run:

--BEGIN TRANSACTION ;
--	EXEC AddEmp @empid = 1, @empname = 'Emp1', @mgrid = NULL ;
--ROLLBACK TRANSACTION ;

--(0 rows affected)
--Error detected.
--Transaction is open and committable.
--Proc was invoked in an open tran.
--Roll back only proc's activity.
--Msg 50000, Level 14, State 1, Procedure AddEmp, Line 70 [Batch Start Line 18]
--Violation of PRIMARY KEY constraint 'PK_Employees'. Cannot insert duplicate key in object 'dbo.Employees'. The duplicate key value is (1).(Original error number: 2627)

SET XACT_ABORT ON ;

BEGIN TRANSACTION ;
	EXEC AddEmp @empid = 1, @empname = 'Emp1', @mgrid = NULL ;
ROLLBACK TRANSACTION ;

SET XACT_ABORT OFF ;

--(0 rows affected)
--Error detected.
--Transaction is open and uncommittable.
--Proc was invoked in an open tran, but tran is uncommittable.
--Deferring error handling to caller.
--Msg 50000, Level 14, State 1, Procedure AddEmp, Line 70 [Batch Start Line 30]
--Violation of PRIMARY KEY constraint 'PK_Employees'. Cannot insert duplicate key in object 'dbo.Employees'. The duplicate key value is (1).(Original error number: 2627)

