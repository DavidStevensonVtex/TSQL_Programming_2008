USE tempdb ;
GO
-- Load data to T1
INSERT INTO dbo.T1(keycol, intcol, varcharcol) VALUES
  (1, 10, 'A'), (2, 20, 'B'), (3, 30, 'C');
go
--keycol      intcol      varcharcol
------------- ----------- ----------
--1           10          A
--2           20          B
--3           30          C

-- Update data in T1
UPDATE dbo.T1
  SET varcharcol = varcharcol + 'X',
      intcol = 40 - intcol
WHERE keycol < 3;
GO

--lsn         keycol      colname                                                                                                                          oldval                                                                                                                                                                                                                                                           newval
------------- ----------- -------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1           2           varcharcol                                                                                                                       B                                                                                                                                                                                                                                                                BX
--2           1           intcol                                                                                                                           10                                                                                                                                                                                                                                                               30
--3           1           varcharcol                                                                                                                       A                                                                                                                                                                                                                                                                AX

--(3 rows affected)

-- Query T1 and the audit Table
SELECT * FROM dbo.T1;
SELECT * FROM dbo.T1Audit;
GO
