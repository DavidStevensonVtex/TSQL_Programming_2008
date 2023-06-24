USE tempdb ;
GO

-- Test T1_getkey function as DEFAULT constraint
ALTER TABLE dbo.T1 ADD DEFAULT(dbo.T1_getkey()) FOR keycol;

INSERT INTO dbo.T1(datacol) VALUES('a');
INSERT INTO dbo.T1(datacol) VALUES('b');
INSERT INTO dbo.T1(datacol) VALUES('c');
DELETE FROM dbo.T1 WHERE keycol = 2;
INSERT INTO dbo.T1(datacol) VALUES('d');

SELECT * FROM dbo.T1;

--keycol      datacol
------------- ----------
--1           a
--2           d
--3           c

--(3 rows affected)