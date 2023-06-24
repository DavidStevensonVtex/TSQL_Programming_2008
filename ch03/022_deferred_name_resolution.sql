USE tempdb;

-- Create T1
CREATE TABLE dbo.T1(col1 INT);
INSERT INTO dbo.T1(col1) VALUES(1);

-- Succeeds
EXEC dbo.Proc1;

--col1
-------------
--1

--(1 row affected)