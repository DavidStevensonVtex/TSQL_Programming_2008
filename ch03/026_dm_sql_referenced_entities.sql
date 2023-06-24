USE tempdb ;
GO

-- Query sys.dm_sql_referenced_entities
SELECT
    referenced_schema_name AS objschema,
    referenced_entity_name AS objname,
    referenced_minor_name  AS minorname,
    referenced_class_desc  AS class
FROM sys.dm_sql_referenced_entities('dbo.Proc1', 'OBJECT');