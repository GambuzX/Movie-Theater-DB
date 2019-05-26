.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS ContagemLugaresSalaCinema;

/*Selecionar lugares preferidos por cada sala por cada cinema*/
/*Lugares com mais bilhetes comprados */

CREATE VIEW ContagemLugaresSalaCinema as
SELECT nomeCinema, numeroSala, lugarSala, COUNT(lugarSala) as contagemLugares
FROM (SELECT C.nome as nomeCinema, S.numero as numeroSala, (L.fila || '-' || L.numero) as lugarSala
        FROM Cinema C JOIN Sala S ON C.cinemaID=S.cinema
        JOIN Lugar L ON S.salaID=L.sala
        JOIN Bilhete B ON L.lugarID=B.lugar)
GROUP BY nomeCinema, numeroSala, lugarSala;

SELECT nomeCinema as "Cinema", numeroSala as "Sala", lugarSala as "Lugar preferido", MAX(contagemLugares) as "Num bilhetes"
FROM ContagemLugaresSalaCinema
GROUP BY nomeCinema, numeroSala;
