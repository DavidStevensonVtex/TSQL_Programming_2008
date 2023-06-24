USE tempdb ;
GO

-- Query sys.sql_expression_dependencies
SELECT
    OBJECT_SCHEMA_NAME(referencing_id) AS srcobjschema,
    OBJECT_NAME(referencing_id) AS srcobjname,
    referencing_minor_id AS srcminorid,
    referenced_schema_name AS tgtschema,
    referenced_id AS tgtobjid,
    referenced_entity_name AS tgtobjname,
    referenced_minor_id AS tgtminorid
FROM sys.sql_expression_dependencies;
