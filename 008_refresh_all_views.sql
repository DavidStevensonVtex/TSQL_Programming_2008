-- Refreshing all views in database
SELECT
  N'EXEC sp_refreshview '
    + QUOTENAME(SCHEMA_NAME(schema_id) + N'.' + QUOTENAME(name), '''')
    + ';' AS cmd
FROM sys.views
WHERE OBJECTPROPERTY(object_id, 'IsSchemaBound') = 0;