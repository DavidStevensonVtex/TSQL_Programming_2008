---------------------------------------------------------------------
-- Matching Problems
---------------------------------------------------------------------

-- Code that Creates and Populates the Events and Rooms Tables
USE tempdb;
IF OBJECT_ID('dbo.Events', 'U') IS NOT NULL DROP TABLE dbo.Events;
IF OBJECT_ID('dbo.Rooms', 'U') IS NOT NULL DROP TABLE dbo.Rooms;
GO

CREATE TABLE dbo.Rooms
(
  roomid VARCHAR(10) NOT NULL PRIMARY KEY,
  seats INT NOT NULL
);

INSERT INTO dbo.Rooms(roomid, seats) VALUES
  ('C001', 2000),
  ('B101', 1500),
  ('B102', 100),
  ('R103', 40),
  ('R104', 40),
  ('B201', 1000),
  ('R202', 100),
  ('R203', 50),
  ('B301', 600),
  ('R302', 55),
  ('R303', 55);

CREATE TABLE dbo.Events
(
  eventid INT NOT NULL PRIMARY KEY,
  eventdesc VARCHAR(25) NOT NULL,
  attendees INT NOT NULL
);

INSERT INTO dbo.Events(eventid, eventdesc, attendees) VALUES
  (1, 'Adv T-SQL Seminar', 203),
  (2, 'Logic Seminar',     48),
  (3, 'DBA Seminar',       212),
  (4, 'XML Seminar',       98),
  (5, 'Security Seminar',  892),
  (6, 'Modeling Seminar',  48);

CREATE UNIQUE INDEX idx_att_eid_edesc
  ON dbo.Events(attendees, eventid, eventdesc);
CREATE UNIQUE INDEX idx_seats_rid
  ON dbo.Rooms(seats, roomid);
GO
