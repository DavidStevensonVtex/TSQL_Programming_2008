---------------------------------------------------------------------
-- Error Handling with the TRY/CATCH Construct
---------------------------------------------------------------------

---------------------------------------------------------------------
-- TRY/CATCH
---------------------------------------------------------------------

-- Create the testdb Database and the Employees Table
IF DB_ID('testdb') IS NULL
  CREATE DATABASE testdb;
GO
USE testdb;
GO

IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
  DROP TABLE dbo.Employees;
GO
CREATE TABLE dbo.Employees
(
  empid   INT         NOT NULL,
  empname VARCHAR(25) NOT NULL,
  mgrid   INT         NULL,
  CONSTRAINT PK_Employees PRIMARY KEY(empid),
  CONSTRAINT CHK_Employees_empid CHECK(empid > 0),
  CONSTRAINT FK_Employees_Employees
    FOREIGN KEY(mgrid) REFERENCES Employees(empid)
);
GO

-- Run twice
BEGIN TRY
  INSERT INTO dbo.Employees(empid, empname, mgrid)
    VALUES(1, 'Emp1', NULL);
  PRINT 'INSERT succeeded.';
END TRY
BEGIN CATCH
  PRINT 'INSERT failed.';
  /* handle error here */
END CATCH
GO

-- First run:
--(1 row affected)
--INSERT succeeded.

-- Second run:
--(0 rows affected)
--INSERT failed.

SELECT * FROM dbo.Employees ;
--empid       empname                   mgrid
------------- ------------------------- -----------
--1           Emp1                      NULL

--(1 row affected)