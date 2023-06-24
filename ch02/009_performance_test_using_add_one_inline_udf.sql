USE InsideTSQL2008 ;

-- Runs in less than a second
-- Same plan as query without function call
SELECT n, (SELECT val FROM dbo.AddOneInline(n) AS F) AS n_plus_one
FROM dbo.Nums WHERE n <= 1000000;
GO