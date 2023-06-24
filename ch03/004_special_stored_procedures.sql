---------------------------------------------------------------------
-- Special Stored Procedures
---------------------------------------------------------------------

-- By special stored procedure I mean a stored procedure created with a name beginning with
-- sp_ in the master database. A stored procedure created in this way has a special behavior.

-- Important: Note that Microsoft strong recommends against creating your own stored
-- procedures with the sp_ prefix. The prefi is used by SQL Server to designate system stored
-- procedures. In this section, I will create stored procedures with the sp_ prefix to demonstrate
-- their special behavior.

-- Creating sp_Proc1
USE master;

IF OBJECT_ID('dbo.sp_Proc1', 'P') IS NOT NULL DROP PROC dbo.sp_Proc1;
GO

CREATE PROC dbo.sp_Proc1
AS
    PRINT 'master.dbo.sp_Proc1 executing in ' + DB_NAME();

    -- Dynamic query
    EXEC('SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE = N''BASE TABLE'';');

    -- Static query
    SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE = 'BASE TABLE';
GO