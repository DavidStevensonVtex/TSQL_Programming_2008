-- Connection 4
SET NOCOUNT ON;
USE testdb;
GO

-- Connection info
SELECT * FROM sys.dm_exec_connections
WHERE session_id IN(57, 63);

-- Session info (1 session can have multiple connections)
SELECT * FROM sys.dm_exec_sessions
WHERE session_id IN(57, 63);

-- Blocking
SELECT * FROM sys.dm_exec_requests
WHERE blocking_session_id > 0;

-- SQL text
SELECT session_id, text 
FROM sys.dm_exec_connections
  CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle) AS ST 
WHERE session_id IN(57, 63);
GO

session_id  text
----------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
57          BEGIN TRAN
  UPDATE dbo.T1 SET col2 = 'BB' WHERE keycol = 2;
63          
SELECT keycol, col1, col2 FROM dbo.T1;
