-- Notice usecounts 2 in syscacheobjects
SELECT cacheobjtype, objtype, usecounts, sql
FROM sys.syscacheobjects
WHERE sql NOT LIKE '%sys%'
  AND sql LIKE '%33145F87-1109-4959-91D6-F1EC81F8428F%';
GO