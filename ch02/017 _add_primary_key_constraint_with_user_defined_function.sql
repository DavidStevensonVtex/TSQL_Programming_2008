USE tempdb ;

-- Attempt to add computed column with PRIMARY KEY constraint fails
ALTER TABLE dbo.T1
  ADD col2 AS dbo.AddOne(keycol)
    CONSTRAINT PK_T1 PRIMARY KEY;

--Msg 1711, Level 16, State 1, Line 4
--Cannot define PRIMARY KEY constraint on column 'col2' in table 'T1'. The computed column has to be persisted and not nullable.
--Msg 1750, Level 16, State 0, Line 4
--Could not create constraint or index. See previous errors.