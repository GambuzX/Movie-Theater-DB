.mode columns
.headers on
.nullvalue NULL

/*
Intervalo de dias desde a data de estreia e a última sessao de cada filme de Pokemon
*/

SELECT F.nome as "Filmes de Pokemon", IFNULL(julianday(MAX(date(S.horaInicio))) - julianday(F.dataEstreia), 0) as "Intervalo de dias"
FROM Filme F LEFT JOIN Sessao S ON F.filmeID=S.filme
WHERE F.nome LIKE '%Pokemon%' OR F.resumo LIKE '%Pokemon%'
GROUP BY F.nome
ORDER BY F.nome ASC;
