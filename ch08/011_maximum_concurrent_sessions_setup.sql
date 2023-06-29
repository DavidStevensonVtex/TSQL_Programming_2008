---------------------------------------------------------------------
-- Max Concurrent Sessions
---------------------------------------------------------------------

-- Listing 8-2: Creating and Populating Sessions
USE tempdb;
IF OBJECT_ID('dbo.Sessions', 'U') IS NOT NULL DROP TABLE dbo.Sessions;

CREATE TABLE dbo.Sessions
(
  keycol    INT         NOT NULL IDENTITY,
  app       VARCHAR(10) NOT NULL,
  usr       VARCHAR(10) NOT NULL,
  host      VARCHAR(10) NOT NULL,
  starttime DATETIME    NOT NULL,
  endtime   DATETIME    NOT NULL,
  CONSTRAINT PK_Sessions PRIMARY KEY(keycol),
  CHECK(endtime > starttime)
);
GO

INSERT INTO dbo.Sessions VALUES
  ('app1', 'user1', 'host1', '20090212 08:30', '20090212 10:30'),
  ('app1', 'user2', 'host1', '20090212 08:30', '20090212 08:45'),
  ('app1', 'user3', 'host2', '20090212 09:00', '20090212 09:30'),
  ('app1', 'user4', 'host2', '20090212 09:15', '20090212 10:30'),
  ('app1', 'user5', 'host3', '20090212 09:15', '20090212 09:30'),
  ('app1', 'user6', 'host3', '20090212 10:30', '20090212 14:30'),
  ('app1', 'user7', 'host4', '20090212 10:45', '20090212 11:30'),
  ('app1', 'user8', 'host4', '20090212 11:00', '20090212 12:30'),
  ('app2', 'user8', 'host1', '20090212 08:30', '20090212 08:45'),
  ('app2', 'user7', 'host1', '20090212 09:00', '20090212 09:30'),
  ('app2', 'user6', 'host2', '20090212 11:45', '20090212 12:00'),
  ('app2', 'user5', 'host2', '20090212 12:30', '20090212 14:00'),
  ('app2', 'user4', 'host3', '20090212 12:45', '20090212 13:30'),
  ('app2', 'user3', 'host3', '20090212 13:00', '20090212 14:00'),
  ('app2', 'user2', 'host4', '20090212 14:00', '20090212 16:30'),
  ('app2', 'user1', 'host4', '20090212 15:30', '20090212 17:00');

CREATE INDEX idx_nc_app_st_et ON dbo.Sessions(app, starttime, endtime);
GO