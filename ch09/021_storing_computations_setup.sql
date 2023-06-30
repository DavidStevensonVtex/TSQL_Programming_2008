---------------------------------------------------------------------
-- Storing Computations
---------------------------------------------------------------------

-- Creating the Computations Table
USE tempdb;

IF OBJECT_ID('dbo.Computations', 'U') IS NOT NULL
  DROP TABLE dbo.Computations;

CREATE TABLE dbo.Computations
(
  keycol      INT            NOT NULL IDENTITY PRIMARY KEY,
  arg1        INT            NULL,
  arg2        INT            NULL,
  arg3        INT            NULL,
  computation VARCHAR(4000) NOT NULL,
  result      INT            NULL,
  CONSTRAINT CHK_Computations_SQL_Injection
    CHECK (REPLACE(computation,'@arg','') NOT LIKE '%[^0-9.+/* -]%')
);
GO