-- Query plan guides
SELECT *
FROM sys.plan_guides
WHERE name = 'PG_GetOrders_Selective';

-- Validate plan guide
BEGIN TRAN
  DROP INDEX Sales.Orders.idx_nc_orderdate;

  SELECT plan_guide_id, msgnum, severity, state, message
  FROM sys.plan_guides
    CROSS APPLY fn_validate_plan_guide(plan_guide_id)
  WHERE name = 'PG_GetOrders_Selective';
ROLLBACK TRAN