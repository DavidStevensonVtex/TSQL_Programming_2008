USE tempdb ;
GO

-- sys.dm_sql_referencing_entities
SELECT
  referencing_schema_name AS objschema,
  referencing_entity_name AS objname,
  referencing_class_desc  AS class
FROM sys.dm_sql_referencing_entities('dbo.T1', 'OBJECT');