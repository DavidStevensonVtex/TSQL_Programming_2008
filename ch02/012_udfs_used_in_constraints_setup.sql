USE tempdb ;
GO

---------------------------------------------------------------------
-- UDFs Used in Constraints
---------------------------------------------------------------------

-- You can use scalar UDFs in constraints. The following sections discuss 
-- and demonstrate how you can use UDFs in DEFAULT, CHECK, PRIMARY KEY,
-- and UNIQUE constraints.

---------------------------------------------------------------------
-- DEFAULT Constraints
---------------------------------------------------------------------

-- You can use scalar UDFs in DEFAULT constraints. The only limitation that
-- you should e aware of is that a UDF cannot accept columns from the table 
-- as inputs when used in a DEFAULT constraint.

-- Creating Table T1 and UDF T1_getkey
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;

CREATE TABLE dbo.T1
(
  keycol INT NOT NULL CONSTRAINT PK_T1 PRIMARY KEY CHECK (keycol > 0),
  datacol VARCHAR(10) NOT NULL
);

IF OBJECT_ID('dbo.T1_getkey', 'FN') IS NOT NULL
  DROP FUNCTION dbo.T1_getkey;
GO
CREATE FUNCTION dbo.T1_getkey() RETURNS INT
AS
BEGIN
  RETURN
    CASE
      WHEN NOT EXISTS(SELECT * FROM dbo.T1 WHERE keycol = 1) THEN 1
      ELSE (SELECT MIN(keycol + 1)
            FROM dbo.T1 AS A
            WHERE NOT EXISTS
              (SELECT *
               FROM dbo.T1 AS B
               WHERE B.keycol = A.keycol + 1))
    END;
END
GO
