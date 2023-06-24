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

-- Such use of table types as the type for table variables prevents you from the need 
-- to repeat the table definition. Of course, it's not just about code brevity. The
-- real news in supporting table types is that you can use those as types for input
-- parameters in stored procedures and UDFs. Client APIs were also enhanced to support
-- passing table-valued parameters to routines, so you are not restricted to using T-SQL
-- to invoke such routines.

-- Note that when defining a table-valued parameter in a routine, you have to specify the
-- attribute READONLY, indicating that you can only read from the parameter but not write to
-- it. For now, this attribute is mandatory.