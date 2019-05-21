.mode columns
.headers on
.nullvalue NULL

/* 
Rendimento total dos 10 melhores filmes durante determinado periodo de tempo
bilhetes + produtos
*/
 
SELECT nome as "Filme", (SELECT IFNULL(SUM(val), 0)
                            FROM
                                -- bilhetes 
                                (SELECT P.precoEfetivo as val
                                FROM Pedido P
                                WHERE P.pedidoID in (SELECT B.pedido
                                                    FROM Bilhete B INNER JOIN Sessao S INNER JOIN Filme F
                                                    WHERE B.sessao=S.sessaoID
                                                    AND S.filme=F.filmeID
                                                    AND F.nome=filme.nome 
                                                    AND date(S.horaInicio) >= '2019-04-29' 
                                                    AND date(S.horaInicio) <= '2019-06-23')
                                UNION ALL
                                -- produtos
                                SELECT PA.quantidade*Prod.preco as val
                                    FROM Produto Prod INNER JOIN ProdutoAdquirido PA INNER JOIN Pedido P
                                        WHERE Prod.produtoID=PA.produto
                                        AND PA.pedido=P.pedidoID
                                        AND P.pedidoID in (SELECT B.pedido
                                                            FROM Bilhete B INNER JOIN Sessao S INNER JOIN Filme F
                                                            WHERE B.sessao=S.sessaoID
                                                            AND S.filme=F.filmeID
                                                            AND F.nome=filme.nome 
                                                            AND date(S.horaInicio) >= '2019-04-29' 
                                                            AND date(S.horaInicio) <= '2019-06-23'))) as "Rendimento Total"
FROM Filme filme
ORDER BY "Rendimento Total" DESC
LIMIT 10;