USE tempdb ;
GO

-- Test trg_T1_iud trigger

-- 0 Rows
INSERT INTO T1 SELECT 1, 'A' WHERE 1 = 0;
go
--# Rows Inserted: 0 # Rows Deleted: 0
--No rows affected

-- INSERT
INSERT INTO T1 SELECT 1, 'A';
go
--Rows Inserted: 1 # Rows Deleted: 0
--INSERT of at least one row identified

-- UPDATE
UPDATE T1 SET datacol = 'AA' WHERE keycol = 1;
GO
--# Rows Inserted: 1 # Rows Deleted: 1
--UPDATE of at least one row identified

-- DELETE
DELETE FROM T1 WHERE keycol = 1;
GO
--# Rows Inserted: 0 # Rows Deleted: 1
--DELETE of at least one row identified