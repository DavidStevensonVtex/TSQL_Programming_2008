
-- Cursor Code for Max Concurrent Sessions Problem
DECLARE
  @app AS VARCHAR(10), @prevapp AS VARCHAR (10), @ts AS datetime,
  @event_type AS INT, @concurrent AS INT, @mx AS INT;

DECLARE @Result AS TABLE(app VARCHAR(10), mx INT);

DECLARE C CURSOR FAST_FORWARD FOR
  SELECT app, starttime AS ts, 1 AS event_type FROM dbo.Sessions
  UNION ALL
  SELECT app, endtime, -1 FROM dbo.Sessions
  ORDER BY app, ts, event_type;

OPEN C;

FETCH NEXT FROM C INTO @app, @ts, @event_type;
SELECT @prevapp = @app, @concurrent = 0, @mx = 0;

WHILE @@FETCH_STATUS = 0
BEGIN
  IF @app <> @prevapp
  BEGIN
    INSERT INTO @Result VALUES(@prevapp, @mx);
    SELECT @prevapp = @app, @concurrent = 0, @mx = 0;
  END

  SET @concurrent = @concurrent + @event_type;
  IF @concurrent > @mx SET @mx = @concurrent;
  
  FETCH NEXT FROM C INTO @app, @ts, @event_type;
END

IF @prevapp IS NOT NULL
  INSERT INTO @Result VALUES(@prevapp, @mx);

CLOSE C;

DEALLOCATE C;

SELECT * FROM @Result;
GO

--app        mx
------------ -----------
--app1       4
--app2       3