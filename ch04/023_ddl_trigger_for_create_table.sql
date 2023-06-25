USE testdb ;
GO

-- Creation Script for trg_create_table_with_pk Trigger
IF EXISTS(  SELECT * 
            FROM sys.triggers
            WHERE parent_class = 0 AND name = 'trg_create_table_with_pk')
    DROP TRIGGER trg_create_table_with_pk  ON DATABASE;
GO

CREATE TRIGGER trg_create_table_with_pk ON DATABASE FOR CREATE_TABLE
AS
    DECLARE @eventdata AS XML, @objectname AS NVARCHAR(257),
        @msg AS NVARCHAR(500);

    SET @eventdata = EVENTDATA();
    SET @objectname = 
        + QUOTENAME(@eventdata.value('(/EVENT_INSTANCE/SchemaName)[1]', 'sysname'))
        + N'.' + 
        QUOTENAME(@eventdata.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'));

    IF COALESCE(OBJECTPROPERTY(OBJECT_ID(@objectname), 'TableHasPrimaryKey'), 0) = 0
    BEGIN
        SET @msg = N'Table ' + @objectname + ' does not contain a primary key.'
            + CHAR(10) + N'Table creation rolled back.';
        RAISERROR(@msg, 16, 1);
        ROLLBACK;
        RETURN;
    END
GO