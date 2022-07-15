/* Em toda Base quem foi (foram) a(as) pessoa(as) mais felizes e as mais triste */


SELECT * FROM dim.calendario
SELECT * FROM dim.cor_preferida
SELECT * FROM dim.emocao
SELECT * FROM dim.faculdade
SELECT * FROM dim.investimentos
SELECT * FROM dim.pessoa
SELECT * FROM dim.profissao
SELECT * FROM fato.aplicacoes


SELECT
	 B.nm_nome          AS NOME
	,C.ds_emocao        AS EMOÇÃO
	,COUNT(C.ds_emocao) AS QTD_EMOÇÃO
FROM fato.aplicacoes    A
LEFT JOIN dim.pessoa    B    ON A.id_pessoa    = B.id
LEFT JOIN dim.emocao    C    ON A.id_emocao    = C.id
WHERE 1=1
	AND ds_emocao IN ('Feliz', 'Triste')
GROUP BY   B.nm_nome
          ,C.ds_emocao
HAVING(COUNT(C.ds_emocao)) >= '5'
ORDER BY COUNT(C.ds_emocao) DESC



CASE C.ds_emocao
	WHEN COUNT(C.ds_emocao) = 'Triste' THEN 
	WHEN COUNT(C.ds_emocao) >= 5 THEN 'TRISTE'


