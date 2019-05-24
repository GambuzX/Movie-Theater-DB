PRAGMA foreign_keys = ON;
.headers on
.mode columns
.nullvalue NULL

INSERT INTO Sessao (sessaoID, horaInicio, lugaresDisponiveis, sala,filme) values (100, '2019-04-25T12:00', 100 , 1 , 1);

SELECT lugar as "ID lugares ocupados antes" FROM LugarOcupado WHERE sessao=100 UNION SELECT " ";
SELECT lugaresDisponiveis as "Num lugares disponiveis antes" FROM Sessao WHERE sessaoID=100 UNION SELECT " ";


INSERT INTO Bilhete(sessao, lugar, pedido) values (100, 12, 1);
INSERT INTO Bilhete(sessao, lugar, pedido) values (100, 13, 1);

SELECT lugar as "ID lugares ocupados depois" FROM LugarOcupado WHERE sessao=100 UNION SELECT " ";
SELECT lugaresDisponiveis as "Num lugares disponiveis depois" FROM Sessao WHERE sessaoID=100 UNION SELECT " ";
