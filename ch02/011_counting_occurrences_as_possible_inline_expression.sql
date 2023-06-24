USE InsideTSQL2008 ;

-- Turn off Discard results after execution

-- Counting Occurrences
DECLARE @find AS NVARCHAR(40);
SET @find = N'n';

SELECT companyname,
  (LEN(companyname+'*') - LEN(REPLACE(companyname, @find, '')+'*'))
    / LEN(@find) AS cnt
FROM Sales.Customers;
GO