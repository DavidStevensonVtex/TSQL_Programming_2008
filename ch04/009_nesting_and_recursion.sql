---------------------------------------------------------------------
-- Nesting and Recursion
---------------------------------------------------------------------

-- Allow trigger recursion
ALTER DATABASE HR SET RECURSIVE_TRIGGERS ON;
GO

-- Create trigger trg_Employees_d
CREATE TRIGGER trg_Employees_d ON dbo.Employees FOR DELETE
AS

IF NOT EXISTS(SELECT * FROM deleted) RETURN; -- recursion termination check

DELETE E
FROM dbo.Employees AS E
  JOIN deleted AS M
    ON E.mgrid = M.empid;
GO