USE testdb ;
GO

-- Test trigger trg_create_table_with_pk
IF OBJECT_ID('dbo.T', 'U') IS NOT NULL DROP TABLE dbo.T;
GO

CREATE TABLE dbo.T(col1 INT NOT NULL);
GO
--Msg 50000, Level 16, State 1, Procedure trg_create_table_with_pk, Line 17 [Batch Start Line 6]
--Table [dbo].[T] does not contain a primary key.
--Table creation rolled back.
--Msg 3609, Level 16, State 2, Line 8
--The transaction ended in the trigger. The batch has been aborted.

CREATE TABLE dbo.T(col1 INT NOT NULL PRIMARY KEY);
GO