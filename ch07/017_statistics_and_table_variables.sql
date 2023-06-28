---------------------------------------------------------------------
-- Statistics
---------------------------------------------------------------------

SET NOCOUNT ON ;

-- Table Variable Example
DECLARE @T TABLE
(
  col1 INT NOT NULL PRIMARY KEY,
  col2 INT NOT NULL,
  filler CHAR(200) NOT NULL DEFAULT('a'),
  UNIQUE(col2, col1)
);

INSERT INTO @T(col1, col2)
  SELECT n, (n - 1) % 10000 + 1 FROM dbo.Nums
  WHERE n <= 100000;

SET STATISTICS IO ON ;

SELECT * FROM @T WHERE col1 = 1;
SELECT * FROM @T WHERE col1 <= 50000;

SELECT * FROM @T WHERE col2 = 1;
SELECT * FROM @T WHERE col2 <= 2;
SELECT * FROM @T WHERE col2 <= 5000;

SET STATISTICS IO OFF ;
GO
