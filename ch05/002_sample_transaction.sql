USE testdb ;
GO

-- Transaction Example
BEGIN TRAN
  INSERT INTO dbo.T1(keycol, col1, col2) VALUES(4, 101, 'C');
  INSERT INTO dbo.T2(keycol, col1, col2) VALUES(4, 201, 'X');
COMMIT TRAN
GO

SELECT * FROM T1 WHERE keycol = 4 ;
SELECT * FROM T2 WHERE keycol = 4 ;
GO

--keycol      col1        col2
------------- ----------- -----
--4           101         C


--keycol      col1        col2
------------- ----------- -----
--4           201         X