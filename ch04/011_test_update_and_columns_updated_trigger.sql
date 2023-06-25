USE tempdb; 
GO

-- Test trg_T1_u_identify_updated_columns trigger
UPDATE dbo.T1
  SET col4 = 2, col8 = 2, col90 = 2, col6 = 2
WHERE keycol = 1;
GO

--updated_column
--------------------
--col4
--col6
--col8
--col90