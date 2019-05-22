PRAGMA foreign_keys = ON;



SELECT precoOriginal as "Preco Original", desconto as "Desconto", precoEfetivo as "Preco Efetivo Antes" 
FROM Pedido P INNER JOIN Cliente C ON P.cliente=C.pessoaID
UNION ALL
SELECT " ", " ", " ";



SELECT precoOriginal as "Preco Original", desconto as "Desconto", precoEfetivo as "Preco Efetivo Depois"
FROM Pedido P INNER JOIN Cliente C ON P.cliente=C.pessoaID
UNION ALL
SELECT " ", " ", " ";