-- Query info about plan guide
SELECT * 
FROM sys.plan_guides
WHERE name = 'PG_MyQuery1_MAXDOP1';