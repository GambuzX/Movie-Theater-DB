.mode columns
.headers on
.nullvalue NULL

/* 
listar nome e classificacao media de cada filme
se for igual a null, insere '-' em vez de null
*/

SELECT nome as "Filme", IFNULL(avg(classificacao), "-") as "Classificação"
FROM Filme LEFT JOIN Critica ON Filme.filmeID=Critica.filme
GROUP BY nome;
