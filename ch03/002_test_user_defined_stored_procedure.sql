USE InsideTSQL2008;

EXEC dbo.GetSortedShippers @colname = N'companyname';
GO

--shipperid   companyname                              phone
------------- ---------------------------------------- ------------------------
--2           Shipper ETYNR                            (425) 555-0136
--1           Shipper GVSUA                            (503) 555-0137
--3           Shipper ZHISN                            (415) 555-0138

--(3 rows affected)