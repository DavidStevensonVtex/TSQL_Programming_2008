USE InsideTSQL2008;
GO

-- Run first time
EXEC dbo.CustCities;

-- Change SET option, and run second time
SET CONCAT_NULL_YIELDS_NULL OFF;

EXEC dbo.CustCities;

-- Notice two plans in syscacheobjects, and different setopts values
SELECT cacheobjtype, objtype, usecounts, setopts, sql
FROM sys.syscacheobjects
WHERE sql NOT LIKE '%sys%'
  AND sql LIKE '%97216686-F90E-4D5A-9A9E-CFD9E548AE81%';

-- Set session option back ON
SET CONCAT_NULL_YIELDS_NULL ON;
GO