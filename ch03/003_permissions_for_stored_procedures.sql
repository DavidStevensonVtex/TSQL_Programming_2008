USE InsideTSQL2008 ;

DENY SELECT ON Sales.Shippers TO user1;
GRANT EXECUTE ON dbo.GetSortedShippers TO user1;

-- user1
SELECT shipperid, companyname, phone
FROM Sales.Shippers;