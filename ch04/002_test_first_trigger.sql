USE tempdb; 
GO

-- Test trg_T1_i trigger

-- 0 Rows
INSERT INTO dbo.T1 SELECT 1, 'A' WHERE 1 = 0;
GO

-- 1 Row
INSERT INTO dbo.T1 SELECT 1, 'A';
GO
--Handling keycol: 1, datacol: A

-- Multi Rows
INSERT INTO dbo.T1 VALUES
  (2, 'B'), (3, 'C'), (4, 'D');
GO

--Handling keycol: 4, datacol: D
--Handling keycol: 3, datacol: C
--Handling keycol: 2, datacol: B

--(3 rows affected)