.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS PedidosPorCinemaPorCliente;
DROP VIEW IF EXISTS MelhorClientePorCinema;

/* 2 clientes mais fieis por cinema (aqueles que foram mais vezes i.e fizeram mais pedidos) */
CREATE VIEW PedidosPorCinemaPorCliente as
SELECT Cin.nome as nomeCinema, P.nome as nomePessoa, COUNT(Ped.pedidoID) as nPedidos
FROM Pedido Ped JOIN Cliente C JOIN Pessoa P JOIN PostoVenda PV JOIN Cinema Cin
WHERE Ped.cliente = C.pessoaID
AND P.pessoaID = C.pessoaID
AND Ped.postoVenda=PV.postoVendaID
AND PV.cinema=Cin.cinemaID
GROUP BY nomeCinema, nomePessoa
ORDER BY nPedidos DESC, nomePessoa ASC;

CREATE VIEW MelhorClientePorCinema as
SELECT nomeCinema, nomePessoa, MAX(nPedidos) as maxPedidos
FROM PedidosPorCinemaPorCliente
GROUP BY nomeCinema;


SELECT nomeCinema as "Cinema", nomePessoa as "Melhor cliente", maxPedidos as "Num pedidos 1", segundoMelhor as "Segundo melhor cliente", pedidos2 as "Num pedidos 2"
FROM
    MelhorClientePorCinema
NATURAL JOIN
    (SELECT nomeCinema, nomePessoa as segundoMelhor, MAX(nPedidos) as pedidos2
    FROM (SELECT *
            FROM PedidosPorCinemaPorCliente T
            WHERE NOT EXISTS (SELECT *
                                FROM MelhorClientePorCinema M
                                WHERE T.nomeCinema=M.nomeCinema AND T.nomePessoa=nomePessoa))
    GROUP BY nomeCinema)
ORDER BY nomeCinema;