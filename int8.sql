.mode columns
.headers on
.nullvalue NULL


/*Produtos mais rentaveis a cada categoria*/


Select Produto.nome as nome, Max(Categoria.nome) as max_cat , MIN(Categoria.nome) as min_cat
  from  Produto JOIN ProdutoAdquirido JOIN Pedido JOIN Bilhete JOIN Sessao JOIN Filme JOIN FilmeTemCategoria JOIN Categoria
  on Produto.produtoID = ProdutoAdquirido.produto AND ProdutoAdquirido.pedido = Pedido.pedidoID
  AND Pedido.pedidoID = Bilhete.pedido AND Bilhete.sessao = Sessao.sessaoID
  AND Sessao.filme = Filme.filmeID AND Filme.filmeID = FilmeTemCategoria.filme Group  by Produto.nome;
