USE tempdb ;

-- Attempt succeeds
ALTER TABLE dbo.T1
  ADD col2 AS dbo.AddOne(keycol) PERSISTED NOT NULL
    CONSTRAINT PK_T1 PRIMARY KEY;