---------------------------------------------------------------------
-- Temporary Tables
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Local
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Name, Scope/Visibility
---------------------------------------------------------------------
CREATE TABLE #T1(col1 INT);
SELECT name FROM tempdb.sys.objects WHERE name LIKE '#T1%';
DROP TABLE #T1;
GO


--name
----------------------------------------------------------------------------------------------------------------------------------
--#T1_________________________________________________________________________________________________________________000000000020

--(1 row affected)