---------------------------------------------------------------------
-- Used with Views
---------------------------------------------------------------------

-- Creation Script for OrderDetails Table and VOrderTotals View
USE tempdb;
IF OBJECT_ID('dbo.OrderTotals', 'V') IS NOT NULL
  DROP VIEW dbo.OrderTotals;
IF OBJECT_ID('dbo.OrderDetails', 'U') IS NOT NULL
  DROP TABLE dbo.OrderDetails;
GO

CREATE TABLE dbo.OrderDetails
(
    oid  INT NOT NULL,
    pid INT NOT NULL,
    qty INT NOT NULL,
    PRIMARY KEY(oid, pid)
);

INSERT INTO dbo.OrderDetails(oid, pid, qty) VALUES
  (10248, 1, 10),
  (10248, 2, 20),
  (10248, 3, 30),
  (10249, 1,  5),
  (10249, 2, 10),
  (10249, 3, 15),
  (10250, 1, 20),
  (10250, 2, 20),
  (10250, 3, 20);
GO

CREATE VIEW dbo.OrderTotals
AS
    SELECT oid, SUM(qty) AS totalqty
    FROM dbo.OrderDetails
    GROUP BY oid;
GO

-- Creation Script for trg_VOrderTotals_iou Trigger
CREATE TRIGGER trg_OrderTotals_iou ON dbo.OrderTotals INSTEAD OF UPDATE
AS

    IF NOT EXISTS(SELECT * FROM inserted) RETURN;

    IF UPDATE(oid)
    BEGIN
    RAISERROR('Updates to the OrderID column are not allowed.', 16, 1);
    ROLLBACK TRAN;
    RETURN;
    END;

    WITH UPD_CTE AS
    (
    SELECT qty, ROUND(1.*OD.qty / D.totalqty * I.totalqty, 0) AS newqty
    FROM dbo.OrderDetails AS OD
        JOIN inserted AS I
        ON OD.oid = I.oid
        JOIN deleted AS D
        ON I.oid = D.oid
    )
    UPDATE UPD_CTE
    SET qty = newqty;
GO