---------------------------------------------------------------------
-- Running Aggregations
---------------------------------------------------------------------

-- Creating and Populating the Sales Table
SET NOCOUNT ON;
IF DB_ID('CLRUtilities') IS NULL CREATE DATABASE CLRUtilities;
GO
USE CLRUtilities;

IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL DROP TABLE dbo.Sales;

CREATE TABLE dbo.Sales
(
  empid INT      NOT NULL,                -- partitioning column
  dt    DATETIME NOT NULL,                -- ordering column
  qty   INT      NOT NULL DEFAULT (1),    -- measure 1
  val   MONEY    NOT NULL DEFAULT (1.00), -- measure 2
  CONSTRAINT PK_Sales PRIMARY KEY(empid, dt)
);
GO

DECLARE
  @num_partitions     AS INT,
  @rows_per_partition AS INT,
  @start_dt           AS DATETIME;

SET @num_partitions     = 10000;
SET @rows_per_partition = 10;
SET @start_dt = '20090101';

TRUNCATE TABLE dbo.Sales;

INSERT INTO dbo.Sales WITH (TABLOCK) (empid, dt)
  SELECT NP.n AS empid, DATEADD(day, RPP.n - 1, @start_dt) AS dt
  FROM InsideTSQL2008.dbo.Nums AS NP
    CROSS JOIN InsideTSQL2008.dbo.Nums AS RPP
WHERE NP.n <= @num_partitions
  AND RPP.n <= @rows_per_partition;
GO
