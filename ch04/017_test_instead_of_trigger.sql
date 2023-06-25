USE tempdb ;
GO

-- Test trigger trg_T1_ioi_perrow
INSERT INTO dbo.T1(keycol, datacol) VALUES(5, 50);
GO
--Key: 5 inserted.

INSERT INTO dbo.T1(keycol, datacol) VALUES
  (6, 60), (7, 70), (8, 80);
GO

--Key: 6 inserted.
--Key: 7 inserted.
--Key: 8 inserted.
