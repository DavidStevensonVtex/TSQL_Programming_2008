-- Add a global variable
SET NOCOUNT ON;
INSERT INTO ##Globals VALUES('var1', CAST('abc' AS VARCHAR(10)));
SELECT * FROM ##Globals;

--varname       val
--------------- ---------
--var1          abc


-- Cleanup
 USE master;
 DROP PROC dbo.CreateGlobals;
 DROP TABLE ##Globals;
 GO
