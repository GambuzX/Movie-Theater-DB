.mode columns
.headers on
.nullvalue NULL

/* 
Rendimento total de cada filme durante determinado periodo de tempo
bilhetes + produtos
*/
 
SELECT nome as "Filme", (SELECT IFNULL(SUM(val), 0)
                            FROM
                                -- bilhetes 
                                (SELECT P.precoEfetivo as val
                                FROM Pedido P
                                WHERE P.pedidoID in (SELECT B.pedido
                                                    FROM (Bilhete B INNER JOIN Sessao S ON B.sessao=S.sessaoID) INNER JOIN Filme F ON S.filme=F.filmeID
                                                    WHERE F.nome=filme.nome 
                                                    AND date(S.horaInicio) >= '2019-04-29' 
                                                    AND date(S.horaInicio) <= '2019-06-23')
                                UNION ALL
                                -- produtos
                                SELECT PA.quantidade*Prod.preco as val
                                    FROM (Produto Prod INNER JOIN ProdutoAdquirido PA ON Prod.produtoID=PA.produto) 
                                        INNER JOIN Pedido P
                                        ON PA.pedido=P.pedidoID
                                        WHERE P.pedidoID in (SELECT B.pedido
                                                                FROM (Bilhete B INNER JOIN Sessao S ON B.sessao=S.sessaoID) INNER JOIN Filme F ON S.filme=F.filmeID
                                                                WHERE F.nome=filme.nome
                                                                AND date(S.horaInicio) >= '2019-04-29' 
                                                                AND date(S.horaInicio) <= '2019-06-23'))) as "Rendimento Total"
FROM Filme filme
ORDER BY "Rendimento Total" DESC;