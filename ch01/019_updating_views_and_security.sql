---------------------------------------------------------------------
-- Updating Views
---------------------------------------------------------------------

-- Creating UserData, CurrentUserData and Setting Permissions
USE tempdb;
GO

IF OBJECT_ID('dbo.CurrentUserData', 'V') IS NOT NULL
  DROP VIEW dbo.CurrentUserData;
IF OBJECT_ID('dbo.UserData', 'T') IS NOT NULL
  DROP TABLE dbo.UserData;
GO
CREATE TABLE dbo.UserData
(
  keycol    INT         NOT NULL IDENTITY PRIMARY KEY,
  loginname sysname     NOT NULL DEFAULT (SUSER_SNAME()),
  datacol   VARCHAR(20) NOT NULL,
  /* ... other columns ... */
);
GO
CREATE VIEW dbo.CurrentUserData
AS

SELECT keycol, datacol
FROM dbo.UserData
WHERE loginname = SUSER_SNAME();
GO

DENY SELECT, INSERT, UPDATE, DELETE ON dbo.UserData TO public;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.CurrentUserData TO public;
GO