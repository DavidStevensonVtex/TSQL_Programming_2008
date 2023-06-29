-- Cursor Code for Custom Aggregate
USE tempdb;
GO

DECLARE
  @Result AS TABLE(groupid VARCHAR(10), product BIGINT);
DECLARE
  @groupid AS VARCHAR(10), @prvgroupid AS VARCHAR(10),
  @val AS INT, @product AS BIGINT;

DECLARE C CURSOR FAST_FORWARD FOR
  SELECT groupid, val FROM dbo.Groups ORDER BY groupid;

OPEN C;

FETCH NEXT FROM C INTO @groupid, @val;
SELECT @prvgroupid = @groupid, @product = 1;

WHILE @@FETCH_STATUS = 0
BEGIN
  IF @groupid <> @prvgroupid
  BEGIN
    INSERT INTO @Result VALUES(@prvgroupid, @product);
    SELECT @prvgroupid = @groupid, @product = 1;
  END

  SET @product = @product * @val;
  
  FETCH NEXT FROM C INTO @groupid, @val;
END

IF @prvgroupid IS NOT NULL
  INSERT INTO @Result VALUES(@prvgroupid, @product);

CLOSE C;

DEALLOCATE C;

SELECT groupid, product FROM @Result;
GO

--groupid    product
------------ --------------------
--a          42
--b          693
--c          960