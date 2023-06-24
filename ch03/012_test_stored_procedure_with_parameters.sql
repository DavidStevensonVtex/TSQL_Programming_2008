-- There are two formats for assign values to parameters when invoking a stored procedure:
-- unnamed and named. In the unnamed format, you just specify values without specifying the
-- parameter names. Also, you must specify the inputs by declaration order of the parameters.
-- You can omit inputs only for parameters that have default values and that were declared 
-- at the end of the parameter list. You cannot omit an input between two parameters for 
-- which you do specify values. If you want such parameters to use their default values, 
-- you need to specify the DEFAULT keyword for those.

-- As an example, the following code invokes the procedure without specifying the inputs for
-- the last parameters, which will use their default values.

EXEC dbo.GetCustOrders 1 ;

--orderid     custid      empid       orderdate
------------- ----------- ----------- -----------------------
--10643       1           6           2007-08-25 00:00:00.000
--10692       1           4           2007-10-03 00:00:00.000
--10702       1           4           2007-10-13 00:00:00.000
--10835       1           1           2008-01-15 00:00:00.000
--10952       1           1           2008-03-16 00:00:00.000
--11011       1           3           2008-04-09 00:00:00.000

EXEC dbo.GetCustOrders 1, DEFAULT, '20071231' ;

--orderid     custid      empid       orderdate
------------- ----------- ----------- -----------------------
--10643       1           6           2007-08-25 00:00:00.000
--10692       1           4           2007-10-03 00:00:00.000
--10702       1           4           2007-10-13 00:00:00.000

EXEC dbo.GetCustOrders 1, '20070101', '20071231' ;

--orderid     custid      empid       orderdate
------------- ----------- ----------- -----------------------
--10643       1           6           2007-08-25 00:00:00.000
--10692       1           4           2007-10-03 00:00:00.000
--10702       1           4           2007-10-13 00:00:00.000

--Many maintenance-related issues can arise when you use the unnamed
--assignment format. You must specify the arguments in order; you must
--not omit an optional parameter; and by looking at the code, it might 
--not be clear what the inputs actually mean and to which parameter they
--relate. Therefore, it's good practdice to use the named assignment format,
--in which you specify the name of the argument and assign it with an input
--value, as in the following example.

EXEC dbo.GetCustOrders 
	@custid = 1,
	@fromdate = '20070101',
	@toDate = '20071231' ;

--The code is much more readable, you can play with the order in which you
--specify the inputs, and you can omit any parameter that you like if it has
--a default value.

	