---------------------------------------------------------------------
-- Automatic Handling of Sequences
---------------------------------------------------------------------

-- Create Table T1
SET NOCOUNT ON; 
USE tempdb; 

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1; 
CREATE TABLE dbo.T1 
( 
  keycol  INT NOT NULL PRIMARY KEY, 
  datacol VARCHAR(10) NOT NULL 
);
GO

-- Create sequence
IF OBJECT_ID('dbo.Sequence', 'U') IS NOT NULL
  DROP TABLE dbo.Sequence;
GO
CREATE TABLE dbo.Sequence(val INT NOT NULL);
INSERT INTO dbo.Sequence VALUES(0);
GO

-- Trigger generating keys
CREATE TRIGGER trg_T1_ioi_assign_key ON dbo.T1 INSTEAD OF INSERT
AS
	DECLARE
	  @rc  AS INT = (SELECT COUNT(*) FROM inserted),
	  @key AS INT;

	IF @rc = 0 RETURN; -- if 0 affected rows, exit

	-- Update sequence
	UPDATE dbo.Sequence SET @key = val, val = val + @rc;

	INSERT INTO dbo.T1(keycol, datacol)
	  SELECT @key + ROW_NUMBER() OVER(ORDER BY (SELECT 0)), datacol
	  FROM inserted;
GO