---------------------------------------------------------------------
-- Table-Valued Parameters
---------------------------------------------------------------------

-- Create user defined table types
USE InsideTSQL2008;

IF TYPE_ID('dbo.OrderIDs') IS NOT NULL DROP TYPE dbo.OrderIDs;

CREATE TYPE dbo.OrderIDs AS TABLE 
( 
  pos INT NOT NULL PRIMARY KEY,
  orderid INT NOT NULL UNIQUE
);
GO
