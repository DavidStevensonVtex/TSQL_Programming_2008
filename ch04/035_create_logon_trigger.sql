USE master;
GO

-- Create logon trigger that rejects the session if:
-- the login is user1
-- and the login already has an open session
-- and the time is peak time (>= 11:45, < 14:16)
-- and the new session is nonpooled
CREATE TRIGGER trg_logon_con_limit ON ALL SERVER 
  WITH EXECUTE AS 'user1'
  FOR LOGON
AS
BEGIN
IF ORIGINAL_LOGIN()= 'user1'
    AND (SELECT COUNT(*)
         FROM sys.dm_exec_sessions
         WHERE is_user_process = 1
           AND original_login_name = 'user1') > 1
    AND CAST(SYSDATETIME() AS TIME) >= '11:45'
    AND CAST(SYSDATETIME() AS TIME) <  '14:16'
    AND EVENTDATA().value('(/EVENT_INSTANCE/IsPooled)[1]', 'INT') = 0
  ROLLBACK;
END;
GO
