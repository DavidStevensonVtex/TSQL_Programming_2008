USE tempdb;
-- Get Next Sequence
DECLARE @key AS INT;
EXEC dbo.GetSequence @val = @key OUTPUT;
SELECT @key as SequenceKey;
GO
--SequenceKey
-------------
--4