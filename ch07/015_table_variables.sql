---------------------------------------------------------------------
-- Table Variables
---------------------------------------------------------------------

-- Creating a table variable
DECLARE @T1 TABLE(col1 INT);
INSERT @T1 VALUES(1);
SELECT * FROM @T1;
GO

--col1
-------------
--1