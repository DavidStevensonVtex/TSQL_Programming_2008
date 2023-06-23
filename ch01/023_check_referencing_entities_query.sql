USE InsideTSQL2008;
GO

-- Check which object references the object/column of interest
SELECT referencing_schema_name, referencing_entity_name
FROM sys.dm_sql_referencing_entities('Sales.Customers', 'OBJECT');

SELECT
  OBJECT_SCHEMA_NAME(referencing_id) AS referencing_schema_name,
  OBJECT_NAME(referencing_id) AS referencing_entity_name
FROM sys.sql_expression_dependencies
WHERE referenced_schema_name = N'Sales'
  AND referenced_entity_name = N'Customers'
  AND COL_NAME(referenced_id, referenced_minor_id) = N'address';

--  referencing_schema_name                                                                                                          referencing_entity_name
---------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------
--Sales                                                                                                                            CustsWithOrders

--(1 row affected)

--referencing_schema_name                                                                                                          referencing_entity_name
---------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------
--Sales                                                                                                                            CustsWithOrders

--(1 row affected)