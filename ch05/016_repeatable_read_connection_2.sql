USE testdb ;
GO

---------------------------------------------------------------------
-- Repeatable Read
---------------------------------------------------------------------

-- Connection 2
UPDATE dbo.T1 SET col2 = 'Version 2' WHERE keycol = 2;
SELECT * FROM dbo.T1 WHERE keycol = 2 ;
GO

-- After the Commit in Connection 1
--keycol      col1        col2
------------- ----------- --------------------------------------------------
--2           102         Version 2

SELECT * FROM dbo.T1 WHERE keycol = 2 ;
GO

--keycol      col1        col2
------------- ----------- --------------------------------------------------
--2           102         Version 2

-- Cleanup
 --UPDATE dbo.T1 SET col2 = 'Version 1' WHERE keycol = 2;
 --GO
