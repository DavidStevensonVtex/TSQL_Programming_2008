-- Mark the proc for recompile
EXEC sp_recompile 'dbo.TestCaching';

-- Query temporary objects, should get no output
SELECT name FROM tempdb.sys.objects WHERE name LIKE '#%';

--Object 'dbo.TestCaching' was successfully marked for recompilation.
--name
------------------------------------------

--(0 rows affected)