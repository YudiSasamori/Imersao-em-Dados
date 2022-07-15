/*Quais pessoas que foram mais conservadoras*/


SELECT * FROM dim.calendario
SELECT * FROM dim.cor_preferida
SELECT * FROM dim.emocao
SELECT * FROM dim.faculdade
SELECT * FROM dim.investimentos
SELECT * FROM dim.pessoa
SELECT * FROM dim.profissao
SELECT * FROM fato.aplicacoes




SELECT
	 CONCAT(B.nm_nome, ' ', B.nm_sobrenome)    AS NOME
	,C.ds_tipo_investimento                    AS TIPO_INVESTIMENTO
    ,COUNT(C.ds_tipo_investimento )            AS QTD_APLICAÇÕES
	,SUM(valor)                                AS VALOR_APLICADO
FROM fato.aplicacoes          A
LEFT JOIN dim.pessoa          B    ON A.id_pessoa         = B.id
LEFT JOIN dim.investimentos   C    ON A.id_investimento   = C.id
WHERE 1=1
	AND ds_tipo_investimento IN ('Poupança', 'CDB', 'LCI')
GROUP BY CONCAT(B.nm_nome, ' ', B.nm_sobrenome)
	    ,C.ds_tipo_investimento
ORDER BY VALOR_APLICADO DESC
