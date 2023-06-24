-- Create template plan guide to use forced parameterization
DECLARE @stmt AS NVARCHAR(MAX);
DECLARE @params AS NVARCHAR(MAX);

EXEC sp_get_query_template 
  @querytext = N'SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderdate >= ''99991231'';',
  @templatetext  = @stmt OUTPUT, 
  @parameters  = @params OUTPUT;

SELECT @stmt AS stmt, @params AS params ;

--stmt                                                                                     params
------------------------------------------------------------------------------------------ -----------------
--select orderid , custid , empid , orderdate from Sales . Orders where orderdate > = @0   @0 varchar(8000)

--(1 row affected)

EXEC sp_create_plan_guide 
  @name = N'PG_MyQuery2_ParameterizationForced', 
  @stmt = @stmt, 
  @type = N'TEMPLATE', 
  @module_or_batch = NULL, 
  @params = @params, 
  @hints = N'OPTION(PARAMETERIZATION FORCED)';

-- Create a SQL plan guide on the query template
EXEC sp_create_plan_guide
  @name = N'PG_MyQuery2_Selective', 
  @stmt = @stmt, 
  @type = N'SQL', 
  @module_or_batch = NULL, 
  @params = @params, 
  @hints = N'OPTION(OPTIMIZE FOR (@0 = ''99991231''))';
GO
