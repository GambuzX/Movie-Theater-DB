PRAGMA foreign_keys = ON;
.headers on
.mode columns
.nullvalue NULL

INSERT INTO Pessoa (pessoaID, nome,NIF,telefone,dataNascimento , morada , codigoPostal) values (99, 'Cliente normal' , 215361924 , 9322024419 , '1970-03-08' , 'Rua Indefinida' , '4420-732');
INSERT INTO Pessoa (pessoaID, nome,NIF,telefone,dataNascimento , morada , codigoPostal) values (100, 'Idoso' , 259561924 , 9322024419 , '1970-03-08' , 'Rua Indefinida' , '4420-732');
INSERT INTO Pessoa (pessoaID, nome,NIF,telefone,dataNascimento , morada , codigoPostal) values (101, 'Estudante' , 254011924 , 9322024419 , '1970-03-08' , 'Rua Indefinida' , '4420-732');
INSERT INTO Pessoa (pessoaID, nome,NIF,telefone,dataNascimento , morada , codigoPostal) values (102, 'Crianca' , 291001924 , 9322024419 , '1970-03-08' , 'Rua Indefinida' , '4420-732');

INSERT INTO Cliente (pessoaID) values (99);
INSERT INTO Cliente (pessoaID) values (100);
INSERT INTO Cliente (pessoaID) values (101);
INSERT INTO Cliente (pessoaID) values (102);

SELECT nome as Pessoa, desconto as "Desconto antes" 
FROM Cliente C NATURAL JOIN Pessoa P
WHERE pessoaID=99 OR pessoaID=100 OR pessoaID=101 OR pessoaID=102
UNION ALL 
SELECT " ", " ";

INSERT INTO Membro (clienteID , email,numeroCartao,validadeAdesao,adesao) values (100 , 'generico1@mail.com' , 2 , '2020-04-09' , 3);
INSERT INTO Membro (clienteID , email,numeroCartao,validadeAdesao,adesao) values (101 , 'generico2@mail.com' , 3 , '2019-11-05' , 5);
INSERT INTO Membro (clienteID , email,numeroCartao,validadeAdesao,adesao) values (102 , 'generico3@mail.com' , 4 , '2020-09-17' , 2);


SELECT nome as Pessoa, desconto as "Desconto depois" 
FROM Cliente C NATURAL JOIN Pessoa P 
WHERE pessoaID=99 OR pessoaID=100 OR pessoaID=101 OR pessoaID=102
UNION ALL 
SELECT " ", " ";
