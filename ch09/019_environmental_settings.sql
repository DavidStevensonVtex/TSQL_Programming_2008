---------------------------------------------------------------------
-- Environmental Settings
---------------------------------------------------------------------

-- Changes don't affect outer batch
USE InsideTSQL2008;
DECLARE @db AS NVARCHAR(258) = QUOTENAME(N'tempdb');
EXEC(N'USE ' + @db + ';');
SELECT DB_NAME() AS DatabaseName ;
GO
--DatabaseName
-----------------------
--InsideTSQL2008

-- Changes affect inner batch
USE InsideTSQL2008;
DECLARE @db AS NVARCHAR(258) = QUOTENAME(N'tempdb');
EXEC(N'USE ' + @db + N'; SELECT DB_NAME() AS DatabaseName;');
GO
--DatabaseName
-------------------------
--tempdb

-- Changes affect nested batches
USE InsideTSQL2008;
DECLARE @db AS NVARCHAR(258) = QUOTENAME(N'tempdb');
EXEC(N'USE ' + @db + N'; EXEC(''SELECT DB_NAME() AS DatabaseName;'');');
GO
--DatabaseName
-----------------------
--tempdb
