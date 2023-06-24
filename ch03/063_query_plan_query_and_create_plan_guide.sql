EXEC dbo.GetOrders '99991231';
GO

DECLARE @query_plan AS NVARCHAR(MAX);
SET @query_plan = CAST(
  (SELECT query_plan
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
     AND ST.text NOT LIKE '%sys%') AS NVARCHAR(MAX));

SELECT @query_plan as query_plan ;

EXEC sp_create_plan_guide
  @name = N'PG_GetOrders_Selective',
  @stmt = N'SELECT orderid, custid, empid, orderdate
/* 33145F87-1109-4959-91D6-F1EC81F8428F */
FROM Sales.Orders
WHERE orderdate >= @odate;',
  @type = N'OBJECT',
  @module_or_batch = N'dbo.GetOrders',
  @hints = @query_plan;
GO