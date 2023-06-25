---------------------------------------------------------------------
-- Logon Triggers
---------------------------------------------------------------------

-- Create login called user1
USE master;

CREATE LOGIN user1
  WITH PASSWORD = '9500A9BA-E173-4A27-BA4A-B36DCD925877',
       CHECK_EXPIRATION = ON;

GRANT VIEW SERVER STATE TO user1;
GO