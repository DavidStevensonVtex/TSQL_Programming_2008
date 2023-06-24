USE tempdb ;

SELECT *
FROM dbo.Subordinates(3) ;

--empid       mgrid       empname                   salary                lvl
------------- ----------- ------------------------- --------------------- -----------
--3           1           Ina                       7500.00               0
--7           3           Aaron                     5000.00               1
--9           7           Rita                      3000.00               2
--11          7           Gabriel                   3000.00               2
--12          9           Emilia                    2000.00               3
--13          9           Michael                   2000.00               3
--14          9           Didi                      1500.00               3

--(7 rows affected)