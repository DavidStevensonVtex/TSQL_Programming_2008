USE tempdb; 

-- Test trigger
INSERT INTO dbo.T1(datacol)
  VALUES('G'),('U'),('I'),('N'),('N'),('E'),('S'),('S');

SELECT keycol, datacol FROM dbo.T1;
GO

--keycol      datacol
------------- ----------
--1           G
--2           U
--3           I
--4           N
--5           N
--6           E
--7           S
--8           S