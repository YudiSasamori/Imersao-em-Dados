SELECT * FROM fato.aplicacoes
SELECT * FROM dim.pessoa

SELECT
*
FROM fato.aplicacoes A
INNER JOIN dim.pessoa B ON A.id_pessoa = B.id
