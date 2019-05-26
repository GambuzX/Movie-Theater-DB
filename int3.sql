.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS FilmePorPedido;

/* 
Rendimento total dos 10 melhores filmes durante determinado periodo de tempo
bilhetes + produtos
*/

CREATE VIEW FilmePorPedido AS
SELECT B.pedido as pedidoID, S.filme as filmeID
FROM Bilhete B JOIN Sessao S ON B.sessao=S.sessaoID
WHERE date(S.horaInicio) >= '2019-04-29' AND date(S.horaInicio) <= '2019-06-23';
 
SELECT nome as "Filme", (SELECT IFNULL(SUM(val), 0)
                            FROM
                                -- bilhetes 
                                (SELECT P.precoEfetivo as val
                                FROM Pedido P
                                WHERE P.pedidoID in (SELECT pedidoID
                                                    FROM FilmePorPedido FPP JOIN Filme
                                                    ON FPP.filmeID=F.filmeID)
                                UNION ALL
                                -- produtos
                                SELECT PA.quantidade*Prod.preco as val
                                    FROM Produto Prod INNER JOIN ProdutoAdquirido PA INNER JOIN Pedido P
                                        WHERE Prod.produtoID=PA.produto
                                        AND PA.pedido=P.pedidoID
                                        AND P.pedidoID in (SELECT pedidoID
                                                            FROM FilmePorPedido FPP JOIN Filme
                                                            ON FPP.filmeID=F.filmeID))) as "Rendimento Total"
FROM Filme F
ORDER BY "Rendimento Total" DESC, nome ASC
LIMIT 10;