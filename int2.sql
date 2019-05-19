.mode columns
.headers on
.nullvalue NULL

/* listar nome dos filmes de fantasia disponiveis a 24/05/2019, junto da quantidade de sessoes */

SELECT nome as 'Filme', COUNT(filmeID) as 'N Sessoes'
FROM (SELECT S.filme as filmeID
      FROM Sessao S
      WHERE date(S.horaInicio)='2019-05-24' 
      AND 
      S.filme IN (SELECT ftc.filme
                  FROM FilmeTemCategoria ftc INNER JOIN Categoria C ON ftc.categoria=C.categoriaID
                  WHERE C.nome='Fantasia')) NATURAL JOIN Filme
GROUP BY nome;