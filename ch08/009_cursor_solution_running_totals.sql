-- Cursor Code for Running Aggregate
DECLARE @Result AS TABLE
(
  empid  INT,
  dt     DATETIME,
  qty    INT,
  sumqty BIGINT
);

DECLARE
  @empid    AS INT,
  @prvempid AS INT,
  @dt       AS DATETIME,
  @qty      AS INT,
  @sumqty   AS BIGINT;

DECLARE C CURSOR FAST_FORWARD FOR
  SELECT empid, dt, qty
  FROM dbo.Sales
  ORDER BY empid, dt;

OPEN C;

FETCH NEXT FROM C INTO @empid, @dt, @qty;

SELECT @prvempid = @empid, @sumqty = 0;

WHILE @@fetch_status = 0
BEGIN
  IF @empid <> @prvempid
    SELECT @prvempid = @empid, @sumqty = 0;

  SET @sumqty = @sumqty + @qty;

  INSERT INTO @Result VALUES(@empid, @dt, @qty, @sumqty);
  
  FETCH NEXT FROM C INTO @empid, @dt, @qty;
END

CLOSE C;

DEALLOCATE C;

SELECT * FROM @Result;
GO

-- This solution took 4 seconds.