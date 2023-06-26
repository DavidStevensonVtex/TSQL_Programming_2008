USE testdb ;
GO

-- Connection 1
SET NOCOUNT ON;
USE testdb;
GO
BEGIN TRAN
  UPDATE dbo.T1 SET col2 = 'Version 2' WHERE keycol = 2;
  SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO
--col2
----------------------------------------------------
--Version 2

-- Check row versions
SELECT * FROM sys.dm_tran_version_store;
GO

--transaction_sequence_num version_sequence_num database_id rowset_id            status min_length_in_bytes record_length_first_part_in_bytes record_image_first_part                                                                                                                                                                                                                                            record_length_second_part_in_bytes record_image_second_part
-------------------------- -------------------- ----------- -------------------- ------ ------------------- --------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4415                     1                    13          72057594046251008    0      12                  28                                0x30000C00020000006600000003000001001C0056657273696F6E2031                 

-- Connection 1
COMMIT TRAN
SELECT col2 FROM dbo.T1 WHERE keycol = 2;
GO

--col2
----------------------------------------------------
--Version 2