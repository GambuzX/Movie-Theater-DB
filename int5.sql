.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS CategoriasPorCinema;

/* Melhor e pior genero de filme por cinema */

CREATE VIEW CategoriasPorCinema AS
SELECT C.nome as nomeCinema, Cat.nome as nomeCat, COUNT(bilheteID) as nBilhetes
FROM Bilhete B JOIN Sessao S JOIN Sala JOIN Cinema C JOIN Filme F JOIN FilmeTemCategoria FTC JOIN Categoria Cat
WHERE B.sessao=S.sessaoID
AND  S.sala=Sala.salaID
AND Sala.cinema=C.cinemaID
AND S.filme=F.filmeID
AND F.filmeID=FTC.filme
AND FTC.categoria=Cat.categoriaID
GROUP BY C.nome, Cat.nome
UNION
SELECT C.nome as nomeCinema, Cat.nome as nomeCat, 0 as nBilhetes
FROM Cinema C, Categoria Cat
WHERE NOT EXISTS (SELECT *
                FROM Bilhete B JOIN Sessao S JOIN Sala JOIN Cinema JOIN Filme F JOIN FilmeTemCategoria FTC JOIN Categoria
                WHERE B.sessao=S.sessaoID
                AND  S.sala=Sala.salaID
                AND Sala.cinema=C.cinemaID
                AND S.filme=F.filmeID
                AND F.filmeID=FTC.filme
                AND FTC.categoria=Cat.categoriaID)
ORDER BY nomeCinema, nomeCat ASC;

SELECT *
FROM (SELECT nomeCinema as "Cinema", nomeCat as "Favorite"
        FROM CategoriasPorCinema
        GROUP BY nomeCinema
        HAVING MAX(nBilhetes))
    NATURAL JOIN
    (SELECT nomeCinema as "Cinema", nomeCat as "Worst"
        FROM CategoriasPorCinema
        GROUP BY nomeCinema
        HAVING MIN(nBilhetes) OR nBilhetes=0);