.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS ProdutosPorCategoria;

/*Produtos mais rentaveis a cada categoria*/

CREATE VIEW ProdutosPorCategoria AS
Select Categoria.nome as cat_nome, Produto.nome as prod_nome , Count(Produto.nome) as count
  from  Produto JOIN ProdutoAdquirido JOIN Pedido JOIN Bilhete JOIN Sessao JOIN Filme JOIN FilmeTemCategoria JOIN Categoria
  on Produto.produtoID = ProdutoAdquirido.produto AND ProdutoAdquirido.pedido = Pedido.pedidoID
  AND Pedido.pedidoID = Bilhete.pedido AND Bilhete.sessao = Sessao.sessaoID
  AND Sessao.filme = Filme.filmeID AND Filme.filmeID = FilmeTemCategoria.filme
  AND FilmeTemCategoria.categoria = Categoria.categoriaID Group By Categoria.nome , Produto.nome Order By Categoria.nome,count desc;


Select * from ProdutosPorCategoria;

Select * from
(Select  cat_nome as "Categoria", prod_nome as "Best seller" , MAX(count) as "1º number"
  from ProdutosPorCategoria
  Group By cat_nome)
NATURAL JOIN
(Select  cat_nome as "Categoria", prod_nome as "Second Best seller" , MAX(count) as "2º number"
  from ProdutosPorCategoria
    where
      prod_nome NOT IN (Select prod_nome
                from ProdutosPorCategoria Group By prod_nome HAVING count = Max(count) LIMIT 1)
    Group By cat_nome)
NATURAL JOIN
(Select  cat_nome as "Categoria", prod_nome as "Worst seller", MIN(count) as "Worst number"from ProdutosPorCategoria Group  By cat_nome);
