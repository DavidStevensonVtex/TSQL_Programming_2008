-- Ensure that plan guide was used
SET SHOWPLAN_XML ON;
GO
SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderdate >= '20060101';
GO
SET SHOWPLAN_XML OFF;
GO

-- TemplatePlanGuideName="PG_MyQuery2_ParameterizationForced" PlanGuideDB="InsideTSQL2008" PlanGuideName="PG_MyQuery2_Selective" 