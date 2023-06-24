USE InsideTSQL2008 ;

-- Runs for 5 seconds
-- Plan shows Compute Scalar operator
-- Property Defined Values is [Expr1003] = Scalar Operator([InsideTSQL2008].[dbo].[AddOne]([Generic].[dbo].[Nums].[n]))
SELECT n, dbo.AddOne(n) AS n_plus_one FROM dbo.Nums WHERE n <= 1000000;