USE tempdb; 
GO

-- Test trigger trg_T1_i
INSERT INTO dbo.T1(keycol, datacol) VALUES(1, 10);
GO
-- Key: 1 inserted.

-- Error on attempt to insert multiple rows
INSERT INTO dbo.T1(keycol, datacol) VALUES
  (2, 20), (3, 30), (4, 40);
GO
--Msg 512, Level 16, State 1, Procedure trg_T1_i, Line 6 [Batch Start Line 8]
--Subquery returned more than 1 value. This is not permitted when the subquery follows =, !=, <, <= , >, >= or when the subquery is used as an expression.
--The statement has been terminated.