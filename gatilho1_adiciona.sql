PRAGMA foreign_keys = ON;

CREATE TRIGGER CompraBilhete
AFTER INSERT ON Bilhete
FOR EACH ROW
BEGIN
    INSERT INTO LugarOcupado(sessao, lugar) VALUES(New.sessao, New.lugar);

    UPDATE Sessao
    SET lugaresDisponiveis=lugaresDisponiveis-1
    WHERE sessaoID=New.sessao;
END;