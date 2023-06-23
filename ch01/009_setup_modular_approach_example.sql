---------------------------------------------------------------------
-- Modular Approach
---------------------------------------------------------------------

-- Grouping Consecutive Months with the Same Trend

-- Creating and Populating the Sales Table
SET NOCOUNT ON;
USE tempdb;
IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL DROP TABLE dbo.Sales;
GO

CREATE TABLE dbo.Sales
(
  mnth DATE NOT NULL PRIMARY KEY, 
/* Note: The DATE type is new in SQL Server 2008.
   In earlier versions use DATETIME. */
  qty  INT  NOT NULL
);

INSERT INTO dbo.Sales(mnth, qty) VALUES
/* Note: Table Value Constructor (enhanced VALUES clause) is new 
   in SQL Server 2008. In earlier versions use a separate 
   INSERT VALUES statement for each row. */
  ('20071201', 100),
  ('20080101', 110),
  ('20080201', 120),
  ('20080301', 130),
  ('20080401', 140),
  ('20080501', 140),
  ('20080601', 130),
  ('20080701', 120),
  ('20080801', 110),
  ('20080901', 100),
  ('20081001', 110),
  ('20081101', 100),
  ('20081201', 120),
  ('20090101', 130),
  ('20090201', 140),
  ('20090301', 100),
  ('20090401', 100),
  ('20090501', 100),
  ('20090601', 110),
  ('20090701', 120),
  ('20090801', 110),
  ('20090901', 120),
  ('20091001', 130),
  ('20091101', 140),
  ('20091201', 100);
GO