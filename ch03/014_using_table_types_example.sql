USE InsideTSQL2008;

-- Use table type with table variable
DECLARE @T AS dbo.OrderIDs;

INSERT INTO @T(pos, orderid)
  VALUES(1, 10248),(2, 10250),(3, 10249);

SELECT * FROM @T ORDER BY pos ;
GO

--pos         orderid
------------- -----------
--1           10248
--2           10250
--3           10249

--(3 rows affected)