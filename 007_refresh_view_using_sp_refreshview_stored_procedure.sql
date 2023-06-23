USE tempdb ;
GO

-- Refresh View Metadata
EXEC sp_refreshview 'dbo.V1';

-- Query V1, Notice 3 Columns
SELECT * FROM dbo.V1;

--col1        col2        col3
------------- ----------- -----------
--1           2           NULL

--(1 row affected)