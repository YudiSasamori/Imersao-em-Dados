SELECT
	 B.nm_nome                AS NOME
	,B.nm_sobrenome           AS SOBRENOME
	,C.ds_profissao           AS PROFISSÃO
--	,D.ds_tipo_investimento   AS INVESTIMENTO
--	,E.nm_cor                 AS COR
--	,F.ds_nome                AS FACULDADE
	,MONTH(CAST(G.dt_data AS date))  AS DT_DATA
--	,H.ds_emocao
--	,A.valor                  AS VALOR
	,SUM(VALOR) AS VALOR_TOTAL
FROM fato.aplicacoes        A
INNER JOIN dim.pessoa       B  ON A.id_pessoa = B.id
LEFT JOIN dim.profissao     C  ON A.id_profissao = C.id
LEFT JOIN dim.investimentos D  ON A.id_investimento = D.id
LEFT JOIN dim.cor_preferida E  ON A.id_cor = E.id
LEFT JOIN dim.faculdade     F  ON A.id_faculdade = F.id
LEFT JOIN dim.calendario    G  ON A.id_data = G.id_data
LEFT JOIN dim.emocao        H  ON A.id_emocao = H.id
WHERE 1=1
	AND B.nm_nome = 'Kelvin'
GROUP BY B.nm_nome            
	    ,B.nm_sobrenome          
	    ,C.ds_profissao
		,MONTH(CAST(G.dt_data AS date))
--ORDER BY DT_DATA DESC





SELECT * FROM dim.calendario
SELECT * FROM dim.cor_preferida
SELECT * FROM dim.emocao
SELECT * FROM dim.faculdade
SELECT * FROM dim.investimentos
SELECT * FROM dim.pessoa
SELECT * FROM dim.profissao
SELECT * FROM fato.aplicacoes



SELECT
	 B.nm_nome                AS NOME
	,B.nm_sobrenome           AS SOBRENOME
	,C.ds_profissao           AS PROFISSÃO
	--,A.id_profissao
	,D.ds_tipo_investimento   AS INVESTIMENTO
	--,A.id_investimento
	,E.nm_cor                 AS COR
	--,A.id_cor
	,F.ds_nome                AS FACULDADE
	--,A.id_faculdade
	,CAST(G.dt_data AS date)  AS DT_DATA
	--,A.id_data
	,H.ds_emocao
	--,A.id_emocao
	,A.valor                  AS VALOR
FROM fato.aplicacoes        A
INNER JOIN dim.pessoa        B  ON A.id_pessoa = B.id
LEFT JOIN dim.profissao     C  ON A.id_profissao = C.id
LEFT JOIN dim.investimentos D  ON A.id_investimento = D.id
LEFT JOIN dim.cor_preferida E  ON A.id_cor = E.id
LEFT JOIN dim.faculdade     F  ON A.id_faculdade = F.id
LEFT JOIN dim.calendario    G  ON A.id_data = G.id_data
LEFT JOIN dim.emocao        H  ON A.id_emocao = H.id
WHERE 1=1
	AND B.nm_nome = 'Kelvin'
ORDER BY VALOR DESC
