PRAGMA foreign_keys = ON;
.headers on
.mode columns
.nullvalue NULL

INSERT INTO Pessoa (pessoaID, nome,NIF,telefone,dataNascimento , morada , codigoPostal) values (400, 'Joao Aguiar' , 259371924 , 9322024419 , '1970-03-08' , 'Rua Indefinida' , '4420-732');
INSERT INTO Pessoa (pessoaID, nome,NIF,telefone,dataNascimento , morada , codigoPostal) values (401, 'Joao Aguiar' , 259501924 , 9322024419 , '1970-03-08' , 'Rua Indefinida' , '4420-732');
INSERT INTO Pessoa (pessoaID, nome,NIF,telefone,dataNascimento , morada , codigoPostal) values (402, 'Joao Aguiar' , 259735924 , 9322024419 , '1970-03-08' , 'Rua Indefinida' , '4420-732');
INSERT INTO Pessoa (pessoaID, nome,NIF,telefone,dataNascimento , morada , codigoPostal) values (403, 'Joao Aguiar' , 849502738 , 9322024419 , '1970-03-08' , 'Rua Indefinida' , '4420-732');


INSERT INTO Cliente (pessoaID, desconto) VALUES (400, 20);
INSERT INTO Cliente (pessoaID, desconto) VALUES (401, 100);
INSERT INTO Cliente (pessoaID, desconto) VALUES (402, 0);
INSERT INTO Cliente (pessoaID, desconto) VALUES (403, 50);

INSERT INTO Pedido (precoOriginal, precoEfetivo, dataPagamento, postoVenda , funcionario , cliente) values (15, 15, '2019-01-17T17:30', 1 , 4 , 400);
INSERT INTO Pedido (precoOriginal, precoEfetivo, dataPagamento, postoVenda , funcionario , cliente) values (500, 500, '2019-01-17T17:30', 1 , 4 , 401);
INSERT INTO Pedido (precoOriginal, precoEfetivo, dataPagamento, postoVenda , funcionario , cliente) values (12, 12, '2019-01-17T17:30', 1 , 4 , 402);
INSERT INTO Pedido (precoOriginal, precoEfetivo, dataPagamento, postoVenda , funcionario , cliente) values (20, 20, '2019-01-17T17:30', 1 , 4 , 403);


SELECT precoOriginal as "Preco Original", desconto as "Desconto", precoEfetivo as "Preco Efetivo Antes" 
FROM Pedido P INNER JOIN Cliente C ON P.cliente=C.pessoaID
UNION ALL
SELECT " ", " ", " ";

UPDATE Pedido SET precoOriginal=precoOriginal+10;

SELECT precoOriginal as "Preco Original", desconto as "Desconto", precoEfetivo as "Preco Efetivo Depois"
FROM Pedido P INNER JOIN Cliente C ON P.cliente=C.pessoaID
UNION ALL
SELECT " ", " ", " ";