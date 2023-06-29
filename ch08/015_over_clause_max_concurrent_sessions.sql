-- Using the OVER Clause

CHECKPOINT;
DBCC FREEPROCCACHE WITH NO_INFOMSGS;
DBCC DROPCLEANBUFFERS WITH NO_INFOMSGS;


SELECT app, MAX(concurrent) AS mx 
FROM (SELECT app, SUM(event_type) 
        OVER(PARTITION BY app
             ORDER BY ts, event_type
             ROWS BETWEEN UNBOUNDED PRECEDING
                      AND CURRENT ROW) AS concurrent 
      FROM (SELECT app, starttime AS ts, 1 AS event_type FROM dbo.Sessions 
            UNION ALL 
            SELECT app, endtime, -1 FROM dbo.Sessions) AS D1) AS D2 
GROUP BY app;

-- Executes in under 1 second.