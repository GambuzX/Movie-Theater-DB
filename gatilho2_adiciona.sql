PRAGMA foreign_keys = ON;

CREATE TRIGGER DefineDesconto
AFTER INSERT ON Membro
FOR EACH ROW
BEGIN
    UPDATE Cliente
    SET desconto=(SELECT CASE
                            WHEN tipo='Jovem' THEN 15
                            WHEN tipo='Criança' THEN 25
                            WHEN tipo='Idoso' THEN 10
                            WHEN tipo='Estudante' THEN 30
                            WHEN tipo='Normal' THEN 5
                            ELSE 0
                        END
                    FROM Membro M JOIN Adesao A 
                    WHERE M.clienteID=NEW.clienteID
                    AND NEW.adesao=A.adesaoID)
    WHERE Cliente.pessoaID=NEW.clienteID;
END;