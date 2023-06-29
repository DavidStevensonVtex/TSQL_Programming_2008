-- Cursor Code for Matching Problem (guaranteed solution)
DECLARE
  @roomid AS VARCHAR(10), @seats AS INT,
  @eventid AS INT, @attendees AS INT;

DECLARE @Result AS TABLE(roomid  VARCHAR(10), eventid INT);

DECLARE CRooms CURSOR FAST_FORWARD FOR
  SELECT roomid, seats FROM dbo.Rooms
  ORDER BY seats, roomid;
DECLARE CEvents CURSOR FAST_FORWARD FOR
  SELECT eventid, attendees FROM dbo.Events
  ORDER BY attendees, eventid;

OPEN CRooms;
OPEN CEvents;

FETCH NEXT FROM CEvents INTO @eventid, @attendees;
WHILE @@FETCH_STATUS = 0
BEGIN
  FETCH NEXT FROM CRooms INTO @roomid, @seats;

  WHILE @@FETCH_STATUS = 0 AND @seats < @attendees
    FETCH NEXT FROM CRooms INTO @roomid, @seats;

  IF @@FETCH_STATUS = 0
    INSERT INTO @Result(roomid, eventid) VALUES(@roomid, @eventid);
  ELSE
  BEGIN
    RAISERROR('Not enough rooms for events.', 16, 1);
    BREAK;
  END

  FETCH NEXT FROM CEvents INTO @eventid, @attendees;
END

CLOSE CRooms;
CLOSE CEvents;

DEALLOCATE CRooms;
DEALLOCATE CEvents;

SELECT result.roomid, result.eventid, rooms.seats, events.attendees
FROM @Result result
	INNER JOIN dbo.Rooms rooms
		ON result.roomid = rooms.roomid
	INNER JOIN dbo.Events events
		ON result.eventid = events.eventid
GO

--roomid     eventid     seats       attendees
------------ ----------- ----------- -----------
--R203       2           50          48
--R302       6           55          48
--B102       4           100         98
--B301       1           600         203
--B201       3           1000        212
--B101       5           1500        892