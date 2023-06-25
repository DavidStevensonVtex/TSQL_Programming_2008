USE tempdb; 
GO

-- No Signal
INSERT INTO dbo.T1 VALUES(1);
GO
-- trg_T1_i in action...

-- Set Signal
EXEC dbo.TrgSignal_Set
  @guid = 0x7EDBCEC5E165E749BF1261A655F52C48,
  @pos = 1;

-- Issue INSERT
INSERT INTO T1 VALUES(2);

-- Clear Signal
EXEC dbo.TrgSignal_Clear @pos = 1;
-- No output from trigger, indicating trigger body not run.

-- No signal
INSERT INTO T1 VALUES(3);
GO
-- trg_T1_i in action...