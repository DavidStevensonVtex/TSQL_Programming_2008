-- Check whether plan guide was used
SET SHOWPLAN_XML ON;
GO
EXEC dbo.GetOrders '20080506';
GO
SET SHOWPLAN_XML OFF;

-- PlanGuideDB="InsideTSQL2008" PlanGuideName="PG_GetOrders_Selective"