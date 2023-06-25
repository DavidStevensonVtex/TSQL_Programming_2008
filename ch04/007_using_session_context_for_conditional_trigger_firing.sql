USE tempdb; 
GO

-- Using Session Context

-- Generate GUID (only once)
DECLARE @guid AS BINARY(16) ;
--SELECT @guid = CAST(NEWID() AS BINARY(16));
SET @guid = 0x7EDBCEC5E165E749BF1261A655F52C48 ;
SELECT @guid AS GUID ;
GO



-- Stored procedure that sets the signal
IF OBJECT_ID('dbo.TrgSignal_Set', 'P') IS NOT NULL
  DROP PROC dbo.TrgSignal_Set;
GO
CREATE PROC dbo.TrgSignal_Set
  @guid AS BINARY(16),
  @pos  AS INT
AS
	DECLARE @ci AS VARBINARY(128);
	SET @ci = 
	  ISNULL(SUBSTRING(CONTEXT_INFO(), 1, @pos-1),
			 CAST(REPLICATE(0x00, @pos-1) AS VARBINARY(128)))
	  + @guid +
	  ISNULL(SUBSTRING(CONTEXT_INFO(), @pos+16, 128-16-@pos+1), 0x);
	SET CONTEXT_INFO @ci;
GO


-- Stored procedure that clears the signal
IF OBJECT_ID('dbo.TrgSignal_Clear', 'P') IS NOT NULL
  DROP PROC dbo.TrgSignal_Clear;
GO
CREATE PROC dbo.TrgSignal_Clear
  @pos  AS INT
AS
	DECLARE @ci AS VARBINARY(128);
	SET @ci = 
	  ISNULL(SUBSTRING(CONTEXT_INFO(), 1, @pos-1),
			 CAST(REPLICATE(0x00, @pos-1) AS VARBINARY(128)))
	  + CAST(REPLICATE(0x00, 16) AS VARBINARY(128)) +
	  ISNULL(SUBSTRING(CONTEXT_INFO(), @pos+16, 128-16-@pos+1), 0x);
	SET CONTEXT_INFO @ci;
GO

-- Stored procedure that looks for the signal
IF OBJECT_ID('dbo.TrgSignal_Get', 'P') IS NOT NULL
  DROP PROC dbo.TrgSignal_Get;
GO
CREATE PROC dbo.TrgSignal_Get
  @guid AS BINARY(16) OUTPUT,
  @pos  AS INT
AS
	SET @guid = SUBSTRING(CONTEXT_INFO(), @pos, 16);
GO

-- Alter trg_T1_i trigger using session context
ALTER TRIGGER trg_T1_i ON dbo.T1 FOR INSERT
AS
	DECLARE @signal AS BINARY(16);
	EXEC dbo.TrgSignal_Get
	  @guid = @signal OUTPUT,
	  @pos  = 1; 

	IF @signal = 0x7EDBCEC5E165E749BF1261A655F52C48 RETURN;

	PRINT 'trg_T1_i in action...';
GO