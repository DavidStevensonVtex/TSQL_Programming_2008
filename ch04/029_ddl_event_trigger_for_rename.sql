USE testdb ;
GO

-- Rename event
IF EXISTS(SELECT * FROM sys.triggers
          WHERE parent_class = 0 AND name = 'trg_rename')
  DROP TRIGGER trg_audit_ddl_events  ON DATABASE;
GO
CREATE TRIGGER trg_rename ON DATABASE FOR RENAME
AS
    DECLARE @eventdata AS XML = EVENTDATA();

    DECLARE
    @SchemaName       AS SYSNAME =
        @eventdata.value('(/EVENT_INSTANCE/SchemaName)[1]', 'sysname'),
    @TargetObjectName AS SYSNAME =
        @eventdata.value('(/EVENT_INSTANCE/TargetObjectName)[1]', 'sysname'),
    @ObjectName       AS SYSNAME =
        @eventdata.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
    @NewObjectName    AS SYSNAME =
        @eventdata.value('(/EVENT_INSTANCE/NewObjectName)[1]', 'sysname');

    DECLARE @msg AS NVARCHAR(1000) = N'RENAME event occurred.
    SchemaName      : ' + @SchemaName + N'
    TargetObjectName: ' + @TargetObjectName + N'
    ObjectName      : ' + @ObjectName + N'
    NewObjectName   : ' + @NewObjectName;

    PRINT @msg;
GO