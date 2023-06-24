USE InsideTSQL2008;
GO

-- Ensure that plan guide was used
SET SHOWPLAN_XML ON;
GO
EXEC dbo.GetOrders;
GO
SET SHOWPLAN_XML OFF;
GO

-- In XML file: PlanGuideDB="InsideTSQL2008" PlanGuideName="PG_GetOrders_Selective"