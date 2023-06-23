USE InsideTSQL2008;
GO

-- Try a schema change
ALTER TABLE Sales.Customers DROP COLUMN address;
GO

-- Msg 5074, Level 16, State 1, Line 2
-- The object 'CustsWithOrders' is dependent on column 'address'.
-- Msg 4922, Level 16, State 9, Line 2
-- ALTER TABLE DROP COLUMN address failed because one or more objects access this column.