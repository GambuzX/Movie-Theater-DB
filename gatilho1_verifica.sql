PRAGMA foreign_keys = ON;

INSERT INTO Sessao (sessaoID, horaInicio, lugaresDisponiveis, sala,filme) values (100, '2019-04-25T12:00', 100 , 1 , 1);

SELECT " " as "Antes de inserir dados: ";
SELECT lugar as "ID de lugares ocupados" FROM LugarOcupado WHERE sessao=100;
SELECT lugaresDisponiveis as "Lugares disponiveis" FROM Sessao WHERE sessaoID=100;


INSERT INTO Bilhete(sessao, lugar, pedido) values (100, 12, 1);

SELECT " " as "Depois de inserir dados: ";
SELECT lugar as "ID de lugares ocupados" FROM LugarOcupado WHERE sessao=100;
SELECT lugaresDisponiveis as "Lugares disponiveis" FROM Sessao WHERE sessaoID=100;
