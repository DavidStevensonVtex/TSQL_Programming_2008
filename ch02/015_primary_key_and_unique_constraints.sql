USE tempdb ;
GO

---------------------------------------------------------------------
-- PRIMARY KEY and UNIQUE Constraints
---------------------------------------------------------------------

-- Attempt to add computed column with UNIQUE constraint fails
ALTER TABLE dbo.T1
  ADD col1 AS dbo.AddOne(keycol) CONSTRAINT UQ_T1_col1 UNIQUE;
GO