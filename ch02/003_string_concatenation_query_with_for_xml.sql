USE InsideTSQL2008;

-- String Concatenation using FOR XML PATH
SELECT custid,
  COALESCE(
    (SELECT CAST(orderid AS VARCHAR(10)) + ';' AS [text()]
     FROM Sales.Orders AS O
     WHERE O.custid = C.custid
     ORDER BY orderid
     FOR XML PATH(''), TYPE).value('.[1]', 'VARCHAR(MAX)'), '') AS orders
FROM Sales.Customers AS C;
