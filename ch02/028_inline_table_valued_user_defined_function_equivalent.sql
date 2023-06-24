USE tempdb ;

-- Creation Script for Function Subordinates, Inline Version
IF OBJECT_ID('dbo.Subordinates') IS NOT NULL
  DROP FUNCTION dbo.Subordinates;
GO
CREATE FUNCTION dbo.Subordinates(@mgrid AS INT) RETURNS TABLE
AS
RETURN
  WITH Subs
  AS
  (
    -- Anchor member returns a row for the input manager
    SELECT empid, mgrid, empname, salary, 0 AS lvl 
    FROM dbo.Employees
    WHERE empid = @mgrid

    UNION ALL

    -- Recursive member returns next level of children
    SELECT C.empid, C.mgrid, C.empname, C.salary, P.lvl + 1
    FROM Subs AS P
      JOIN dbo.Employees AS C
        ON C.mgrid = P.empid
  )
  SELECT * FROM Subs;
GO