USE testdb ;
GO

IF EXISTS(  SELECT * 
            FROM sys.triggers
            WHERE parent_class = 0 AND name = 'trg_audit_ddl_events')
    DROP TRIGGER trg_audit_ddl_events  ON DATABASE;
GO

-- Creation Script for AuditDDLEvents Table and trg_audit_ddl_events Trigger
IF OBJECT_ID('dbo.AuditDDLEvents', 'U') IS NOT NULL
  DROP TABLE dbo.AuditDDLEvents;
GO

CREATE TABLE dbo.AuditDDLEvents
(
    lsn              INT      NOT NULL IDENTITY,
    posttime         DATETIME NOT NULL,
    eventtype        sysname  NOT NULL,
    loginname        sysname  NOT NULL,
    schemaname       sysname  NOT NULL,
    objectname       sysname  NOT NULL,
    targetobjectname sysname  NULL,
    eventdata        XML      NOT NULL,
    CONSTRAINT PK_AuditDDLEvents PRIMARY KEY(lsn)
);
GO



CREATE TRIGGER trg_audit_ddl_events ON DATABASE FOR DDL_DATABASE_LEVEL_EVENTS
AS
    DECLARE @eventdata AS XML;
    SET @eventdata = EVENTDATA();

    INSERT INTO dbo.AuditDDLEvents(
        posttime, eventtype, loginname, schemaname, 
        objectname, targetobjectname, eventdata)
    VALUES(
        @eventdata.value('(/EVENT_INSTANCE/PostTime)[1]',         'VARCHAR(23)'),
        @eventdata.value('(/EVENT_INSTANCE/EventType)[1]',        'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/LoginName)[1]',        'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/SchemaName)[1]',       'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/ObjectName)[1]',       'sysname'),
        @eventdata.value('(/EVENT_INSTANCE/TargetObjectName)[1]', 'sysname'),
        @eventdata);
GO