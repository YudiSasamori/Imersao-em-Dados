SELECT * FROM fato.aplicacoes
SELECT * FROM dim.pessoa


SELECT
*
FROM fato.aplicacoes A
RIGHT JOIN dim.pessoa B ON A.id_pessoa = B.id



SELECT
*
FROM fato.aplicacoes A
LEFT JOIN dim.pessoa B ON A.id_pessoa = B.id

