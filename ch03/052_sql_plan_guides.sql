---------------------------------------------------------------------
-- SQL Plan Guides
---------------------------------------------------------------------

SELECT empid, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY empid;

-- Create guide
EXEC sp_create_plan_guide 
  @name = N'PG_MyQuery1_MAXDOP1', 
  @stmt = N'SELECT empid, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY empid;
',
  @type = N'SQL',
  @module_or_batch = NULL, 
  @hints = N'OPTION (MAXDOP 1)';

  -- search xml document for PlanGuideDB="InsideTSQL2008" PlanGuideName="PG_MyQuery1_MAXDOP1"