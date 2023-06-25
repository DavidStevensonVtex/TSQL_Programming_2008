---------------------------------------------------------------------
-- Plan Freezing
---------------------------------------------------------------------

EXEC dbo.GetOrders '99991231';
GO
DECLARE @plan_handle AS VARBINARY(64), @offset AS INT, @rc AS INT;

SELECT @plan_handle = plan_handle, @offset = statement_start_offset
FROM sys.dm_exec_query_stats AS QS
  CROSS APPLY sys.dm_exec_sql_text(QS.sql_handle) AS ST
  CROSS APPLY sys.dm_exec_query_plan(QS.plan_handle) AS QP
WHERE 
  SUBSTRING(ST.text, (QS.statement_start_offset/2) + 1,
    ((CASE statement_end_offset 
       WHEN -1 THEN DATALENGTH(ST.text)
       ELSE QS.statement_end_offset END 
           - QS.statement_start_offset)/2) + 1
         ) LIKE N'%SELECT orderid, custid, empid, orderdate
/* 33145F87-1109-4959-91D6-F1EC81F8428F */
FROM Sales.Orders
WHERE orderdate >= @odate;%'
  AND ST.text NOT LIKE '%sys%';

SET @rc = @@ROWCOUNT;

IF @rc = 1
  EXEC sp_create_plan_guide_from_handle 
      @name =  N'PG_GetOrders_Selective',
      @plan_handle = @plan_handle,
      @statement_start_offset = @offset;
ELSE
  RAISERROR(
    'Number of matching plans should be 1 but is %d. Plan guide not created.',
    16, 1, @rc);
GO