USE tempdb; 
GO

-- Not Firing Triggers for Specific Statements

-- One way to achieve this is by creating a temporary table with a particular name (for example
-- a GUID) in the calling batch. Rember that a local temporary table is visible only to the
-- creating session, in the calling level, and levels inner to it. The trigger can first check
-- whether a temporary table with that particular name exists and, if it does, return. Otherwise,
-- the code can continue running normally. Back in the calling batch, you can drop the
-- temporary table when you don't want to prevent the trigger from running its code anymore.

-- Test trg_T1_i

-- No Signal
INSERT INTO dbo.T1 VALUES(1);
GO
-- trg_T1_i in action...

-- Setting signal
CREATE TABLE #do_not_fire_trg_T1_i(col1 INT);
INSERT INTO T1 VALUES(2);
-- Clearing signal
DROP TABLE #do_not_fire_trg_T1_i;
GO
-- Nothing printed.