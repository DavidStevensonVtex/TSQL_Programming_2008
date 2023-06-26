USE testdb ;
GO

---------------------------------------------------------------------
-- Isolation Levels
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Read Uncommitted
---------------------------------------------------------------------

--Of course, at this level readers might get uncommitted changes. In 
--other words, dirty reads can happen, as well as all other concurrency
--related problems.

--Read uncommitted is the worst isolation level in terms of consistency
--but the best in terms on concurrency.

--As a reminder, the NOLOCK table hint is just a synonym to the 
--READ UNCOMMITTED hint.

-- First initialize the data
UPDATE dbo.T1 SET col2 = 'Version 1' WHERE keycol = 2;

SELECT * FROM dbo.T1 ;

--keycol      col1        col2
------------- ----------- --------------------------------------------------
--1           101         A
--2           102         Version 1
--3           103         C
--4           101         C