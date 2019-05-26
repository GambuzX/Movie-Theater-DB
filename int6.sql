.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS HorariosPorCinema;

CREATE VIEW HorariosPorCinema AS
SELECT nomeC, Horario_t, COUNT(Horario_t) as quant 
FROM
  (SELECT 
    CASE
      WHEN time(horaInicio) >= '07:00:00' AND time(horaInicio) <= '11:00:00' THEN 'Inicio da Manhã'
      WHEN time(horaInicio) >= '11:00:00' AND time(horaInicio) <= '13:00:00' THEN 'Fim da Manhã'
      WHEN time(horaInicio) >= '13:00:00' AND time(horaInicio) <= '16:00:00' THEN 'Inicio da Tarde'
      WHEN time(horaInicio) >= '16:00:00' AND time(horaInicio) <= '17:30:00' THEN 'Meio da Tarde'
      WHEN time(horaInicio) >= '17:30:00' AND time(horaInicio) <= '19:30:00' THEN 'Fim da Tarde'
      WHEN time(horaInicio) >= '19:30:00' AND time(horaInicio) <= '22:00:00' THEN 'Noite'
      Else 'Madrugada'
    END Horario_t,
    Cinema.nome as nomeC
    FROM Sessao INNER JOIN Sala INNER JOIN Cinema
    WHERE Sessao.sala=Sala.salaID AND Sala.cinema=Cinema.cinemaID)
    GROUP By nomeC, Horario_t
    ORDER By nomeC ASC, quant DESC;

SELECT * 
FROM
  (SELECT nomeC as "Cinema", Horario_t as 'Melhor Horario', quant as 'Quantidade Maxima'
    FROM HorariosPorCinema
    GROUP BY nomeC
    HAVING MAX(quant))
NATURAL JOIN
  (SELECT nomeC as "Cinema", Horario_t as 'Pior Horario', quant as 'Quantidade Minima'
    FROM HorariosPorCinema
    GROUP BY nomeC
    HAVING MIN(quant));
