---------------------------------------------------------------------
-- Order Based Access
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Custom Aggregations
---------------------------------------------------------------------

-- Creating and Populating the Groups Table
USE tempdb;
IF OBJECT_ID('dbo.Groups', 'U') IS NOT NULL DROP TABLE dbo.Groups;

CREATE TABLE dbo.Groups
(
  groupid  VARCHAR(10) NOT NULL,
  memberid INT         NOT NULL,
  string   VARCHAR(10) NOT NULL,
  val      INT         NOT NULL,
  PRIMARY KEY (groupid, memberid)
);
GO
    
INSERT INTO dbo.Groups(groupid, memberid, string, val) VALUES
  ('a', 3, 'stra1',  6),
  ('a', 9, 'stra2',  7),
  ('b', 2, 'strb1',  3),
  ('b', 4, 'strb2',  7),
  ('b', 5, 'strb3',  3),
  ('b', 9, 'strb4', 11),
  ('c', 3, 'strc1',  8),
  ('c', 7, 'strc2', 10),
  ('c', 9, 'strc3', 12);
GO