---------------------------------------------------------------------
-- Locks and Blocking
---------------------------------------------------------------------

-- Connection 3
SET NOCOUNT ON;
USE testdb;
GO

-- Lock info
SELECT
  request_session_id            AS spid,
  resource_type                 AS restype,
  resource_database_id          AS dbid,
  resource_description          AS res,
  resource_associated_entity_id AS resid,
  request_mode                  AS mode,
  request_status                AS status
FROM sys.dm_tran_locks;

--spid        restype                                                      dbid        res                                                                                                                                                                                                                                                              resid                mode                                                         status
------------- ------------------------------------------------------------ ----------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------- ------------------------------------------------------------ ------------------------------------------------------------
--66          DATABASE                                                     13                                                                                                                                                                                                                                                                           0                    S                                                            GRANT
--65          DATABASE                                                     13                                                                                                                                                                                                                                                                           0                    S                                                            GRANT
--63          DATABASE                                                     13                                                                                                                                                                                                                                                                           0                    S                                                            GRANT
--57          DATABASE                                                     13                                                                                                                                                                                                                                                                           0                    S                                                            GRANT
--63          PAGE                                                         13          1:536                                                                                                                                                                                                                                                            72057594046251008    IS                                                           GRANT
--57          PAGE                                                         13          1:536                                                                                                                                                                                                                                                            72057594046251008    IX                                                           GRANT
--57          KEY                                                          13          (61a06abd401c)                                                                                                                                                                                                                                                   72057594046251008    X                                                            GRANT
--63          KEY                                                          13          (61a06abd401c)                                                                                                                                                                                                                                                   72057594046251008    S                                                            WAIT
--63          OBJECT                                                       13                                                                                                                                                                                                                                                                           1189579276           IS                                                           GRANT
--57          OBJECT                                                       13                                                                                                                                                                                                                                                                           1189579276           IX                                                           GRANT
