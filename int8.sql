.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS ProdutosPorCategoria;
DROP VIEW IF EXISTS MelhorProdutoPorCategoria;

/*Produtos mais rentaveis a cada categoria*/

CREATE VIEW ProdutosPorCategoria AS
SELECT Categoria.nome as cat_nome, Produto.nome as prod_nome , SUM(ProdutoAdquirido.quantidade) as contagem
FROM Produto JOIN ProdutoAdquirido JOIN Pedido JOIN Bilhete JOIN Sessao JOIN Filme JOIN FilmeTemCategoria JOIN Categoria
ON Produto.produtoID = ProdutoAdquirido.produto 
AND ProdutoAdquirido.pedido = Pedido.pedidoID
AND Pedido.pedidoID = Bilhete.pedido 
AND Bilhete.sessao = Sessao.sessaoID
AND Sessao.filme = Filme.filmeID 
AND Filme.filmeID = FilmeTemCategoria.filme
AND FilmeTemCategoria.categoria = Categoria.categoriaID 
GROUP BY Categoria.nome , Produto.nome 
ORDER BY Categoria.nome, contagem DESC;

CREATE VIEW MelhorProdutoPorCategoria as 
SELECT cat_nome, prod_nome as prod_nome_1, MAX(contagem) as max_count
FROM ProdutosPorCategoria
GROUP BY cat_nome;

SELECT cat_nome as "Categoria", prod_nome_1 as "Melhor produto", max_count as "Total 1º", 
prod_nome_2 as "Segundo melhor produtor", second_max_count as "Total 2º",
prod_nome_3 as "Pior produto", min_count as "Total pior"
FROM MelhorProdutoPorCategoria
NATURAL JOIN
(SELECT cat_nome, prod_nome as prod_nome_2, MAX(contagem) as second_max_count
  FROM ProdutosPorCategoria PC
    WHERE NOT EXISTS(SELECT *
                      FROM MelhorProdutoPorCategoria MC
                      WHERE PC.cat_nome=MC.cat_nome AND PC.prod_nome=MC.prod_nome_1)
    GROUP BY cat_nome)
NATURAL JOIN
(SELECT cat_nome, prod_nome as prod_nome_3, MIN(contagem) as min_count
  FROM ProdutosPorCategoria 
  GROUP BY cat_nome);