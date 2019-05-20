.mode columns
.headers on
.nullvalue NULL

/* 
listar nome, classificacao media, num criticas, num sessoes e num bilhetes vendidos de cada filme
se for igual a null, insere '-' em vez de null
*/

SELECT nome as "Filme", average as "Classificacao", criticsCount as "Num criticas", sessionCount as "Num sessoes", ticketcount as "Num bilhetes"
FROM (SELECT nome, IFNULL(AVG(classificacao), "-") as average, COUNT(criticaID) as criticsCount
        FROM Filme LEFT JOIN Critica ON Filme.filmeID=Critica.filme
        GROUP BY nome)
    NATURAL JOIN
    (SELECT nome, COUNT(DISTINCT sessaoID) as sessionCount, COUNT(bilheteID) as ticketCount
        FROM (Filme LEFT JOIN Sessao ON Filme.filmeID=Sessao.filme) LEFT JOIN Bilhete ON Sessao.sessaoID=Bilhete.sessao
        GROUP BY nome)