USE InsideTSQL2008 ;

-- Using CROSS APPLY

-- The difference between the join and APPLY operator becomes evident when you have a 
-- table-valued expression on the right side and you want this table-valued expression 
-- to be evaluated for each row from the left table expression.

SELECT Nums.n, A.val AS n_plus_one
FROM dbo.Nums CROSS APPLY dbo.AddOneInline(n) AS A
WHERE n <= 1000000;