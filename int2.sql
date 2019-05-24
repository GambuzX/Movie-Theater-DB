.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS ClassificacaoFilmes;

/* listar nome dos filmes de fantasia disponiveis a 24/05/2019 cuja classificacao é superior a 3.0, junto da quantidade de sessoes */

CREATE VIEW ClassificacaoFilmes AS 
SELECT filmeID, IFNULL(AVG(classificacao), "-") as average
FROM Filme LEFT JOIN Critica ON Filme.filmeID=Critica.filme
GROUP BY filmeID;

SELECT nome as 'Filme', COUNT(filmeID) as 'N Sessoes'
FROM (SELECT S.filme as filmeID
      FROM Sessao S
      WHERE date(S.horaInicio)='2019-05-24' 
      AND 
      S.filme IN (SELECT ftc.filme
                  FROM FilmeTemCategoria ftc INNER JOIN Categoria C ON ftc.categoria=C.categoriaID
                  WHERE C.nome='Fantasia'
                  AND (SELECT average 
                        FROM ClassificacaoFilmes CF 
                        WHERE CF.filmeID=ftc.filme) > 3.0
                  )) NATURAL JOIN Filme
GROUP BY nome;