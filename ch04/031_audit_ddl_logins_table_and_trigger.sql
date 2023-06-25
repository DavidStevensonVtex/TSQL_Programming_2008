-- Creation Script for AuditDDLLogins Table and trg_audit_ddl_logins Trigger
USE master;

IF OBJECT_ID('dbo.AuditDDLLogins', 'U') IS NOT NULL
  DROP TABLE dbo.AuditDDLLogins;

CREATE TABLE dbo.AuditDDLLogins
(
    lsn              INT      NOT NULL IDENTITY,
    posttime         DATETIME NOT NULL,
    eventtype        sysname  NOT NULL,
    loginname        sysname  NOT NULL,
    objectname       sysname  NOT NULL,
    logintype        sysname  NOT NULL,
    eventdata        XML      NOT NULL,
    CONSTRAINT PK_AuditDDLLogins PRIMARY KEY(lsn)
);
GO

IF EXISTS(SELECT * FROM sys.server_triggers
          WHERE name = 'trg_audit_ddl_logins')
  DROP TRIGGER trg_audit_ddl_logins ON ALL SERVER;
GO
CREATE TRIGGER trg_audit_ddl_logins ON ALL SERVER
  FOR DDL_LOGIN_EVENTS
AS
    DECLARE @eventdata AS XML = EVENTDATA();

    INSERT INTO master.dbo.AuditDDLLogins(
        posttime, eventtype, loginname,
        objectname, logintype, eventdata)
    VALUES(
        @eventdata.value('(/EVENT_INSTANCE/PostTime)[1]',   'VARCHAR(23)'),
        @eventdata.value('(/EVENT_INSTANCE/EventType)[1]',  'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/LoginName)[1]',  'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/LoginType)[1]',  'sysname'),
        @eventdata);
GO