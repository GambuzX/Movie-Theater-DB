.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS HorariosPorCinema;

/*Periodos de tempo que tem mais adesao por cinema*/
/*
SELECT
  Case
    When time(horaInicio) >= '08:00:00' AND time(horaInicio) <= '13:00:00' then 'Manhã'
    When time(horaInicio) >= '13:00:00' AND time(horaInicio) <= '20:00:00' then 'Tarde'
    Else 'Noite'End Horario,
    time(horaInicio)
    FROM Sessao;*/
/*
    SELECT Case
      When time(horaInicio) >= '08:00:00' AND time(horaInicio) <= '13:00:00' then 'Manhã'
      When time(horaInicio) >= '13:00:00' AND time(horaInicio) <= '20:00:00' then 'Tarde'
      Else 'Noite'End Horario_t,
      time(horaInicio),
      Cinema.nome as Cinema
      from Sessao INNER JOIN sala on Sessao.sala = Sala.salaID INNER JOIN Cinema on Sala.cinema = Cinema.cinemaID;*/
CREATE VIEW HorariosPorCinema AS
SELECT Cinema,Horario_t ,  Count(Horario_t) as Count from
  (SELECT Case
    When time(horaInicio) >= '07:00:00' AND time(horaInicio) <= '11:00:00' then 'Inicio da Manhã'
    When time(horaInicio) >= '11:00:00' AND time(horaInicio) <= '13:00:00' then 'Fim da Manhã'
    When time(horaInicio) >= '13:00:00' AND time(horaInicio) <= '16:00:00' then 'Inicio da Tarde'
    When time(horaInicio) >= '16:00:00' AND time(horaInicio) <= '17:30:00' then 'Meio da Tarde'
    When time(horaInicio) >= '17:30:00' AND time(horaInicio) <= '19:30:00' then 'Fim da Tarde'
    When time(horaInicio) >= '19:30:00' AND time(horaInicio) <= '22:00:00' then 'Noite'
    Else 'Madrugada'End Horario_t,
    Cinema.nome as Cinema
    from Sessao INNER JOIN sala on Sessao.sala = Sala.salaID INNER JOIN Cinema on Sala.cinema = Cinema.cinemaID) Group By Cinema , Horario_t
     ORDER By Cinema ASC , Count DESC;

Select * from
(SELECT Cinema, Horario_t as 'Melhor Horario', Count as 'Quantidade Maxima'
  from HorariosPorCinema
  Group by Cinema
  HAVING Max(Count))
NATURAL JOIN
(SELECT Cinema, Horario_t as 'Pior Horario', Count as 'Quantidade Minima'
  from HorariosPorCinema
  Group by Cinema
  HAVING Min(Count))
