USE tempdb;
GO

-- Add Column to T1
ALTER TABLE dbo.T1 ADD col3 INT;

-- Query V1, Notice Still 2 Columns
SELECT * FROM dbo.V1;

--col1        col2
------------- -----------
--1           2

--(1 row affected)

--When you create a view, SQL Server stores metadata information describing the view, its
--columns, security, dependencies, and so on. Schema changes in underlying objects are not
--reflected in the view's metadata information. After applying such schema changes, it's a 
--good practice to refresh the view's metadata information using the sp_refreshview stored 
--procedure so that the changes are reflected in the view.