---------------------------------------------------------------------
-- Template Plan Guides
---------------------------------------------------------------------

DECLARE @stmt AS NVARCHAR(MAX);
DECLARE @params AS NVARCHAR(MAX);

EXEC sp_get_query_template 
  @querytext = N'SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderdate >= ''99991231'';',
  @templatetext  = @stmt OUTPUT, 
  @parameters  = @params OUTPUT;

SELECT @stmt AS stmt, @params AS params;
GO

--stmt                                                                                        params
--------------------------------------------------------------------------------------------- ------------------
--select orderid , custid , empid , orderdate from Sales . Orders where orderdate > = @0      @0 varchar(8000)

--(1 row affected)