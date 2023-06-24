---------------------------------------------------------------------
-- Stored Procedure's Interface
---------------------------------------------------------------------

-- Stored procedures accept three kinds of parameters: scalar input parameters,
-- table-valued input parameters, and scalar output parameters.

---------------------------------------------------------------------
-- Scalar Input Parameters
---------------------------------------------------------------------

-- A scalar input parameter must be provided with a value when the stored
-- procedure is invoked, unless you assign the parameter with a default value. 

-- Creating GetCustOrders Procedure

USE InsideTSQL2008;
IF OBJECT_ID('dbo.GetCustOrders', 'P') IS NOT NULL
  DROP PROC dbo.GetCustOrders;
GO

CREATE PROC dbo.GetCustOrders
  @custid   AS INT,
  @fromdate AS DATETIME = '19000101',
  @todate   AS DATETIME = '99991231'
AS

    SET NOCOUNT ON;

    SELECT orderid, custid, empid, orderdate
    FROM Sales.Orders
    WHERE custid = @custid
    AND orderdate >= @fromdate
    AND orderdate < @todate;
GO

-- Tip: The SET NOCOUNT ON option tells SQL Server not to produce the message saying how
-- many rows were affected for data manipulation language (DML) statements. Some client
-- database interfaces, such as OLEDB, absorb this message as a row set. 