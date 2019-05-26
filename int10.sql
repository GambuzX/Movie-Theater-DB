.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS MelhoresLugaresSala;
DROP VIEW IF EXISTS MelhoresLugaresSalaCin;

/*Selecionar lugares preferidos por cada sala por cada cinema*/
/*Lugares com mais bilhetes comprados */

/*Limit OFFSET || */

CREATE VIEW MelhoresLugaresSala AS 
SELECT BilheteLugar.sala, BilheteLugar.fila, BilheteLugar.numero, COUNT(pedido) AS NumPedidos
 from (bilhete INNER JOIN lugar ON bilhete.lugar = lugar.lugarID) AS BilheteLugar 
 GROUP BY BilheteLugar.lugarID ORDER BY NumPedidos DESC; 

CREATE VIEW MelhoresLugaresSalaCin AS
SELECT * FROM  (SELECT cinema.nome,cinema.cinemaID FROM cinema) as Cin
INNER JOIN (( SELECT cinema,salaID AS NumSala FROM sala) AS SalaRec
 INNER JOIN MelhoresLugaresSala ON SalaRec.NumSala = MelhoresLugaresSala.sala) AS SalaCin ON Cin.cinemaID = SalaCin.cinema
 ORDER BY MelhoresLugaresSala.sala DESC;  

SELECT nome,NumSala,fila,numero,NumPedidos FROM MelhoresLugaresSalaCin;
