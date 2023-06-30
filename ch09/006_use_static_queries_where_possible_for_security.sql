USE InsideTSQL2008;

-- Could use static query here
DECLARE @lastname AS NVARCHAR(40) = N'Davis';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = @lastname;
GO

--empid       firstname  lastname
------------- ---------- --------------------
--1           Sara       Davis