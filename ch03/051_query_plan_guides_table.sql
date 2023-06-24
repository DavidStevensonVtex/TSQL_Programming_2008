-- Query plan guides
SELECT * FROM sys.plan_guides;

EXEC sp_control_plan_guide N'DROP', N'PG_GetOrders_Selective';
GO