.mode columns
.headers on
.nullvalue NULL

/* Estatisticas para cada Adesão relativamente ao preço original e ao preço efetivos, diferença, percentagem, entre outros. */

SELECT Adesao.tipo as "Adesão", 
       SUM(precoOriginal) as 'Dinheiro Total',
       SUM(precoEfetivo) as 'Dinheiro Efetivo',
       100-100*SUM(precoEfetivo)/SUM(precoOriginal) as 'Percentagem De Dinheiro Descontado'
  FROM Pedido JOIN Membro JOIN Adesao
  ON Pedido.cliente = Membro.clienteID 
  AND Membro.adesao = Adesao.adesaoID
  GROUP BY Adesao.tipo
  ORDER BY Adesao.tipo;
