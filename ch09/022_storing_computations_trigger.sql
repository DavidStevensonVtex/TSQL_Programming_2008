USE tempdb;
GO

IF EXISTS (SELECT 1 FROM sys.triggers 
           WHERE Name = 'trg_Computations_iu_calc_result')
BEGIN
    PRINT 'Trigger Exists'
	DROP TRIGGER trg_Computations_iu_calc_result
END
GO

-- Trigger that calculates the result of the computations
CREATE TRIGGER trg_Computations_iu_calc_result
  ON dbo.Computations FOR INSERT, UPDATE
AS
    DECLARE @rc AS INT = 
    (SELECT COUNT(*) FROM (SELECT TOP (2) * FROM inserted) AS D);

    -- If no rows affected, return
    IF @rc = 0 RETURN;

    -- If none of the columns: arg1, arg2, arg3, computation
    -- were updated, return
    IF COLUMNS_UPDATED() & 30 /* 00011110 binary */ = 0 RETURN;

    -- Not allowed to update result
    IF    EXISTS(SELECT * FROM inserted)
		AND EXISTS(SELECT * FROM deleted)
		AND UPDATE(result)
    BEGIN
		RAISERROR('Not allowed to update result.', 16, 1);
		ROLLBACK;
		RETURN;
    END

    DECLARE
		@key        AS INT,            -- keycol
		@in_arg1    AS INT,            -- arg1
		@in_arg2    AS INT,            -- arg2
		@in_arg3    AS INT,            -- arg3
		@out_result AS INT,            -- result of computation
		@comp       AS NVARCHAR(4000), -- computation
		@params     AS NVARCHAR(100);  -- parameter�s list for sp_executesql

    -- If only one row was affected, don't use a cursor
    IF @rc = 1
    BEGIN
		-- Grab values from inserted
		SELECT @key = keycol, @in_arg1 = arg1, @in_arg2 = arg2,
			@in_arg3 = arg3, @comp = N'SET @result = ' + computation
		FROM inserted;

		-- Generate a string with the in/out parameters
		SET @params = N'@result INT output, @arg1 INT, @arg2 INT, @arg3 INT';

		-- Calculate computation and store the result in @out_result
		EXEC sp_executesql
			@comp,
			@params,
			@result = @out_result OUTPUT,
			@arg1   = @in_arg1,
			@arg2   = @in_arg2,
			@arg3   = @in_arg3;

		-- Update the result column in the row with the current key
		UPDATE dbo.Computations
		SET result = @out_result
		WHERE keycol = @key;
    END
    -- If only multiple rows were affected, use a cursor
    ELSE
    BEGIN
		-- Loop through all keys in inserted
		DECLARE CInserted CURSOR FAST_FORWARD FOR
			SELECT keycol, arg1, arg2, arg3, N'SET @result = ' + computation
			FROM inserted;

		OPEN CInserted;

		-- Get first row from inserted
		FETCH NEXT FROM CInserted
			INTO @key, @in_arg1, @in_arg2, @in_arg3, @comp ;

		WHILE @@fetch_status = 0
		BEGIN

			-- Generate a string with the in/out parameters
			SET @params = N'@result INT output, @arg1 INT, @arg2 INT, @arg3 INT';

			-- Calculate computation and store the result in @out_result
			EXEC sp_executesql
				@comp,
				@params,
				@result = @out_result OUTPUT,
				@arg1   = @in_arg1,
				@arg2   = @in_arg2,
				@arg3   = @in_arg3;

			-- Update the result column in the row with the current key
			UPDATE dbo.Computations
			SET result = @out_result
			WHERE keycol = @key;

			-- Get next row from inserted
			FETCH NEXT FROM CInserted
			INTO @key, @in_arg1, @in_arg2, @in_arg3, @comp;
		END

		CLOSE CInserted;
		DEALLOCATE CInserted;
	END
GO
