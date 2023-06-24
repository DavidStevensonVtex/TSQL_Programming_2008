USE InsideTSQL2008;

-- Discard results after execution

-- Runs in less than a second
-- Plan shows Compute Scalar operator
-- Property Defined Values is [Expr1003] = Scalar Operator([Generic].[dbo].[Nums].[n]+(1))
SELECT n, n + 1 AS n_plus_one FROM dbo.Nums WHERE n <= 1000000;