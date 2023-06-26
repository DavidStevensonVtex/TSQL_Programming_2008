-- Try above code again when table is locked
USE InsideTSQL2008;

BEGIN TRAN
  SELECT * FROM Sales.Orders WITH (TABLOCKX);

-- run above code now, and then rollback to realease the lock
ROLLBACK TRAN
GO