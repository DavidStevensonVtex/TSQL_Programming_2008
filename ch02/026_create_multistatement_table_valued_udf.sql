USE tempdb;

-- Creation Script for Function Subordinates
IF OBJECT_ID('dbo.Subordinates') IS NOT NULL
  DROP FUNCTION dbo.Subordinates;
GO
CREATE FUNCTION dbo.Subordinates(@mgrid AS INT) RETURNS @Subs Table
(
  empid   INT NOT NULL PRIMARY KEY NONCLUSTERED,
  mgrid   INT NULL,
  empname VARCHAR(25) NOT NULL,
  salary  MONEY       NOT NULL,
  lvl     INT NOT NULL,
  UNIQUE CLUSTERED(lvl, empid)
)
AS
BEGIN
  DECLARE @lvl AS INT;
  SET @lvl = 0;                 -- Init level counter with 0

  -- Insert root node to @Subs
  INSERT INTO @Subs(empid, mgrid, empname, salary, lvl)
    SELECT empid, mgrid, empname, salary, @lvl
    FROM dbo.Employees WHERE empid = @mgrid;

  WHILE @@rowcount > 0          -- While prev level had rows
  BEGIN
    SET @lvl = @lvl + 1;        -- Increment level counter

    -- Insert next level of subordinates to @Subs
    INSERT INTO @Subs(empid, mgrid, empname, salary, lvl)
      SELECT C.empid, C.mgrid, C.empname, C.salary, @lvl
      FROM @Subs AS P           -- P = Parent
        JOIN dbo.Employees AS C -- C = Child
          ON P.lvl = @lvl - 1   -- Filter parents from prev level
          AND C.mgrid = P.empid;
  END

  RETURN;
END
GO