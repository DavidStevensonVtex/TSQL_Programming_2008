USE testdb ;
GO

-- Who changed T1 in the last 24 hours and how?
SELECT posttime, eventtype, loginname, 
  eventdata.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'NVARCHAR(MAX)')
  AS tsqlcommand 
FROM dbo.AuditDDLEvents 
WHERE schemaname = N'dbo' AND N'T1' IN(objectname, targetobjectname) 
  AND posttime > CURRENT_TIMESTAMP - 1 
ORDER BY posttime;
GO

-- posttime                eventtype                                                                                                                        loginname                                                                                                                        tsqlcommand
-- ----------------------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2023-06-25 16:11:33.243 CREATE_TABLE                                                                                                                     DSTEVENSONWIN10\drste                                                                                                            CREATE TABLE dbo.T1(col1 INT NOT NULL PRIMARY KEY)
-- 2023-06-25 16:11:33.300 ALTER_TABLE                                                                                                                      DSTEVENSONWIN10\drste                                                                                                            ALTER TABLE dbo.T1 ADD col2 INT NULL
-- 2023-06-25 16:11:33.310 ALTER_TABLE                                                                                                                      DSTEVENSONWIN10\drste                                                                                                            ALTER TABLE dbo.T1 ALTER COLUMN col2 INT NOT NULL
-- 2023-06-25 16:11:33.313 CREATE_INDEX                                                                                                                     DSTEVENSONWIN10\drste                                                                                                            CREATE NONCLUSTERED INDEX idx1 ON dbo.T1(col2)

-- (4 rows affected)