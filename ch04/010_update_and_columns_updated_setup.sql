---------------------------------------------------------------------
-- UPDATE and COLUMNS_UPDATED
---------------------------------------------------------------------

-- Create the Table T1 with 100 Columns
USE tempdb; 
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1; 
GO 
 
DECLARE @cmd AS NVARCHAR(4000), @i AS INT; 
 
SET @cmd = 
  N'CREATE TABLE dbo.T1(keycol INT NOT NULL IDENTITY PRIMARY KEY'; 
 
SET @i = 1; 
WHILE @i <= 100 
BEGIN 
  SET @cmd = 
    @cmd + N',col' + CAST(@i AS nvarchar(10)) + 
    N' INT NOT NULL DEFAULT 0'; 
  SET @i = @i + 1; 
END 
 
SET @cmd = @cmd + N');' 
 
EXEC sp_executesql @cmd; 
 
INSERT INTO dbo.T1 DEFAULT VALUES; 
 
SELECT * FROM T1;
GO


-- Trigger That Identifies Which Columns Were Updated
CREATE TRIGGER trg_T1_u_identify_updated_columns ON dbo.T1 FOR UPDATE 
AS 
SET NOCOUNT ON; 

DECLARE @parent_object_id AS INT = 
  (SELECT parent_object_id
   FROM sys.objects
   WHERE object_id = @@PROCID);

WITH UpdatedColumns(column_id) AS
(
  SELECT n
  FROM dbo.Nums
  WHERE n <=
    -- retrieve maximum column ID in trigger's parent table
    (SELECT MAX(column_id) 
     FROM sys.columns
     WHERE object_id = @parent_object_id)
    -- bit corresponding to nth column is turned on
    AND (SUBSTRING(COLUMNS_UPDATED(),(n - 1) / 8 + 1, 1)) 
         & POWER(2, (n - 1) % 8) > 0
)
SELECT C.name AS updated_column
FROM sys.columns AS C
  JOIN UpdatedColumns AS U
    ON C.column_id = U.column_id
WHERE object_id = @parent_object_id
ORDER BY U.column_id; 
GO