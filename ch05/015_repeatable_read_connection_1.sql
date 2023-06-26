USE testdb ;
GO

---------------------------------------------------------------------
-- Repeatable Read
---------------------------------------------------------------------

-- Processes working with the repeatable read islation level also request a shared lock
-- when reading data, meaning that dirty reads cannot occur at this level. But unlike with 
-- read committed, at the repeatable read level transactions keep shared locks until they
-- are terminated. You are guaranteed to get repeatable reads (consistent analysis) because
-- no other process is able to obtain an exclusive lock in between your reads.

-- Lost updates cannot happen at this level as well. Although lost updates cannot happen
-- in repeatable read, phantoms are still possible.

-- Note that using repeatable read isolation is not the only way to prevent lost updates. You
-- can work under the read committed isolation level and specify UPDLOCK in situations that
-- can potentially result in lost updates.

-- Connection 1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2 
-----------
--Version 1

-- Connection 1
 --SELECT col2 FROM dbo.T1 WHERE keycol = 2;
 --COMMIT TRAN
 --GO

 --col2 
-----------
--Version 1