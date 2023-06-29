-- Cursor Code for Matching Problem (nonguaranteed solution)
DECLARE
  @roomid AS VARCHAR(10), @seats AS INT,
  @eventid AS INT, @attendees AS INT;

DECLARE @Events AS TABLE(eventid INT, attendees INT);
DECLARE @Result AS TABLE(roomid  VARCHAR(10), eventid INT);

-- Step 1: Descending
DECLARE CRoomsDesc CURSOR FAST_FORWARD FOR
  SELECT roomid, seats FROM dbo.Rooms
  ORDER BY seats DESC, roomid DESC;
DECLARE CEventsDesc CURSOR FAST_FORWARD FOR
  SELECT eventid, attendees FROM dbo.Events
  ORDER BY attendees DESC, eventid DESC;

OPEN CRoomsDesc;
OPEN CEventsDesc;

FETCH NEXT FROM CRoomsDesc INTO @roomid, @seats;
WHILE @@FETCH_STATUS = 0
BEGIN
  FETCH NEXT FROM CEventsDesc INTO @eventid, @attendees;

  WHILE @@FETCH_STATUS = 0 AND @seats < @attendees
    FETCH NEXT FROM CEventsDesc INTO @eventid, @attendees;

  IF @@FETCH_STATUS = 0
    INSERT INTO @Events(eventid, attendees)
      VALUES(@eventid, @attendees);
  ELSE
    BREAK;

  FETCH NEXT FROM CRoomsDesc INTO @roomid, @seats;
END

CLOSE CRoomsDesc;
CLOSE CEventsDesc;

DEALLOCATE CRoomsDesc;
DEALLOCATE CEventsDesc;

SELECT * FROM @Events ;

SELECT e.eventid, events.eventdesc, e.attendees
FROM @Events e
	INNER JOIN dbo.Events events	
		ON e.eventid = events.eventid ;

-- Step 2: Ascending
DECLARE CRooms CURSOR FAST_FORWARD FOR
  SELECT roomid, seats FROM Rooms
  ORDER BY seats, roomid;
DECLARE CEvents CURSOR FAST_FORWARD FOR
  SELECT eventid, attendees FROM @Events
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

SELECT result.eventid, events.eventdesc, events.attendees, result.roomid, rooms.seats
FROM @Result result
	INNER JOIN dbo.Events events	
		ON result.eventid = events.eventid
	LEFT JOIN dbo.Rooms rooms
		ON rooms.roomid = result.roomid
ORDER BY rooms.seats DESC ;
GO

--eventid     attendees
------------- -----------
--5           892
--3           212
--1           203
--4           98
--6           48
--2           48

--eventid     eventdesc                 attendees
------------- ------------------------- -----------
--5           Security Seminar          892
--3           DBA Seminar               212
--1           Adv T-SQL Seminar         203
--4           XML Seminar               98
--6           Modeling Seminar          48
--2           Logic Seminar             48

--eventid     eventdesc                 attendees   roomid     seats
------------- ------------------------- ----------- ---------- -----------
--5           Security Seminar          892         B101       1500
--3           DBA Seminar               212         B201       1000
--1           Adv T-SQL Seminar         203         B301       600
--4           XML Seminar               98          B102       100
--6           Modeling Seminar          48          R302       55
--2           Logic Seminar             48          R203       50