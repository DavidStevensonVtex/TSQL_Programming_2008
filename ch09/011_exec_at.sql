---------------------------------------------------------------------
-- EXEC AT
---------------------------------------------------------------------

-- Create a linked server
--EXEC sp_addlinkedserver [Dojo], 'SQL Server';
--GO

-- Using constant
EXEC
(
 'SELECT productid, productname, unitprice
FROM InsideTSQL2008.Production.Products
WHERE ProductID = ?;', 3
) AT [DSTEVENSONWIN10\SQL_2019];
GO

--productid   productname                              unitprice
------------- ---------------------------------------- ---------------------
--3           Product IMEHJ                            10.00


-- Using variable
DECLARE @pid AS INT;
SET @pid = 3;
EXEC
(
 'SELECT productid, productname, unitprice
FROM InsideTSQL2008.Production.Products
WHERE ProductID = ?;', @pid
) AT [DSTEVENSONWIN10\SQL_2019];
GO
--productid   productname                              unitprice
------------- ---------------------------------------- ---------------------
--3           Product IMEHJ                            10.00

-- Using variables for both text and input
DECLARE @sql AS NVARCHAR(500), @pid AS INT;

SET @sql = 
 'SELECT productid, productname, unitprice
FROM InsideTSQL2008.Production.Products
WHERE ProductID = ?;'
SET @pid = 3;

EXEC(@sql, @pid) AT [DSTEVENSONWIN10\SQL_2019];
GO

--productid   productname                              unitprice
------------- ---------------------------------------- ---------------------
--3           Product IMEHJ                            10.00