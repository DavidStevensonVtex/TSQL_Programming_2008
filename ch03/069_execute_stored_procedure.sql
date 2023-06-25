USE InsideTSQL2008 ;
GO

-- Test solution 1
EXEC dbo.GetSortedShippers @colname = N'shipperid', @sortdir = N'D';
GO

--shipperid   companyname                              phone
------------- ---------------------------------------- ------------------------
--3           Shipper ZHISN                            (415) 555-0138
--2           Shipper ETYNR                            (425) 555-0136
--1           Shipper GVSUA                            (503) 555-0137

--(3 rows affected)