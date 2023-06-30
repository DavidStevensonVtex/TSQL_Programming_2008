USE tempdb;
GO

-- Test inserts
INSERT INTO dbo.Computations(arg1, arg2, arg3, computation) VALUES
  (1, 2, 3, '@arg1 + @arg2 + @arg3'),
  (4, 5, 6, '@arg1 * @arg2 - @arg3'),
  (7, 8, DEFAULT, '2. * @arg2 / @arg1');

SELECT * FROM dbo.Computations;
GO

--keycol      arg1        arg2        arg3        computation                  result
------------- ----------- ----------- ----------- ---------------------------- -----------
--1           1           2           3           @arg1 + @arg2 + @arg3        6
--2           4           5           6           @arg1 * @arg2 - @arg3        14
--3           7           8           NULL        2. * @arg2 / @arg1           2

-- Test update
UPDATE dbo.Computations SET arg1 *= 2;
SELECT * FROM dbo.Computations;
GO

--keycol      arg1        arg2        arg3        computation              result
------------- ----------- ----------- ----------- ------------------------ -----------
--1           2           2           3           @arg1 + @arg2 + @arg3    7
--2           8           5           6           @arg1 * @arg2 - @arg3    34
--3           14          8           NULL        2. * @arg2 / @arg1       1
