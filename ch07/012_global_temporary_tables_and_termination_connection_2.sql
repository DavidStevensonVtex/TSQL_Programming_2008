---------------------------------------------------------------------
-- Global Temporary Tables
---------------------------------------------------------------------

-- Termination

-- Connection 2 - Step 2
BEGIN TRAN
  UPDATE ##T1 SET col1 = col1 + 1;

-- Connection 2 Step 4
  -- Succeeds
  SELECT * FROM ##T1;
COMMIT

--col1
-------------
--2

-- Fails - Connection 2 - Step 5
SELECT * FROM ##T1;
GO

--Msg 208, Level 16, State 0, Line 21
--Invalid object name '##T1'.