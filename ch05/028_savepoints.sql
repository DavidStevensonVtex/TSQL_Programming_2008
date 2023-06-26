---------------------------------------------------------------------
-- Savepoints
---------------------------------------------------------------------

-- Seuence Table
USE tempdb;
IF OBJECT_ID('dbo.Sequence', 'U') IS NOT NULL DROP TABLE dbo.Sequence;
CREATE TABLE dbo.Sequence(val INT IDENTITY);
GO

-- Sequence Proc
IF OBJECT_ID('dbo.GetSequence', 'P') IS NOT NULL
  DROP PROC dbo.GetSequence;
GO

CREATE PROC dbo.GetSequence
  @val AS INT OUTPUT
AS
    BEGIN TRAN
        SAVE TRAN S1;
        INSERT INTO dbo.Sequence DEFAULT VALUES;
        SET @val = SCOPE_IDENTITY()
        ROLLBACK TRAN S1;
    COMMIT TRAN
GO

