---------------------------------------------------------------------
-- EXEC
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Simple EXEC Example
---------------------------------------------------------------------

-- Sample data
USE tempdb;

DECLARE @year AS CHAR(4) = CAST(YEAR(CURRENT_TIMESTAMP) AS CHAR(4));
EXEC('IF OBJECT_ID(''dbo.Orders' + @year + ''', ''U'') IS NOT NULL
  DROP TABLE dbo.Orders' + @year + ';
CREATE TABLE dbo.Orders' + @year + '(orderid INT PRIMARY KEY);');
GO
-- dbo.Orders2023 table created in tempdb database.

-- Query the table representing the current year
DECLARE @year AS CHAR(4) = CAST(YEAR(CURRENT_TIMESTAMP) AS CHAR(4));
EXEC('SELECT orderid FROM dbo.Orders' + @year + ';');
GO
--orderid
-------------

--(0 rows affected)
