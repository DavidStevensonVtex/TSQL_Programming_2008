USE testdb ;
GO

---------------------------------------------------------------------
-- Serializable
---------------------------------------------------------------------

-- The serializable isolation level is similar to repeatable read, with an additional facet: active
-- transactions acquire key-range locks (placed on indexes) based on query filters. This applies 
-- not only to readers, but also to writers. Obtaining a key-range lock is as if you logically lock
-- all data that meets the query's filter. You not only lock whatever data is physically found 
-- when you accessed it, but you also lock data that does not exist yet that would happen to meet
-- your query's filter.  This level adds the prevention of phantoms to the list of problems
-- repeatable read handles.

-- Note that if there's no index on the filtered column, SQL Server has to lock the whole table to 
-- prevent phantoms. Missing indexes can have a big impact on the concurrency of the system. 
-- Therefore, pay extra attention to index design when working with the serialization isolation level.

-- Under the serializable isolation level, you will not encounter read consistency problems from 
-- index key changes. 

CREATE INDEX idx_col1 ON dbo.T1(col1);
GO

-- Connection 1
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN
  SELECT *
  FROM dbo.T1
  WHERE col1 = 102;
GO


--keycol      col1        col2
------------- ----------- --------------------------------------------------
--2           102         Version 1

-- Connection 1
   SELECT *
   FROM dbo.T1
   WHERE col1 = 102;
 COMMIT TRAN;
 GO


-- keycol      col1        col2
------------- ----------- --------------------------------------------------
--2           102         Version 1


-- In all connections issue:
 --SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
 --GO