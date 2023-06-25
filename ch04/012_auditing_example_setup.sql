---------------------------------------------------------------------
-- Auditing Example
---------------------------------------------------------------------

-- Creation Script for the T1 Table and Audit Table
SET NOCOUNT ON; 
USE tempdb; 

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1; 
IF OBJECT_ID('dbo.T1Audit', 'U') IS NOT NULL DROP TABLE dbo.T1Audit; 

CREATE TABLE dbo.T1 
( 
  keycol INT NOT NULL PRIMARY KEY, 
  intcol INT NULL, 
  varcharcol VARCHAR(10) NULL 
); 

CREATE TABLE dbo.T1Audit 
( 
  lsn     INT         NOT NULL IDENTITY PRIMARY KEY, -- log serial number 
  keycol  INT         NOT NULL, 
  colname sysname     NOT NULL, 
  oldval  SQL_VARIANT NULL, 
  newval  SQL_VARIANT NULL 
);
GO

-- Creation Script for the trg_T1_U_Audit Trigger
CREATE TRIGGER trg_T1_u_audit ON dbo.T1 FOR UPDATE
AS
	-- If 0 affected rows, do nothing
	IF NOT EXISTS(SELECT * FROM inserted) RETURN;

	INSERT INTO dbo.T1Audit(keycol, colname, oldval, newval)
	  SELECT *
	  FROM (SELECT I.keycol, colname,
			  CASE colname
				WHEN N'intcol' THEN CAST(D.intcol AS SQL_VARIANT)
				WHEN N'varcharcol' THEN CAST(D.varcharcol AS SQL_VARIANT)
			  END AS oldval,
			  CASE colname
				WHEN N'intcol' THEN CAST(I.intcol AS SQL_VARIANT)
				WHEN N'varcharcol' THEN CAST(I.varcharcol AS SQL_VARIANT)
			  END AS newval
			FROM inserted AS I
			  JOIN deleted AS D
				ON I.keycol = D.keycol
			  CROSS JOIN
				(SELECT N'intcol' AS colname
				 UNION ALL SELECT N'varcharcol') AS C) AS D
	  WHERE oldval <> newval
		 OR oldval IS NULL AND newval IS NOT NULL
		 OR oldval IS NOT NULL AND newval IS NULL;
GO
