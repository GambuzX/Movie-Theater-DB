.mode columns
.headers on
.nullvalue NULL

/* 10 clientes mais fieis por cinema LIMIT 10 (ou 5) (aqueles que foram mais vezes i.e fizeram mais pedidos) */

SELECT P.nome as "Pessoa", COUNT(Ped.pedidoID) AS "Numero De Pedidos"
FROM Pedido Ped INNER JOIN Cliente C INNER JOIN Pessoa P
WHERE Ped.cliente = C.pessoaID
AND P.pessoaID = C.pessoaID
GROUP BY P.PessoaID
ORDER BY "Numero De Pedidos" DESC
LIMIT 10;  