.mode columns
.headers on
.nullvalue NULL

/* 10 clientes mais fieis por cinema LIMIT 10 (ou 5) (aqueles que foram mais vezes i.e fizeram mais pedidos) */

SELECT PedidosPessoaCliente.nome, COUNT(PedidosPessoaCliente.pedidoID) AS NumeroDePedidos
FROM ((Pedido INNER JOIN Cliente ON Pedido.cliente = Cliente.pessoaID) AS PedidoCliente 
    INNER JOIN Pessoa ON Pessoa.pessoaID = PedidoCliente.pessoaID) AS PedidosPessoaCliente
GROUP BY PedidosPessoaCliente.PessoaID
ORDER BY NumeroDePedidos DESC
LIMIT 10;  