USE tempdb ;
GO

-- Creation Script for the trg_T1_ioi_perrow Trigger
CREATE TRIGGER trg_T1_ioi_perrow ON dbo.T1 INSTEAD OF INSERT
AS
    DECLARE @rc AS INT = 
        (SELECT COUNT(*) FROM (SELECT TOP (2) * FROM inserted) AS D);

    IF @rc = 0 RETURN;

    IF @rc = 1
        INSERT INTO dbo.T1 SELECT * FROM inserted;
    ELSE
    BEGIN
        DECLARE @keycol AS INT, @datacol AS INT;
        DECLARE @Cinserted CURSOR;

        SET @Cinserted = CURSOR FAST_FORWARD FOR
            SELECT keycol, datacol FROM inserted;

        OPEN @Cinserted;

        FETCH NEXT FROM @Cinserted INTO @keycol, @datacol;
        WHILE @@fetch_status = 0
        BEGIN
            INSERT INTO dbo.T1(keycol, datacol) VALUES(@keycol, @datacol);
            FETCH NEXT FROM @Cinserted INTO @keycol, @datacol;
        END
    END
GO