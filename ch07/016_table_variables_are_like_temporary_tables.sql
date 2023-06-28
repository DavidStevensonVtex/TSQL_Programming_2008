---------------------------------------------------------------------
-- tempdb
---------------------------------------------------------------------
SELECT TABLE_NAME
FROM tempdb.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '#%';
GO
DECLARE @T TABLE(col1 INT);

INSERT INTO @T VALUES(1);

SELECT TABLE_NAME
FROM tempdb.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '#%';
GO

--TABLE_NAME
---------------
--#A5B907FC