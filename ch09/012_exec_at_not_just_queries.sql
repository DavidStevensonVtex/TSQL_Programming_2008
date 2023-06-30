-- Executable code works; not just queries
EXEC
(
 'USE tempdb;
IF OBJECT_ID(''dbo.T1'', ''U'') IS NOT NULL
  DROP TABLE dbo.T1;
CREATE TABLE dbo.T1
(
  keycol INT NOT NULL PRIMARY KEY,
  datacol VARCHAR(10) NOT NULL
);'
) AT [DSTEVENSONWIN10\SQL_2019];
GO

-- Create a linked server to an Access database
EXEC sp_addlinkedserver
   @server = 'AccessDatabase1',
   @provider = 'Microsoft.ACE.OLEDB.12.0',
   @srvproduct = 'OLE DB Provider for ACE',
   @datasrc = 'C:\temp\Database1.accdb';

-- Remove default self-mapping added for all local logins
EXEC sp_droplinkedsrvlogin 'AccessDatabase1', NULL;
-- Add login mappings
EXEC sp_addlinkedsrvlogin
  'AccessDatabase1', 'false', '<specify_local_login_name_here>', Admin, NULL;
GO
