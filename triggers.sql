PRAGMA foreign_keys = ON;

CREATE TRIGGER DefinePrecoEfetivo
AFTER INSERT ON Pedido
FOR EACH ROW
BEGIN
    UPDATE Pedido
    SET precoEfetivo=precoOriginal * (1 - (SELECT desconto
                                            FROM Pedido P JOIN Cliente C ON P.cliente=C.pessoaID
                                            WHERE P.pedidoID=NEW.pedidoID)) / 100
    WHERE Pedido.pedidoID=NEW.pedidoID;
END;