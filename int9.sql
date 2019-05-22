.mode columns
.headers on
.nullvalue NULL

/*Estatisticas realtivamente ao preço original e ao preço efetivos, diferença, percentagem,entre outros.*/
/*so dos descontados*/ 

Select SUM(precoOriginal) as 'Dinheiro Total ' , SUM(precoEfetivo) as  'Dinheiro Efetivo' , 100-100*SUM(precoEfetivo)/SUM(precoOriginal) as 'Percentagem De Dinheiro Descontado' , MAX(tipo) as 'Adesao que mais usufruiu'
  from Pedido JOIN Membro JOIN Adesao on Pedido.cliente = Membro.clienteID AND Membro.adesao = Adesao.adesaoID;
