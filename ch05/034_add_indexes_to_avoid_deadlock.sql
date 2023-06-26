USE testdb ;
GO

-- Create an index on col1 and rerun the activities
CREATE INDEX idx_col1 ON dbo.T1(col1);
CREATE INDEX idx_col1 ON dbo.T2(col1);
GO