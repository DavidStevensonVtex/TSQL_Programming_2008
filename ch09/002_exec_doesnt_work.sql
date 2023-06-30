USE tempdb;

DECLARE @year AS CHAR(4) = CAST(YEAR(CURRENT_TIMESTAMP) AS CHAR(4));



-- Book: I constructed the code within the parentheses of the EXEC command, but not that only
-- a string variable, a string literal, or a concatenation of string variables and/or string 
-- literals are allowed within the parentheses. You're not allowed to invoke functions or use 
-- a CASE expression. For example, the following code, which attempts to invoke the  CAST function
-- within the parentheses, fails:

-- EXEC doesn't work
EXEC('SELECT orderid FROM dbo.Orders'
       + CAST(YEAR(CURRENT_TIMESTAMP) AS CHAR(4)) + ';');
GO

--Msg 102, Level 15, State 1, Line 7
--Incorrect syntax near 'CAST'.